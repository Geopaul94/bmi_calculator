class BMIModel {
  final double height;
  final double weight;
  final String gender;
  final double? bmi;
  final String? category;

  BMIModel({
    required this.height,
    required this.weight,
    required this.gender,
    this.bmi,
    this.category,
  });

  BMIModel copyWith({
    double? height,
    double? weight,
    String? gender,
    double? bmi,
    String? category,
  }) {
    return BMIModel(
      height: height ?? this.height,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
      bmi: bmi ?? this.bmi,
      category: category ?? this.category,
    );
  }
} 