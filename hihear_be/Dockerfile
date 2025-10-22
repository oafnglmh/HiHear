# =========================
# STAGE 1: Build
# =========================
FROM node:22-slim AS builder
WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build

# =========================
# STAGE 2: Production
# =========================
FROM node:22-slim
ARG PORT=80
WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y netcat-openbsd bash && rm -rf /var/lib/apt/lists/*


COPY --from=builder /app/dist ./dist

COPY --from=builder /app/node_modules ./node_modules

COPY package*.json ./
COPY start.sh ./start.sh
COPY .env ./.env

RUN chmod +x ./start.sh

EXPOSE $PORT

CMD ["bash", "./start.sh"]
