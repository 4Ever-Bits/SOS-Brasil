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
  ];
  return list;
}
