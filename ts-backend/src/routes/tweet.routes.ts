import {Router} from "express"

const tweetRouter = Router()


tweetRouter.get("/:tweetId", getTweetController)
tweetRouter.get("/", getAllTweetsController)
tweetRouter.post("/", createTweetController)
tweetRouter.put("/", updateTweetController )
tweetRouter.delete("/:tweetId", deleteTweetController)


export default tweetRouter
