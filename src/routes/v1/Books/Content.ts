import Elysia from "elysia";
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

const app = new Elysia()
    .post("/add", async ({ request, set }) => {
        if (!request.headers.get("content-type")?.includes("multipart/form-data")) {
            set.status = 400;
            return {
                success: false,
                message: "Content type must be multipart/form-data"
            };
        }
        const formData = await request.formData();
        const book_id = formData.get("book_id") as string;
        const type = formData.get("type") as "data" | "topic";

        console.log(type);

        try {
            const filePaths: { [key: string]: string } = {};
            let content: any;
            for (const [key, val] of formData.entries()) {
                const dataMatch = key.match(/^content\[(\d+)\]\[image\]$/);
                const topicMatch = key.match(/^chapters\[(\d+)\]\[sections\]\[(\d+)\]\[content\]\[(\d+)\]\[image\]$/);
                if ((dataMatch || topicMatch) && val instanceof File) {
                    const file = val as File;
                    const fileName = `${Date.now()}-${file.name}`;
                    const filePath = `public/content_images/${fileName}`;
                    await Bun.write(filePath, await file.arrayBuffer());
                    const fileUrl = `/content_images/${fileName}`;
                    filePaths[key] = fileUrl;
                }
            }

            if (type === "data") {
                content = [];
                for (const [key, val] of formData.entries()) {
                    const match = key.match(/^content\[(\d+)\]\[(\w+)\]$/);
                    if (match) {
                        const index = parseInt(match[1], 10);
                        const property = match[2];
                        if (!content[index]) {
                            content[index] = { text: '', image: '' };
                        }
                        if (property === 'text') {
                            content[index].text = val as string;
                        } else if (property === 'image') {
                            content[index].image = filePaths[key] || '';
                        }
                    }
                }
            } else if (type === "topic") {
                content = [];
                for (const [key, val] of formData.entries()) {
                    const chapterMatch = key.match(/^chapters\[(\d+)\]\[(\w+)\]$/);
                    const sectionMatch = key.match(/^chapters\[(\d+)\]\[sections\]\[(\d+)\]\[(\w+)\]$/);
                    const contentMatch = key.match(/^chapters\[(\d+)\]\[sections\]\[(\d+)\]\[content\]\[(\d+)\]\[(\w+)\]$/);
                    const imageCreditMatch = key.match(/^chapters\[(\d+)\]\[sections\]\[(\d+)\]\[content\]\[(\d+)\]\[imageCredit\]\[(\w+)\]$/);

                    if (chapterMatch) {
                        const chapterIndex = parseInt(chapterMatch[1], 10);
                        const property = chapterMatch[2];
                        if (!content[chapterIndex]) content[chapterIndex] = { sections: [] };
                        content[chapterIndex][property] = val as string;
                    } else if (sectionMatch) {
                        const chapterIndex = parseInt(sectionMatch[1], 10);
                        const sectionIndex = parseInt(sectionMatch[2], 10);
                        const property = sectionMatch[3];
                        if (!content[chapterIndex].sections[sectionIndex]) content[chapterIndex].sections[sectionIndex] = { content: [] };
                        content[chapterIndex].sections[sectionIndex][property] = val as string;
                    } else if (contentMatch) {
                        const chapterIndex = parseInt(contentMatch[1], 10);
                        const sectionIndex = parseInt(contentMatch[2], 10);
                        const contentIndex = parseInt(contentMatch[3], 10);
                        const property = contentMatch[4];
                        if (!content[chapterIndex].sections[sectionIndex].content[contentIndex]) {
                            content[chapterIndex].sections[sectionIndex].content[contentIndex] = { imageCredit: {} };
                        }
                        if (property === 'image') {
                            content[chapterIndex].sections[sectionIndex].content[contentIndex][property] = filePaths[key] || '';
                        } else {
                            content[chapterIndex].sections[sectionIndex].content[contentIndex][property] = val as string;
                        }
                    } else if (imageCreditMatch) {
                        const chapterIndex = parseInt(imageCreditMatch[1], 10);
                        const sectionIndex = parseInt(imageCreditMatch[2], 10);
                        const contentIndex = parseInt(imageCreditMatch[3], 10);
                        const creditProperty = imageCreditMatch[4];
                        if (!content[chapterIndex].sections[sectionIndex].content[contentIndex].imageCredit) {
                            content[chapterIndex].sections[sectionIndex].content[contentIndex].imageCredit = {};
                        }
                        content[chapterIndex].sections[sectionIndex].content[contentIndex].imageCredit[creditProperty] = val as string;
                    }
                }
            } else {
                set.status = 400;
                return {
                    success: false,
                    message: "Invalid book type"
                };
            }

            const newContent = await prisma.bookContents.create({
                data: {
                    book_id: parseInt(book_id),
                    content: content,
                    type: type
                },
            });

            set.status = 200;
            return {
                success: true,
                message: `${type === "data" ? "Data" : "Chapter-based"} book content added successfully`,
                content: newContent
            };

        } catch (error) {
            set.status = 500;
            return {
                success: false,
                message: `Something went wrong: ${(error as Error).message}`
            }
        }
    })
    .get('/:id', async ({ params, set }) => {
        const { id } = params;
        try {
            const bookId = parseInt(id);
            const books = await prisma.bookContents.findMany({
                where: { book_id: bookId ? Number(bookId) : undefined }
            });
            set.status = 200;
            return {
                success: true,
                books,
                type: books.length > 0 ? books[0].type : null
            }
        } catch (error) {
            set.status = 500;
            return {
                success: false,
                message: `Something went wrong: ${(error as Error).message}`
            }
        }
    });

export default app;