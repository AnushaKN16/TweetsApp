import {Router} from "express"
import userRouter from "./user.routes"
import tweetRouter from "./tweet.routes"

const router = Router()

router.use("/user", userRouter)
router.use("tweet",tweetRouter)


export default router