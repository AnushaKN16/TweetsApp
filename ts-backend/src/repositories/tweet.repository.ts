import mongoose from "mongoose";
import TweetModel from "../database/model/tweet.model";
import { ITweetInterface } from "../database/interface/tweet.interface";
import UserModel from "../database/model/user.model";

export const getTweetRepo = async (
  tweetId: String
): Promise<ITweetInterface | null> => {
  try {
    const tweet = await TweetModel.findOne({ tweetId: tweetId });
    return tweet;
  } catch (error) {
    console.log(error);
    return null;
  }
};

export const deleteTweetRepo = async (tweetId: String): Promise<boolean> => {
  try {
    const tweetDeleted = await TweetModel.findOneAndDelete({
      tweetId: tweetId,
    });
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
      { tweetId: tweetId },
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

export const getAllTweetsRepo = async() :Promise<any[] | null> => {
  try {
    const allTweets = await TweetModel.find();
    if(!allTweets || allTweets.length == 0){
      return null
    }

    const tweetWithUserInfo = await Promise.all(
      allTweets.map(async(tweet: { adminId: any; }) => {
      const admin = await UserModel.findOne({uid: tweet.adminId})

      if(!admin){
        return{tweet, admin: null}
      } else {
        return {tweet, admin:admin}
      }
    }))
    return tweetWithUserInfo;
  } catch (error) {
    return null;
  }
}
