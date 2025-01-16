import express, { Express, Router } from "express";
import http from "http";
import cors from "cors";
import bodyParser from "body-parser";
import router from "./routes/routes";
import dotenv from "dotenv";
import mongoose from "mongoose";

const app: Express = express();
const server = http.createServer(app);
dotenv.config();

app.use(cors());
app.use(bodyParser());
app.use(bodyParser.urlencoded({ extended: true }));
app.set("PORT", 3000);
app.set("BASE_URL", "localhost");

app.use("/api/v1", router);

//Mongodb connection
const mongoUri = process.env.MONGO_DB_URI;

if (!mongoUri) {
  console.error("MongoDB url is not defined");
  process.exit(1);
}
mongoose
  .connect(mongoUri, {})
  .then(() => {
    console.log("MongoDB is Connected");
  })
  .catch((error) => {
    console.log(error);
  });

try {
  const port = app.get("PORT");
  const baseUrl = app.get("BASE_URL");
  server.listen(port, (): void => {
    console.log("Server is listening");
  });
} catch (error) {
  console.log(error);
}

export default server;
