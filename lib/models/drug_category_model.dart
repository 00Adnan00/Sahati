import 'package:sahati/models/drug_model.dart';

class DrugCategoryModel {
  final String name;
  final String image;
  final List<DrugModel> drugs;

  const DrugCategoryModel({
    required this.name,
    required this.image,
    required this.drugs,
  });
}
