## Desafio Next FullCycle

### Getting Started

First, run the development server, just make sure the port 3000 isn't being used:

```bash
npm run dev
# or
yarn dev
# or
pnpm dev
```

You can also use docker or docker compose
```bash
docker build -t desafio-next .
docker run -p 3000:3000 desafio-next
# or
docker-compose up
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

[API routes](https://nextjs.org/docs/api-routes/introduction) can be accessed on [http://localhost:3000/api/chats](http://localhost:3000/api/chats).

There is a POST and a GET in chats, in the api.http file are two basic routines to try it.
