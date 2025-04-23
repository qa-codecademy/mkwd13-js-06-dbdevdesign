import express from "express";
import { AppDataSource } from "./data-source.js";
// import routers here

const app = express();
const PORT = process.env.PORT || 3000;
app.use(express.json());

// wrap in an async function
async function main() {
  try {
    await AppDataSource.initialize();
    console.log("Database connection established");

    // add routers here

    app.listen(PORT, () => {
      console.log(`Server is running on port ${PORT}`);
    });
  } catch (error) {
    console.error("Error during initialization:", error);
    process.exit(1);
  }
}

main();
