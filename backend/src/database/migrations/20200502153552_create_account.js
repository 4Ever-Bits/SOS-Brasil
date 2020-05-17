exports.up = function (knex) {
  return knex.schema.createTable("accounts", (table) => {
    table.increments();
    table.string("email");
    table.string("password");
    table.string("passwordResetToken");
    table.datetime("passwordResetExpires");
    table.timestamps(true);
  });
};

exports.down = function (knex) {
  return knex.schema.hasTable("accounts").then((exist) => {
    if (exist) return knex.schema.dropTable("accounts");
  });
};
