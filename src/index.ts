import { Elysia } from 'elysia';
import { log } from 'console';
import dotenv from 'dotenv';
import cors from '@elysiajs/cors';
import { staticPlugin } from '@elysiajs/static';
import apiRouteV1 from './routes/v1';
import { swagger } from '@elysiajs/swagger'

dotenv.config();
const port = process.env.API_PORT || 3000;

const app = new Elysia()
    .use(swagger())
    .use(cors({
        origin: '*',
        methods: ['GET', 'POST', 'PATCH', 'DELETE'],
        allowedHeaders: ['Content-Type', 'Authorization'],
        credentials: true,
        maxAge: 3600
    }))
    .use(staticPlugin({
        assets: 'public',
        prefix: '/'
    }))
    .get('/test', () => ({ text: 'hello world' }))
    .group("/api", (app) => app.use(apiRouteV1))
    .onError(({ code, error, set }) => {
        log(`Error ${code}: ${error.message}`);
        set.status = code === 'NOT_FOUND' ? 404 : 500;
        return {
            success: false,
            message: code === 'NOT_FOUND' ? 'Not Found' : 'Internal Server Error',
            error: process.env.NODE_ENV === 'production' ? null : error.message
        };
    })
    .listen(port, () => {
        log(`🦊 Elysia is running at http://localhost:${port}`);
    });

export default app;