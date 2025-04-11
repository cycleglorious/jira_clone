FROM node:22-alpine AS base
LABEL org.opencontainers.image.source=https://github.com/cycleglorious/jira_clone

FROM base AS deps
WORKDIR /app

COPY package*.json ./
RUN npm ci

# Lint
FROM deps AS lint 
WORKDIR /app
COPY . .

RUN npx prisma generate
RUN npm run lint

# Run tests
FROM deps AS test 
WORKDIR /app
COPY . .

RUN npm run test -- run 


# Build
FROM deps AS builder
RUN apk add --no-cache openssl

WORKDIR /app
COPY . .

RUN npx prisma generate
RUN npm run build

FROM base AS runner
RUN apk add --no-cache openssl libc6-compat

WORKDIR /app

ENV NODE_ENV="production"
ENV NEXT_TELEMETRY_DISABLED=1

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static
COPY --from=builder --chown=nextjs:nodejs /app/prisma ./prisma

RUN rm .env

COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

USER nextjs
EXPOSE 3000 
ENV PORT="3000"
ENV HOSTNAME="0.0.0.0"

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["node", "server.js"]
