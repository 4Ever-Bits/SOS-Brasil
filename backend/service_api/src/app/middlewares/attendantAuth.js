module.exports = (req, res, next) => {
  const { decodedToken } = req.body;

  if (decodedToken.type !== "user") next();
  else return res.status(401).json({ error: "Unauthorized" });
};
