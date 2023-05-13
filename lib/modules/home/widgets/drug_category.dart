import 'package:flutter/material.dart';
import 'package:sahati/models/drug_category_model.dart';
import 'package:sahati/modules/home/screens/detailed_drug_category.dart';

class DrugCategory extends StatelessWidget {
  final DrugCategoryModel model;
  const DrugCategory({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailedDrugCategory(
              title: model.name,
              drugs: model.drugs,
            ),
          ),
        );
      },
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Image.asset(
                model.image,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              model.name,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
