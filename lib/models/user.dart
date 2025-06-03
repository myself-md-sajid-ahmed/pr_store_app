import 'dart:convert';


class User {
  //define fields
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String password;

  //constructor , user object

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.password,
  });

  //serialization : convert user object to a map
  //map: a map is a collection fo key-value pairs
  //why: converting to a map is an intermediate step that makes it easier to serialize
  //the object to formats like json for storage or transmission

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      'fullname': fullName,// ata khub jaliyese vai
      'email': email,
      'state': state,
      'city': city,
      'locality': locality,
      'password': password,
    };
  }
  //Serialization : convert map to a JSON String
  //This method directly encodes the data from the map into a JSON String

  //The json.encode() function converts a Dart object(such as Map or List)
  //into a Json String representation , making it suitable for communication
  //between different systems
  String toJson() => json.encode(toMap());

  //Deserialization: convert a Map to a User object
  //purpose: manipulation and user: once the data is converted a to a User osbject
  //it can be easily manipulated and use within the application -for example
  //we might want to display the user's fullName,email etc on the Ui. or we might
  //want to save the data locally.

  //the factor constructor takes a Map(usually obtained from a Json object)
  //and converts it into a User objects. if a field is not present in the
  //it defaults to an empty String

  //fromMap: this constructor take a Map<string , dynamic> and converts into a user object
  //its usefull when you already have the data in map format
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String ?? "",
      fullName: map['fullName'] as String ?? "",
      email: map['email'] as String ?? "",
      state: map['state'] as String ?? "",
      city: map['city'] as String ?? "",
      locality: map['locality'] as String ?? "",
      password: map['password'] as String ?? "",
    );
  }

  //fromJson: This factory constructor takes Json String , and decodes into a Map<String,dynamic>
  //and the uses fromMap to convert that Map into a User object.
  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
