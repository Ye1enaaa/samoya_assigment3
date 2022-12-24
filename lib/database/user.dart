class User {
  int? id;
  String? name;
  String? contact;

  userMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['name'] = name!;
    mapping['contact'] = contact!;
    return mapping;
  }
}
