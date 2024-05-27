class Admin {
  final int? id;
  final String name;
  final String phoneNumber;
  final String createdAt;
  final String updatedAt;

  Admin({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'phoneNumber': phoneNumber,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  Admin copyWith({
    required int id,
    required String name,
    required String phoneNumber,
    required String createdAt,
    required String updatedAt,
  }) =>
      Admin(
        createdAt: this.createdAt,
        id: this.id,
        name: this.name,
        updatedAt: this.updatedAt,
        phoneNumber: this.phoneNumber,
      );

  factory Admin.fromJson(Map<String, Object?> json) => Admin(
        id: json['id'] as int,
        name: json['name'] as String,
        phoneNumber: json['phoneNumber'] as String,
        createdAt: json['createdAt'] as String,
        updatedAt: json['updatedAt'] as String,
      );
}
