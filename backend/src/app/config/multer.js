const multer = require("multer");

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "./uploads");
  },

  filename: (req, files, cb) => {
    var filename =
      new Date().toLocaleString().replace(/\s/g, "") +
      "-" +
      files.originalname.replace(/\s/g, "");
    filename = filename.replace(":", "-");
    filename = filename.replace(":", "-");

    cb(null, filename);
  },
});

const upload = multer({ storage: storage });

module.exports = upload;
