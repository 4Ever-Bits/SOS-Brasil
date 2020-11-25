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

  cpf(cpf) {
    cpf = cpf.replace(".", "");
    cpf = cpf.replace(".", "");
    cpf = cpf.replace("-", "");

    var numeros, digitos, soma, i, resultado, digitos_iguais;
    digitos_iguais = 1;

    if (cpf.length < 11) return false;

    for (i = 0; i < cpf.length - 1; i++) {
      if (cpf.charAt(i) != cpf.charAt(i + 1)) {
        digitos_iguais = 0;
        break;
      }
    }

    if (!digitos_iguais) {
      numeros = cpf.substring(0, 9);
      digitos = cpf.substring(9);
      soma = 0;

      for (i = 10; i > 1; i--) soma += numeros.charAt(10 - i) * i;
      resultado = soma % 11 < 2 ? 0 : 11 - (soma % 11);

      if (resultado != digitos.charAt(0)) return false;
      numeros = cpf.substring(0, 10);
      soma = 0;

      for (i = 11; i > 1; i--) soma += numeros.charAt(11 - i) * i;
      resultado = soma % 11 < 2 ? 0 : 11 - (soma % 11);

      if (resultado != digitos.charAt(1)) return false;

      return true;
    } else {
      return false;
    }
  },
};
