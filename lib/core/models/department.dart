class DepartmentApiModel {
  final int id;
  final String name;
  final String? description;

  const DepartmentApiModel({
    required this.id,
    required this.name,
    this.description,
  });

  factory DepartmentApiModel.fromJson(Map<String, dynamic> json) {
    int _asInt(dynamic v) => v is int ? v : int.tryParse('$v') ?? 0;

    return DepartmentApiModel(
      id: _asInt(json['id']),
      name: (json['name'] ?? '').toString(),
      description: json['description']?.toString(),
    );
  }
}
