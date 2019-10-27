class Contact {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String dateOfBirth;
  final String phoneNumber;

  Contact({this.id: "",
    this.firstName: "",
    this.lastName: "",
    this.email: "",
    this.gender: "",
    this.dateOfBirth: "",
    this.phoneNumber: ""});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],
      phoneNumber: json['phone_no'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'phone_no': phoneNumber
    };
  }
}
