class Appointment {
  int? id; // Regular instance field
  String name;
  String place;
  double? amount;
  String comments;
  String date;
  String time;

  Appointment({
    this.id, // id is now a required parameter in the constructor
    required this.name,
    required this.place,
    this.amount,
    required this.comments,
    required this.date,
    required this.time,
  });

  // Create an Appointment object from a map.
  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'],
      name: map['name'] ?? '',
      place: map['place'] ?? '',
      amount: map['amount'] ?? 0.0,
      comments: map['comments'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'place': place,
      'amount': amount??0.0,
      'comments': comments,
      'date': date,
      'time': time,
    };
  }
}
