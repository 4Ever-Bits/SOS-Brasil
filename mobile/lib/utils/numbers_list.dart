class Phonenumber {
  final String name;
  final String number;

  Phonenumber(this.name, this.number);
}

List<Phonenumber> get phonelist {
  List<Phonenumber> list = [
    Phonenumber("Ambulancia", "192"),
    Phonenumber("Ambulancia", "192"),
    Phonenumber("Ambulancia", "192"),
  ];
  return list;
}
