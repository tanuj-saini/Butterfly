// butterfly.dart
class Butterfly {
  String? name;
  String? scientificName;
  String? imageURL;
  String? id;

  Butterfly({this.id, this.name, this.scientificName, this.imageURL});

  // Factory method to create a Butterfly instance from JSON
  factory Butterfly.fromJson(Map<String, dynamic> json) {
    return Butterfly(
        name: json['name'],
        scientificName: json['scientificName'],
        imageURL: json['imageURL'],
        id: json['_id']);
  }

  // Method to convert a Butterfly instance to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'scientificName': scientificName,
      'imageURL': imageURL,
      'id': id
    };
  }
}
