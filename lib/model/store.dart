class Store {
  final String id;
  final String name;
  final String location;
  final String open;

  Store({
    required this.id,
    required this.name,
    required this.location,
    required this.open,
  });

  factory Store.fromFirestore(
      Map<String, dynamic> data, String id) {
    return Store(
      id: id,
      name: data['name'] ?? '',
      location: data['location'] ?? '',
      open: data['open'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'open': open,
    };
  }

}
