import { Router } from "express";
import {
  createUserController,
  deleteUserController,
  getUserController,
  updateUserController,
} from "../controllers/user.controller";

const userRouter = Router();

userRouter.get("/:userId", getUserController);
userRouter.post("/", createUserController);
userRouter.put("/", updateUserController);
userRouter.delete("/:userId", deleteUserController);

export default userRouter;
