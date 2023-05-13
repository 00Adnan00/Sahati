import 'package:flutter/material.dart';
import 'package:sahati/models/drug_category_model.dart';
import 'package:sahati/models/drug_model.dart';
import 'package:sahati/modules/home/widgets/drug_category.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<DrugCategoryModel> drugCategories = [
    DrugCategoryModel(name: 'Ahmed Mohsen', image: 'assets/images/image_placeholder.webp', drugs: [
      DrugModel(
        name: 'Paracetamol 120mg',
        doseCalculator: (age) {
          return age / 2;
        },
      ),
      DrugModel(
        name: 'Fool 120mg',
        doseCalculator: (age) {
          return age / 2;
        },
      ),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('صحتي'),
        backgroundColor: Colors.indigo,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: drugCategories
            .map(
              (category) => DrugCategory(
                model: DrugCategoryModel(
                  name: category.name,
                  image: category.image,
                  drugs: category.drugs,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
