exports.up = function (knex) {
  return knex.schema.createTable("calls", (table) => {
    table.increments();
    table.string("title").notNullable();
    table.text("description");
    table.string("audio_url");
    table.string("image_url");
    table.float("latitude", 10, 7).notNullable();
    table.float("longitude", 10, 7).notNullable();
    table.boolean("ispersonal").notNullable();
    table.integer("service_id").unsigned();
    table.integer("user_id").unsigned();
    table.integer("attendant_id").unsigned();
    table.string("status");
    table.timestamps(true);

    table.foreign("service_id").references("services.id");
    table.foreign("user_id").references("users.id");
    table.foreign("attendant_id").references("attendants.id");
  });
};

exports.down = function (knex) {
  return knex.schema.dropTable("calls");
};
