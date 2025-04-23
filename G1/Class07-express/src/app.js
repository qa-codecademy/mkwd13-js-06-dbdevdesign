import express from "express";
import { AppDataSource } from "./data-source.js";
import { userRouter } from "./routes/users.js";
import { postRouter } from "./routes/posts.js";

const app = express();
const PORT = process.env.PORT || 3000;
app.use(express.json());

// wrap in an async function
async function main() {
  try {
    await AppDataSource.initialize();
    console.log("Database connection established");

    app.use("/api/users", userRouter);
    app.use("/api/posts", postRouter);

    app.listen(PORT, () => {
      console.log(`Server is running on port ${PORT}`);
    });
  } catch (error) {
    console.error("Error during initialization:", error);
    process.exit(1);
  }
}

main();
