import {Document} from "mongoose"

export interface ITweetInterface extends Document{
    tweetId: string,
    content: string,
    adminId: string,
    createdAt: string
}