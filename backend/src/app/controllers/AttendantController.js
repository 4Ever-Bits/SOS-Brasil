const Validate = require("../utils/Validate");

const Attendant = require("../models/Attendant");

module.exports = {
  async index(req, res) {
    const attendants = await Attendant.findAll();
    res.status(200).json(attendants);
  },

  async create(req, res) {
    try {
      const { email, password, name, code, service_id } = req.body;

      Validate.isEmpty(name, "Name is empty");
      Validate.isEmpty(email, "Email is empty");
      Validate.isEmpty(password, "Password is empty");
      Validate.isEmpty(code, "Code is empty");
      Validate.isEmpty(service_id, "Service_id is empty");

      const nameArray = name.split(" ");
      const first_name = nameArray[0];
      const last_name = nameArray[nameArray.length - 1];

      Validate.email(email, "Email is bad formated");

      let data = {
        first_name,
        last_name,
        email,
        password,
        code,
        service_id,
      };

      const attendant = new Attendant(data);
      const id = await attendant.create();

      return res.status(200).json({ id: id });
    } catch (e) {
      console.log(e);
      return res.status(400).json({ error: e });
    }
  },

  async show(req, res) {
    var checkByID = false;
    const attendantData = req.params.data;

    if (!isNaN(attendantData)) checkByID = true;

    if (checkByID) {
      const dbResult = await Attendant.findWhere({
        "attendants.id": attendantData,
      });
      console.log(dbResult);
      if (dbResult) return res.status(200).json(dbResult);
    } else {
      const dbResult = await Attendant.findWhereLike(
        "accounts.email",
        attendantData
      );

      if (dbResult.length > 0) return res.status(200).json(dbResult);
    }

    return res.status(404).json({ error: "User not found" });
  },

  async update(req, res) {
    try {
      const { name } = req.body;
      const id = req.params.data;

      Validate.isEmpty(name, "Name is empty");

      const nameArray = name.split(" ");
      const first_name = nameArray[0];
      const last_name = nameArray[nameArray.length - 1];

      const dbResult = await Attendant.update(
        { "attendants.id": id },
        { first_name, last_name }
      );

      if (dbResult) return res.send();
      else return res.stauts(404).json({ error: "Attendant not found" });
    } catch (e) {
      console.log(e);
      return res.stauts(400).json({ error: e });
    }
  },

  async delete(req, res) {
    const attendantData = req.params.data;

    const dbResult = await Attendant.delete({ "attendants.id": attendantData });

    //Compare if user exist
    if (!dbResult)
      return res.status(404).json({ error: "Attendant not found" });
    return res.send();
  },
};
