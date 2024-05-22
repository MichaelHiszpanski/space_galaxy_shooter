const express = require("express");
const cors = require("cors");
const mongoose = require("mongoose");
const app = express();

const userMongoURI = "mongodb://User1:1234@localhost:27017/newCollection";
mongoose.connect(userMongoURI, {});

const db = mongoose.connection;
db.on("error", console.error.bind(console, "connection error:"));
app.use(cors());
app.use(express.json());

const userSchema = new mongoose.Schema(
  {
    login: String,
    password: Number,
    scores: [Number],
  },
  { collection: "newCollection" }
);

const User = mongoose.model("User", userSchema);

// Route to add a new user
app.post("/addUser", async (req, res) => {
  const { login, password } = req.body;
  const scores = [0];
  const newUser = new User({ login, password, scores });
  try {
    await newUser.save();
    res.status(201).send("User added");
  } catch (error) {
    console.error("Error saving new user:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});

// Route to get all users
app.get("/data", async (req, res) => {
  try {
    const users = await User.find();
    console.log("Fetching all users:", users);
    res.json(users);
  } catch (error) {
    console.error("Error fetching users:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});
//check Login
app.post("/checkLogin", async (req, res) => {
  const { login, password } = req.body;
  try {
    const user = await User.findOne({ login: login, password: password });
    if (user) {
      res.json({ success: true, message: "Login successful", user });
    } else {
      res
        .status(404)
        .json({ success: false, message: "Login or password is incorrect" });
    }
  } catch (error) {
    console.error("Error checking login:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});
//update scores
app.patch("/updateScores", async (req, res) => {
  const { login, newScores } = req.body;

  try {
    const updatedUser = await User.findOneAndUpdate(
      { login: login },
      { $set: { scores: newScores } },
      { new: true }
    );

    if (updatedUser) {
      res.json({ success: true, updatedUser });
    } else {
      res.status(404).send("User not found");
    }
  } catch (error) {
    console.error("Error updating user scores:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});
