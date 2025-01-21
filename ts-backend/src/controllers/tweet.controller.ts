import { Request, Response } from "express";
import {
  getTweetRepo,
  createTweetRepo,
  deleteTweetRepo,
  updateTweetRepo,
} from "../repositories/tweet.repository";
import { ITweetInterface } from "../database/interface/tweet.interface";
import { error } from "console";
import {
  updateUserWithTweetIdRepo,
  updateUserWithTweetIdRepoDeletion,
} from "../repositories/user.repository";
import TweetModel from "../database/model/tweet.model";

export const getTweetController = async (req: Request, res: Response) => {
  const tweetId = req.query.tweetId as string;

  try {
    const tweet = await getTweetRepo(tweetId);
    if (tweet) {
      res.status(200).json({ data: tweet });
    } else {
      res.status(500).json({ error: "Tweet not found" });
    }
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: error });
  }
};

export const createTweetController = async (req: Request, res: Response) => {
  const tweet: ITweetInterface = req.body;

  try {
    const success = await createTweetRepo(tweet);
    if (success) {
      const userUpdateSuccess = await updateUserWithTweetIdRepo(
        tweet.adminId,
        tweet.tweetId
      );
      if (userUpdateSuccess) {
        res.status(200).json({ data: tweet });
      } else {
        res.status(500).json({ error: "User not updated" });
      }
    } else {
      res.status(500).json({ error: "Tweet not created" });
    }
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: error });
  }
};

export const deleteTweetController = async (req: Request, res: Response) => {
  const tweetId = req.params.tweetId as string;
  // const requestedTweet = TweetModel.findById({ tweetId: tweetId });

  try {
    // console.log(requestedTweet);

    const tweet = await deleteTweetRepo(tweetId);

    if (tweet) {
      // const userUpdateSuccess = await updateUserWithTweetIdRepoDeletion(requestedTweet.adminId, tweetId
      // );
      res.status(200).json({ data: "Tweet deleted" });
    } else {
      res.status(500).json({ error: "Tweet not found" });
    }
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: error });
  }
};

export const updateTweetController = async (req: Request, res: Response) => {
  const updatedTweet: ITweetInterface = req.body;

  try {
    const success = await updateTweetRepo(updatedTweet.tweetId, updatedTweet);
    if (success) {
      res.status(200).json({ data: updatedTweet });
    } else {
      res.status(500).json({ error: "Tweet not updated" });
    }
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: error });
  }
};
