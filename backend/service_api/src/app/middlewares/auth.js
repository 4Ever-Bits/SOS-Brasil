const jwt = require("jsonwebtoken");

module.exports = (req, res, next) => {
  try {
    const token = req.headers.authorization.split(" ")[1];

    const decode = jwt.verify(token, process.env.AUTH_SECRET);
    req.body.decodedToken = decode;

    next();
  } catch (e) {
    return res.status(401).json({ error: "Unauthorized" });
  }
};
