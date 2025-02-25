import { Elysia, t } from 'elysia';
import { Prisma, PrismaClient, TypeBook } from '@prisma/client';
import Content from "./Content"
import { unlink } from "node:fs/promises";

const prisma = new PrismaClient();

const app = new Elysia()
    .get("/", async ({ set }) => {
        try {
            const books = await prisma.books.findMany();
            if (!books) {
                set.status = 404;
                return {
                    success: false,
                    message: "fail",
                    data: null
                }
            }
            set.status = 200;
            return books;
        } catch (error) {
            set.status = 500;
            return {
                success: false,
                message: `Something went wrong: ${(error as Error).message}`
            }
        }
    })
    .get("/:id", async ({ set, params }) => {
        const { id } = params;
        try {
            const bookId = parseInt(id);

            if (isNaN(bookId)) {
                set.status = 400;
                return {
                    success: false,
                    message: "Invalid book ID"
                };
            }
            const books = await prisma.books.findUnique({
                where: { book_id: bookId }
            });
            if (!books) {
                set.status = 404;
                return {
                    success: false,
                    message: "fail",
                    data: null
                }
            }
            set.status = 200;
            return books;
        } catch (error) {
            set.status = 500;
            return {
                success: false,
                message: `Something went wrong: ${(error as Error).message}`
            }
        }
    })
    .post("add", async ({ request, set }) => {
        if (!request.headers.get("content-type")?.includes("multipart/form-data")) {
            set.status = 400;
            return {
                success: false,
                message: "Content type must be multipart/form-data"
            };
        }
        const formData = await request.formData();
        const file = formData.get("book_image") as File | null;
        const th_name = formData.get("th_name") as string;
        const eng_name = formData.get("eng_name") as string;
        const color = formData.get("color") as string;
        const type = formData.get("type") as string;

        if (!file || !th_name || !eng_name || !color || !type) {
            set.status = 400;
            return {
                success: false,
                message: "Missing required fields"
            };
        }
        try {
            const fileName = `${Date.now()}-${file.name}`;
            const filePath = `public/book_images/${fileName}`;
            await Bun.write(filePath, await file.arrayBuffer());
            const fileUrl = `/book_images/${fileName}`;

            const bookType = TypeBook[type as keyof typeof TypeBook];
            const newBook = await prisma.books.create({
                data: {
                    th_name,
                    eng_name,
                    color,
                    book_image: fileUrl,
                    type: bookType
                },
            });

            set.status = 201;
            return {
                success: true,
                message: "Book created successfully",
                data: newBook
            };
        } catch (error) {
            set.status = 500;
            return {
                success: false,
                message: `Something went wrong: ${(error as Error).message}`
            }
        }
    })
    .patch("update/:id", async ({ params, set, request }) => {
        const { id } = params;
        if (!request.headers.get("content-type")?.includes("multipart/form-data")) {
            set.status = 400;
            return {
                success: false,
                message: "Content type must be multipart/form-data",
            };
        }
        const formData = await request.formData();
        const file = formData.get("book_image") as File | null;
        const th_name = formData.get("th_name") as string | null;
        const eng_name = formData.get("eng_name") as string | null;
        try {
            const updateData: any = {};
            if (th_name) updateData.th_name = th_name;
            if (eng_name) updateData.eng_name = eng_name;

            const existingBook = await prisma.books.findUnique({
                where: { book_id: parseInt(id) },
            });

            if (!existingBook) {
                set.status = 404;
                return {
                    success: false,
                    message: "Book not found",
                };
            }

            if (file) {
                const oldFilePath = `public${existingBook.book_image}`;
                try {
                    if (existingBook.book_image) {
                        await unlink(oldFilePath);
                    }
                } catch (error) {
                    console.error(`Error deleting file: ${error}`);
                }

                const fileName = `${Date.now()}-${file.name}`;
                const filePath = `public/book_images/${fileName}`;
                await Bun.write(filePath, await file.arrayBuffer());
                const fileUrl = `/book_images/${fileName}`;
                updateData.book_image = fileUrl;
            }

            if (Object.keys(updateData).length === 0) {
                set.status = 400;
                return {
                    success: false,
                    message: "No fields provided for update",
                };
            }
            const updatedBook = await prisma.books.update({
                where: { book_id: parseInt(id) },
                data: updateData,
            });

            set.status = 200;
            return {
                success: true,
                message: "Book updated successfully",
                data: updatedBook,
            };
        } catch (error) {
            set.status = 500;
            return {
                success: false,
                message: `Something went wrong: ${(error as Error).message}`
            }
        }
    })
    .delete("delete/:id", async ({ params, set }) => {
        const { id } = params;
        try {
            const bookId = parseInt(id);

            if (isNaN(bookId)) {
                set.status = 400;
                return {
                    success: false,
                    message: "Invalid book ID"
                };
            }

            const existingBook = await prisma.books.findUnique({
                where: { book_id: parseInt(id) },
            });

            if (!existingBook) {
                set.status = 404;
                return {
                    success: false,
                    message: "Book not found",
                };
            }

            if (existingBook.book_image) {
                const oldFilePath = `public${existingBook.book_image}`;
                try {
                    if (existingBook.book_image) {
                        await unlink(oldFilePath);
                    }
                } catch (error) {
                    console.error(`Error deleting file: ${error}`);
                }
            }

            const deletedBook = await prisma.books.delete({
                where: { book_id: bookId },
            });

            if (!deletedBook) {
                set.status = 404;
                return {
                    success: false,
                    message: "Book not found"
                };
            }

            set.status = 200;
            return {
                success: true,
                message: "Book deleted successfully",
                data: deletedBook
            };
        } catch (error) {
            if (error instanceof Prisma.PrismaClientKnownRequestError && error.code === 'P2025') {
                set.status = 404;
                return {
                    success: false,
                    message: "Book not found"
                };
            }

            set.status = 500;
            return {
                success: false,
                message: `Something went wrong: ${(error as Error).message}`
            };
        }
    }, {
        params: t.Object({
            id: t.String()
        })
    })
    .group("/content", (app) => app.use(Content))

export default app;
