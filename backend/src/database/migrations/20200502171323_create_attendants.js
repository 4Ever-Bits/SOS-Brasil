exports.up = function (knex) {
  return knex.schema.createTable("attendants", (table) => {
    table.increments();
    table.string("first_name").notNullable();
    table.string("last_name").notNullable();
    table.string("code").notNullable();
    table.integer("account_id").unsigned();
    table.integer("service_id").unsigned();
    table.timestamps();

    table.foreign("account_id").references("accounts.id");
    table.foreign("service_id").references("services.id");
  });
};

exports.down = function (knex) {
  return knex.schema.dropTable("attendants");
};
