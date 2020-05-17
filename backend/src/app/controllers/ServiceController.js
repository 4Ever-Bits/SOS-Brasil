const Service = require("../models/Service");

module.exports = {
  async updateVehiclesNumber(req, res) {
    const { number } = req.body;
    const { type } = req.params;

    const dbResult = await Service.updateAvailableVehicles(type, number);
    if (dbResult) return res.send();

    return res
      .status(400)
      .json({ error: "Couldn't updated available vehicle number" });
  },
};
