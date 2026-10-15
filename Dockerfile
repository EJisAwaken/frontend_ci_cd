FROM node:22-alpine AS build
WORKDIR /app
COPY package*.json ./
COPY . .
RUN npm ci
RUN npm run build

FROM node:22-alpine AS production

WORKDIR /app
ENV PORT=80
COPY --from=build /app/.next/standalone ./
COPY --from=build /app/.next/static ./.next/static
COPY --from=build /app/public ./public

EXPOSE 80

CMD ["node", "server.js"]





