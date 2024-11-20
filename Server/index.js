// IMPORTS FROM PACKAGES
const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./Routers/auth");
const butterflyRouter = require("./Routers/butterfly");
// const adminRouter = require("./routes/admin");
// IMPORTS FROM OTHER FILES
// const authRouter = require("./routes/auth");
// const productRouter = require("./routes/product");
// const userRouter = require("./routes/user");

// INIT
const PORT = process.env.PORT || 3000;
const app = express();
const DB =
  "mongodb+srv://medeaszzz:butterfly@cluster0.80f7f.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";
// butterfly
// middleware
app.use(express.json());
app.use(authRouter);
app.use(butterflyRouter);
// app.use(adminRouter);
// app.use(productRouter);
// app.use(userRouter);

// Connections
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});
