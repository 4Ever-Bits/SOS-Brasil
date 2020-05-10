const bcrypt = require("bcrypt");

const salt = bcrypt.genSaltSync(10);
/* Função usada para criptografar a senha, 
retorna o hash da senha digitada pelo usuário */
function cryptPsw(password) {
  return bcrypt.hashSync(password, salt);
}
/*Função usada para comparar senhas
  Recebe a senha digitada e a que está no database
*/
function comparePsw(typedpass, password) {
  // return typedpass === password;
  return bcrypt.compareSync(typedpass, password);
}
/*Gera uma senha aleatória para a recuperação de senha do usuário */
function generatePassword() {
  //O slice fará pegar somente os últimos 10 caracteres do resultado em base36
  return Math.random().toString(36).slice(-10);
}
module.exports = { cryptPsw, comparePsw, generatePassword };
