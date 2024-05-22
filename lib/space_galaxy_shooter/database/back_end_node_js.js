const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const app = express();
const mongoURI = "mongodb://User1:1234@localhost:27017/newCollection";
mongoose.connect(mongoURI, {});

const db = mongoose.connection;
db.on("error", console.error.bind(console, "Database connection error."));
db.once("open", async function () {
  console.log("Succesfully connected to mongoDB");
  const Collection = mongoose.model(
    "Collection",
    new mongoose.Schema({}, { collection: "newCollection" })
  );
  const results = await Collection.find();
  console.log("Users in Database:", results);
});

app.use(cors());
app.use(express.json());
const UserModel = new mongoose.Schema(
  {
    login: String,
    password: String,
    scores: [Number],
  },
  { collection: "newCollection" }
);

const User = mongoose.model("User", UserModel);

app.get("/getAllUsers", async (req, res) => {
  try {
    const allUsers = await User.find();
    res.json(allUsers);
  } catch (error) {
    console.error("Error /data end point:", error);
    res.status(500).json({ error: "Server error" });
  }
});

app.post("/userLogin", async (req, res) => {
  const { login, password } = req.body;
  try {
    const user = await User.findOne({ login: login, password: password });
    if (user) {
      res.json({ success: true, message: "Login successful", user });
    } else {
      res
        .status(404)
        .json({ success: false, message: "Login or password incorrect" });
    }
  } catch (error) {
    res.status(500).json({ error: "Server error" });
  }
});

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

app.patch("/updatedUserScores", async (req, res) => {
  const { login, newScores: newScore } = req.body;
  try {
    const updatedUser = await User.findOneAndUpdate(
      { login: login },
      { $set: { scores: newScore } },
      { new: true }
    );

    if (updatedUser) {
      console.log(`Updated user: ${updatedUser}`);
      res.json({ success: true, updatedUser });
    } else {
      res.status(404).send("Error 404 - user not found:");
    }
  } catch (error) {
    res.status(500).json({ error: "Server error" });
  }
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
