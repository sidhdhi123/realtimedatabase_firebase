class student {
  String? key, name, number;

  student(this.key, this.name, this.number);

  static student fromjson(Map m, String key) {
    return student(key, m['name'], m['number']);
  }
}
