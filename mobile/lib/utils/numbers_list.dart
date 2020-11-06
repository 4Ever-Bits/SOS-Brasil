class Phonenumber {
  final String name;
  final String number;

  Phonenumber(this.name, this.number);
}

List<Phonenumber> get phonelist {
  List<Phonenumber> list = [
    Phonenumber("Ambulância", "192"),
    Phonenumber("Polícia", "190"),
    Phonenumber("Corpo de Bombeiros", "193"),
    Phonenumber("Delegacia da Mulher", "180"),
    Phonenumber("Disque Denúncia", "181"),
    Phonenumber("Polícia Civil", "197"),
    Phonenumber("Polícia Federal", "194"),
    Phonenumber("PRF", "191"),
  ];
  return list;
}
