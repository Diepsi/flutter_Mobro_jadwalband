class Band {
  int? id;
  String name;
  String genre;
  String imagePath;
  String city;
  String date;

  Band({
    this.id,
    required this.name,
    required this.genre,
    required this.imagePath,
    required this.city,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'genre': genre,
      'imagePath': imagePath,
      'city': city,
      'date': date,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory Band.fromMap(Map<String, dynamic> map) {
    return Band(
      id: map['id'],
      name: map['name'],
      genre: map['genre'],
      imagePath: map['imagePath'],
      city: map['city'],
      date: map['date'],
    );
  }
}
