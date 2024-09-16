import { Elysia, t } from 'elysia';
import { PrismaClient, Prisma } from '@prisma/client';
import { jwt } from '@elysiajs/jwt';

const prisma = new PrismaClient();
const SECRET_KEY = process.env.SECRET_KEY;

if (!SECRET_KEY) {
    throw new Error('SECRET_KEY is not defined.');
}

const app = new Elysia()
    .use(jwt({ name: 'jwt', secret: SECRET_KEY }))
    .post('/register', async ({ body, jwt, set }) => {
        const { firstname, lastname, email, password } = body;
        try {
            const hashedPassword = await Bun.password.hash(password);
            const newUser = await prisma.users.create({
                data: {
                    firstname,
                    lastname,
                    email,
                    password: hashedPassword,
                },
            });
            const token = await jwt.sign({ user_id: newUser.user_id, role: newUser.role });
            set.status = 201;
            return {
                success: true,
                user_id: newUser.user_id,
                token,
                role: newUser.role,
                message: 'สมัครสมาชิกเสร็จสิ้น!',
            };
        } catch (error) {
            console.error('Registration error:', error);
            if (error instanceof Prisma.PrismaClientKnownRequestError) {
                if (error.code === 'P2002') {
                    set.status = 400;
                    return { success: false, message: 'มีอีเมลนี้อยู่ในระบบอยู่แล้ว\nกรุณาเปลี่ยนอีเมล หรือทำการเข้าสู่ระบบ' };
                }
            }
            set.status = 500;
            return { success: false, message: 'ข้อผิดพลาดของเซิร์ฟเวอร์ภายใน', error: (error as Error).message }; // ส่ง error message กลับไปด้วย
        }
    }, {
        body: t.Object({
            firstname: t.String(),
            lastname: t.String(),
            email: t.String(),
            password: t.String(),
        })
    })
    .post('/login', async ({ body, jwt, set }) => {
        const { email, password } = body;
        try {
            const user = await prisma.users.findUnique({
                where: { email }
            });
            if (!user) {
                set.status = 401;
                return {
                    success: false,
                    message: "ไม่มีข้อมูลของคุณในระบบ."
                };
            }
            const isPasswordValid = await Bun.password.verify(password, user.password);
            if (!isPasswordValid) {
                set.status = 401;
                return {
                    success: false,
                    message: "รหัสผ่านไม่ถูกต้อง."
                };
            }
            const token = await jwt.sign({ user_id: user.user_id, role: user.role });
            return {
                success: true,
                token,
                role: user.role,
                message: "เข้าสู่ระบบเสร็จสิ้น!"
            };
        } catch (error) {
            set.status = 500;
            return {
                success: false,
                message: `Something went wrong: ${(error as Error).message}`
            };
        }
    }, {
        body: t.Object({
            email: t.String(),
            password: t.String(),
        })
    });

export default app;