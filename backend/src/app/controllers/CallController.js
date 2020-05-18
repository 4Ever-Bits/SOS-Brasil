const Validate = require("../utils/Validate");

const Call = require("../models/Call");

module.exports = {
  async index(req, res) {},

  async create(req, res) {
    const fileArray = req.files;
    let { title, description, isPersonal } = req.body;
    let { latitude, longitude } = req.body;
    let { service_id, user_id } = req.body;

    let audio_url,
      image_url = null;

    try {
      //Validations
      Validate.isEmpty(title, "Title is empty");
      Validate.isEmpty(description, "Description is empty");
      Validate.isEmpty(isPersonal, "IsPersonal is empty");
      Validate.isEmpty(latitude, "Latitude is empty");
      Validate.isEmpty(longitude, "Longitude is empty");
      Validate.isEmpty(service_id, "Service_id is empty");
      Validate.isEmpty(user_id, "User_id is empty");
      //TODO   Validate.coordinates(latitude, "Latitude is bad formated");
      //TODO   Validate.coordinates(longitude, "Longitude is bad formated");

      //Convert string of MultipartForm to boolean
      if (isPersonal === "true") isPersonal = true;
      else isPersonal = false;

      //   Convert string of MultipartForm to float
      latitude = parseFloat(latitude);
      longitude = parseFloat(longitude);

      //Compare if the files are audio ou image
      // and store them in respective var
      for (file of fileArray) {
        if (file.mimetype.includes("image") && file.fieldname === "image")
          image_url = file.path;
        else audio_url = file.path;
      }

      //Put all data in an object
      const data = {
        title,
        description,
        isPersonal,
        latitude,
        longitude,
        service_id,
        user_id,
        audio_url,
        image_url,
      };

      const id = await Call.create(data);

      return res.json({ id });
    } catch (e) {
      console.log(e);
      return res.status(400).json({ error: e });
    }
  },

  async updateStatus(req, res) {},
};
