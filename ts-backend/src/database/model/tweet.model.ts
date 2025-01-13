import mongoose, { Document, Schema } from "mongoose";
import { ITweetInterface } from "../interface/tweet.interface";

const tweetSchema = new Schema<ITweetInterface>({
  tweetId: { type: String, required: true },
  content: { type: String, default: "" },
  adminId: { type: String, required: true },
  createdAt: { type: String, required: true },
});

const TweetModel = mongoose.model<ITweetInterface>("UserModel", tweetSchema);
export default TweetModel;
