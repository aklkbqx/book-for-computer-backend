import { Elysia, t } from 'elysia';
import { PrismaClient } from '@prisma/client';
import { jwt } from '@elysiajs/jwt';

const prisma = new PrismaClient();
const SECRET_KEY = process.env.SECRET_KEY;

if (!SECRET_KEY) {
    throw new Error('SECRET_KEY is not defined.');
}

type JWTPayload = {
    user_id: number;
    role: string;
}

const app = new Elysia()
    .use(jwt({ name: 'jwt', secret: SECRET_KEY }))
    .get('/me', async ({ headers, jwt, set }) => {
        try {
            const token = headers.authorization?.split("Bearer")[1].trim()
            if (!token) {
                set.status = 401;
                return { success: false, message: "No token provided" };
            }
            const payload = await jwt.verify(token) as JWTPayload;
            if (!payload) {
                set.status = 401;
                return { success: false, message: "Invalid token" };
            }
            const user = await prisma.users.findUnique({
                where: { user_id: payload.user_id }
            });
            if (!user) {
                set.status = 404;
                return {
                    success: false,
                    message: "authenticator fail"
                };
            }
            return user;
        } catch (error) {
            set.status = 500;
            return {
                success: false,
                message: `Something went wrong: ${(error as Error).message}`
            };
        }
    });

export default app;