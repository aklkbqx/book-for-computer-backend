FROM oven/bun:latest

WORKDIR /app

COPY package.json bun.lockb* ./

RUN bun install

COPY . .

RUN bunx prisma generate

EXPOSE 5001

CMD ["bun", "run", "src/index.ts"]