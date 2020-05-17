exports.up = function (knex) {
  return knex("services").insert([
    {
      type: "Polícia Militar",
      phonenumber: "190",
      vehicles_available: 100,
    },
    {
      type: "SAMU",
      phonenumber: "192",
      vehicles_available: 100,
    },
    {
      type: "Corpo de Bombeiros",
      phonenumber: "193",
      vehicles_available: 100,
    },
  ]);
};

exports.down = function (knex) {};
