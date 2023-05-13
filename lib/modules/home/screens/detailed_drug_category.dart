import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sahati/enums/dose_calculator_input_type.dart';
import 'package:sahati/models/drug_model.dart';

class DetailedDrugCategory extends StatefulWidget {
  final String title;
  final List<DrugModel> drugs;
  const DetailedDrugCategory({
    super.key,
    required this.title,
    required this.drugs,
  });

  @override
  State<DetailedDrugCategory> createState() => _DetailedDrugCategoryState();
}

class _DetailedDrugCategoryState extends State<DetailedDrugCategory> {
  late String dropDownValue;
  late DrugModel currentSelectedDrugModel;
  DoseCalculatorInputType currentDoseCalculatorInputType = DoseCalculatorInputType.weight;
  final TextEditingController textController = TextEditingController();
  double? age;

  @override
  void initState() {
    super.initState();
    dropDownValue = widget.drugs[0].name;
    currentSelectedDrugModel = widget.drugs[0];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(widget.title),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.indigo,
                        ),
                      ),
                    ),
                    value: dropDownValue,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        for (int i = 0; i < widget.drugs.length; i++) {
                          if (widget.drugs[i].name == newValue) {
                            currentSelectedDrugModel = widget.drugs[i];
                            break;
                          }
                        }
                        setState(() {
                          dropDownValue = newValue;
                        });
                      }
                    },
                    items: widget.drugs.map<DropdownMenuItem<String>>(
                      (value) {
                        return DropdownMenuItem<String>(
                          value: value.name,
                          child: Text(value.name),
                        );
                      },
                    ).toList(),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: textController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (currentText) {
                      setState(() {});
                    }, // Only numbers can be entered
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1.5),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                          width: 2,
                        ),
                      ),
                      labelText: currentDoseCalculatorInputType.arName,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    activeColor: Colors.indigo,
                    title: const Align(
                      alignment: Alignment(0.5, 0),
                      child: Text('الوزن'),
                    ),
                    value: DoseCalculatorInputType.weight,
                    groupValue: currentDoseCalculatorInputType,
                    onChanged: (value) {
                      setState(() {
                        currentDoseCalculatorInputType = DoseCalculatorInputType.weight;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    activeColor: Colors.indigo,
                    title: const Align(
                      alignment: Alignment(0.5, 0),
                      child: Text('العمر'),
                    ),
                    value: DoseCalculatorInputType.age,
                    groupValue: currentDoseCalculatorInputType,
                    onChanged: (value) {
                      setState(() {
                        currentDoseCalculatorInputType = DoseCalculatorInputType.age;
                      });
                    },
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(30),
              width: double.infinity,
              height: 120,
              child: ElevatedButton(
                onPressed: textController.text.isEmpty
                    ? null
                    : () {
                        if (currentDoseCalculatorInputType == DoseCalculatorInputType.age) {
                          age = double.parse(textController.text);
                        } else {
                          // Convert the weight to an age and set it to currentSelectedDrugModel.age:
                          // currentSelectedDrugModel.age = **weight to age value**;
                        }
                        setState(() {});
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                ),
                child: const Text(
                  'حساب',
                  style: TextStyle(
                    fontSize: 19,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(5),
                      ),
                      color: Colors.indigo,
                    ),
                    child: const ListTile(
                      title: Text(
                        'النتيجة',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(5),
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        age == null ? 'النتيجة' : 'Dose ${currentSelectedDrugModel.doseCalculator(age!)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
