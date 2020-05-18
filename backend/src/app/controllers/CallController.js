const Validate = require("../utils/Validate");

const Call = require("../models/Call");

module.exports = {
  async index(req, res) {
    const { page = 1 } = req.query;
    const { limit = 10 } = req.query;
    const { order = "id" } = req.query;
    const { asc = "true" } = req.query;

    const dbResult = await Call.findAll(page, limit, order, asc);

    res.header("X-Total-Count", dbResult.count["count(*)"]);

    res.json(dbResult.calls);
  },

  async show(req, res) {
    try {
      var checkByID = false;
      const { field = "id", data } = req.params;

      if (!isNaN(data)) checkByID = true;

      if (checkByID && field === "id") {
        const dbResult = await Call.findWhere({ "calls.id": data });
        if (dbResult) return res.status(200).json(dbResult);
      } else {
        const dbResult = await Call.findWhereLike(
          "calls." + field,
          data,
          req.query
        );
        if (dbResult.calls.length > 0) {
          res.header("X-Total-Count", dbResult.count["count(*)"]);
          return res.status(200).json(dbResult.calls);
        }
      }

      return res.status(404).json({ error: "Call not found" });
    } catch (e) {
      return res.status(404).json({ error: "Call not found" });
    }
  },

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
      if (req.files) {
        for (file of fileArray) {
          if (file.mimetype.includes("image") && file.fieldname === "image")
            image_url = file.path;
          else audio_url = file.path;
        }
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

  async updateStatus(req, res) {
    const { id } = req.params;
    const data = req.body;

    const dbResult = await Call.updateStatus(id, data);

    if (dbResult) return res.send();
    else return res.status(400).json({ error: "Couldn't update status" });
  },
};
