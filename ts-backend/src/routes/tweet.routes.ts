import { Router } from "express";
import {
  createTweetController,
  deleteTweetController,
  getTweetController,
  updateTweetController,
} from "../controllers/tweet.controller";

const tweetRouter = Router();

tweetRouter.get("/:tweetId", getTweetController);
// tweetRouter.get("/", getAllTweetsController);
tweetRouter.post("/", createTweetController);
tweetRouter.put("/", updateTweetController);
tweetRouter.delete("/:tweetId", deleteTweetController);

export default tweetRouter;
