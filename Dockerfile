FROM oven/bun:latest
# ตั้งค่า working directory ใน container
WORKDIR /app

# คัดลอกไฟล์ package.json และ bun.lockb (ถ้ามี) ไปยัง working directory
COPY package.json bun.lockb* ./

# ติดตั้ง dependencies
RUN bun install

# คัดลอกโค้ดของแอปพลิเคชันทั้งหมด
COPY . .

RUN bunx prisma generate

# เปิด port ที่แอปพลิเคชันใช้ (เปลี่ยนตามที่คุณต้องการ)
EXPOSE 5001

# รันคำสั่งเพื่อเริ่มแอปพลิเคชัน
CMD ["bun", "run", "src/index.ts"]