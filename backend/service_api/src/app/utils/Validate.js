module.exports = {
  isEmpty(value, msg) {
    if (!value) throw msg;

    if (Array.isArray(value) && value.length === 0) throw msg;

    if (typeof value === "string" && !value.trim()) throw msg;
  },

  email(email, msg) {
    var re = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/;

    if (!re.test(email)) {
      throw msg;
    }
  },
};
