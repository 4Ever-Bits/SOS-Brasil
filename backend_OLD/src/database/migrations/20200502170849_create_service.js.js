exports.up = function (knex) {
  return knex.schema.createTable("services", (table) => {
    table.increments();
    table.string("type").notNullable();
    table.string("phonenumber").notNullable();
    table.integer("vehicles_available").notNullable();
    table.timestamps(true);
  });
};

exports.down = function (knex) {
  return knex.schema.dropTable("services");
};
