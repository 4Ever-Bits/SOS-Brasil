const multer = require("multer");

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "./uploads");
  },

  filename: (req, files, cb) => {
    var filename =
      new Date().toLocaleString().replace(/\s/g, "_") +
      "-" +
      files.originalname.replace(/\s/g, "_");
    filename = filename.replace(":", "-");
    filename = filename.replace(":", "-");
    filename = filename.replace("/", "-");
    filename = filename.replace("/", "-");

    console.log(filename);

    cb(null, filename);
  },
});

const upload = multer({ storage: storage });

module.exports = upload;
