import mongoose from "mongoose";
import TweetModel from "../database/model/tweet.model";
import { ITweetInterface } from "../database/interface/tweet.interface";

export const getTweetRepo = async (
  tweetId: String
): Promise<ITweetInterface | null> => {
  try {
    const tweet = await TweetModel.findOne({ uid: tweetId });
    return tweet;
  } catch (error) {
    console.log(error);
    return null;
  }
};

export const deleteTweetRepo = async (tweetId: String): Promise<boolean> => {
  try {
    const tweetDeleted = await TweetModel.findOneAndDelete({ uid: tweetId });
    if (tweetDeleted) {
      return true;
    } else {
      return false;
    }
  } catch (error) {
    console.log(error);
    return false;
  }
};

export const createTweetRepo = async (
  tweet: ITweetInterface
): Promise<boolean> => {
  try {
    await TweetModel.create(tweet);
    return true;
  } catch (error) {
    console.log(error);
    return false;
  }
};

export const updateTweetRepo = async (
  tweetId: String,
  updatedTweet: ITweetInterface
): Promise<boolean> => {
  try {
    const result = await TweetModel.findOneAndUpdate(
      { uid: tweetId },
      updatedTweet,
      { new: true }
    );
    if (result) {
      return true;
    } else {
      return false;
    }
  } catch (error) {
    console.log(error);
    return false;
  }
};
