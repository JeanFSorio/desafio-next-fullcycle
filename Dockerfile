FROM node:lts-bullseye-slim as base

FROM base AS deps
WORKDIR /app

# Install dependencies based on the preferred package manager
COPY package.json package-lock.json ./
RUN \
    if [ -f package-lock.json]; then npm ci; \
    else echo "lockfile not found" && npm install; \
    fi
RUN npm install -g @prisma/client

# Rebuild the source code only when needed
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npx prisma generate
RUN npm run build

# Development stage
FROM base as runner
WORKDIR /app
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY --from=builder /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/prisma ./prisma
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static


USER nextjs
#RUN chown ug+w /app/prisma ./prisma/dev.db

EXPOSE 3000

ENV PORT 3000

CMD ["node", "server.js"]