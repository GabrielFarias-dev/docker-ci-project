FROM node:20-alpine AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --omit=dev

FROM node:20-alpine
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY package.json ./
COPY src ./src
RUN mkdir -p /etc/todos && chown -R node:node /etc/todos
EXPOSE 3000
USER node
CMD ["node", "src/index.js"]
