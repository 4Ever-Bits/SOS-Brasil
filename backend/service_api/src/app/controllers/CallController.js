const { Call, User } = require("../models");
const Validate = require("../utils/Validate");
const sequelize = require("sequelize");
const axios = require("axios");

module.exports = {
  async index(req, res) {
    try {
      const { page = 1 } = req.query;
      const { limit = 10 } = req.query;
      const { orderBy = "id" } = req.query;
      const { direction = "ASC" } = req.query;

      const { count, rows } = await Call.findAndCountAll({
        limit: parseInt(limit),
        offset: (parseInt(page) - 1) * parseInt(limit),
        order: [[orderBy, direction]],
        attributes: { exclude: ["attendant_id"] },
        include: {
          model: User,
          as: "attendant",
          attributes: { exclude: ["password", "createdAt", "updatedAt"] },
        },
      });

      const calls_amount = count;
      const calls = rows;

      let data = [];
      for (call of calls) {
        const response = await axios.get(
          process.env.USER_API_URL + `/user/${call.user_id}`
        );
        const user = response.data;
        delete call.dataValues["user_id"];
        delete user["AccountId"];
        data.push({ ...call.dataValues, user });
      }

      res.header("X-Total-Count", calls_amount);

      return res.status(200).json(data);
    } catch (error) {
      console.log(error);
      return res.status(500).send();
    }
  },

  async create(req, res) {
    try {
      const fileArray = req.files;
      let { title, description, isPersonal } = req.body;
      let { latitude, longitude, user_id } = req.body;

      let audio_url,
        image_url = null;

      //Validations
      Validate.isEmpty(title, "Title is empty");
      Validate.isEmpty(description, "Description is empty");
      Validate.isEmpty(isPersonal, "IsPersonal is empty");
      Validate.isEmpty(latitude, "Latitude is empty");
      Validate.isEmpty(longitude, "Longitude is empty");
      Validate.isEmpty(user_id, "User_id is empty");
      //TODO:   Validate.coordinates(latitude, "Latitude is bad formated");
      //TODO:   Validate.coordinates(longitude, "Longitude is bad formated");

      //Convert string of MultipartForm to boolean
      if (isPersonal === "true") isPersonal = true;
      else isPersonal = false;

      //   Convert string of MultipartForm to float
      latitude = parseFloat(latitude);
      longitude = parseFloat(longitude);

      //TODO:
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
        image_url,
        audio_url,
        latitude,
        longitude,
        ispersonal: isPersonal,
        user_id,
      };

      const call = await Call.create(data);

      return res.status(200).json(call);
    } catch (error) {
      console.log(error);
      return res.status(500).send();
    }
  },

  async show(req, res) {
    try {
      var checkByID = false;
      const { field = "id", data } = req.params;
      const { limit = 10 } = req.query;
      const { direction = "ASC" } = req.query;

      if (!isNaN(data) && field === "id") checkByID = true;

      if (checkByID) {
        const call = await Call.findOne({
          where: { id: data },
          attributes: { exclude: ["attendant_id"] },
          include: {
            model: User,
            as: "attendant",
            attributes: { exclude: ["password", "createdAt", "updatedAt"] },
          },
        });

        if (call) {
          const response = await axios.get(
            process.env.USER_API_URL + `/user/${call.user_id}`
          );
          const user = response.data;
          delete call.dataValues["user_id"];
          delete user["AccountId"];

          return res.status(200).json({ ...call.dataValues, user });
        }
      } else {
        const { count, rows } = await Call.findAndCountAll({
          where: sequelize.where(sequelize.col(field), data),
          limit: parseInt(limit),
          order: [[field, direction]],
          attributes: { exclude: ["attendant_id"] },
          include: {
            model: User,
            as: "attendant",
            attributes: { exclude: ["password", "createdAt", "updatedAt"] },
          },
        });

        const calls_amount = count;
        const calls = rows;

        let dataJson = [];
        for (call of calls) {
          const response = await axios.get(
            process.env.USER_API_URL + `/user/${call.user_id}`
          );
          const user = response.data;
          delete call.dataValues["user_id"];
          delete user["AccountId"];
          dataJson.push({ ...call.dataValues, user });
        }

        res.header("X-Total-Count", calls_amount);

        return res.status(200).json(dataJson);
      }

      return res.status(404).json({ error: "Call not found" });
    } catch (error) {
      console.log(error);
      return res.status(500).send();
    }
  },

  async updateStatus(req, res) {
    try {
      const { attendant_id, status } = req.body;
      const { id } = req.params;

      const [call] = await Call.update(
        {
          attendant_id: attendant_id,
          status: status,
        },
        {
          where: {
            id: id,
          },
        }
      );

      if (call) res.status(200).send();
      else res.status(404).json({ error: "Call not found" });
    } catch (error) {
      console.log(error);
      return res.status(500).send();
    }
  },
};
