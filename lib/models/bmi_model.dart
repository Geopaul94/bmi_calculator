class BMIModel {
  final String gender;
  final double age;

  final String? category;

  BMIModel({
    required this.gender,
    required this.age,
    this.category,
  });

  BMIModel copyWith({
    double? height,
    double? weight,
    String? gender,
    double? bmi,
    String? category,
    double? age,
  }) {
    return BMIModel(
      gender: gender ?? this.gender,
      age: age ?? this.age,
      category: category ?? this.category,
    );
  }
}
