// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
import type { NextApiRequest, NextApiResponse } from 'next'
import { prisma } from "../../prisma"

type Data = {
  name: string
}

const handler = async (req: NextApiRequest, res: NextApiResponse) => {

    if (req.method == "POST") {
        const { message } = req.body;
        const chat = await prisma.chat.create({
            data: {
                message,
            },
        })
        res.status(200).json(chat)
    } 
    else if (req.method == "GET") {
        const chats = await prisma.chat.findMany();
        res.json(chats)
    } else {
        res.status(405).json({ message: "Not Allowed"})
    }

}

export default handler;