import { Router } from "express";
import {
  createTweetController,
  deleteTweetController,
  getAllTweetsController,
  getTweetController,
  updateTweetController,
} from "../controllers/tweet.controller";

const tweetRouter = Router();

tweetRouter.get("/:tweetId", getTweetController);
tweetRouter.get("/all", getAllTweetsController);
tweetRouter.post("/", createTweetController);
tweetRouter.put("/", updateTweetController);
tweetRouter.delete("/:tweetId", deleteTweetController);

export default tweetRouter;
