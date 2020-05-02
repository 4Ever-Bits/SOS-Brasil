exports.up = function (knex) {
  return knex.schema.createTable("users", (table) => {
    table.increments();
    table.string("first_name", 100).notNullable();
    table.string("last_name", 100).notNullable();
    table.string("phonenumber", 100).notNullable();
    table.string("cpf", 14).notNullable();
    table.float("latitude");
    table.float("longitude");
    table.integer("account_id").unsigned();
    table.timestamps();

    table.foreign("account_id").references("accounts.id");
  });
};

exports.down = function (knex) {
  return knex.schema.dropTable("users");
};
