class DrugModel {
  final String name;
  final double Function(double) doseCalculator;

  DrugModel({required this.name, required this.doseCalculator});
}
