// ignore_for_file: unused_field, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:module_13_assignment/widget/input.dart';

enum HeightType { m, cm, feetinch }

enum WeightType { pound, kg }

enum BMICat { underweight, overweight, normal, obese }

class BMI extends StatefulWidget {
  const BMI({super.key});
  @override
  State<BMI> createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  HeightType? heightType = HeightType.m;
  WeightType? weightType = WeightType.kg;

  //text editing controllers:
  final TextEditingController _kiloController = TextEditingController();
  // ignore: duplicate_ignore
  // ignore: unused_field
  final TextEditingController _poundController = TextEditingController();
  final TextEditingController _meterController = TextEditingController();
  final TextEditingController _CMcontroller = TextEditingController();
  final TextEditingController _feetController = TextEditingController();
  final TextEditingController _inchController = TextEditingController();

  //functions banabo

  String? BmiRes;
  BMICat? bmiCat;

  //pound er ta kori age

  double? poudTOkg() {
    final lb = double.tryParse(
      _poundController.text.trim(),
    ); //text ta nilam faka jayga trim korlam
    if (lb == null || lb < 0) {
      return null;
    } else {
      return lb / 2.20462262;
    }
  }

  //Cm er ta
  double? CMtoMeter() {
    final cm = double.tryParse(_CMcontroller.text.trim());
    if (cm == null || cm <= 0) {
      return null;
    } else {
      return cm / 100;
    }
  }

  //feet inch

  double? feetInch() {
    final ft = double.tryParse(_feetController.text.trim());
    final inch = double.tryParse(_inchController.text.trim());

    if (ft == null || inch == null || ft < 0 || inch < 0) {
      return null;
    }

    final Tinch = ft * 12 + inch;
    if (Tinch <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Invalid data")));

      return null;
    }
    final Tmeter = Tinch * 0.0254;
    return Tmeter;
  }

  void MaapiKMota() {
    double? weightKG;
    double? heightMeter;
    //weight
    if (weightType == WeightType.kg) {
      weightKG = double.tryParse(_kiloController.text.trim());
    } else {
      weightKG = poudTOkg();
    }

    //height
    if (heightType == HeightType.m) {
      heightMeter = double.tryParse(_meterController.text.trim());
    } else if (heightType == HeightType.cm) {
      heightMeter = CMtoMeter();
    } else {
      heightMeter = feetInch();
    }

    if (weightKG == null || weightKG <= 0) {
      setState(() {
        BmiRes = null;
        bmiCat = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid"), behavior: SnackBarBehavior.floating),
      );
      return;
    }

    if (heightMeter == null || heightMeter <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid"), behavior: SnackBarBehavior.floating),
      );
      return;
    }

    final bmi = weightKG / (heightMeter * heightMeter);
    final cat = Category(bmi);

    setState(() {
      BmiRes = bmi.toStringAsFixed(1);
      bmiCat = Category(bmi);
    });
  }

  BMICat Category(double bmi) {
    if (bmi < 18.5) {
      return BMICat.underweight;
    } else if (bmi < 25) {
      return BMICat.normal;
    } else if (bmi < 30) {
      return BMICat.overweight;
    } else {
      return BMICat.obese;
    }
  }

  Color CatagorywiseColor(BMICat cat) {
    if (cat == BMICat.underweight) return Colors.blue;
    if (cat == BMICat.overweight) return Colors.orange;
    if (cat == BMICat.normal) return Colors.green;
    if (cat == BMICat.obese) return Colors.red;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.brown,
      ),

      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          Text(
            "Weight Type:",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          SizedBox(height: 5),
          SegmentedButton<WeightType>(
            segments: [
              ButtonSegment(value: WeightType.kg, label: Text("Kilogram")),
              ButtonSegment(value: WeightType.pound, label: Text("Pound")),
            ],
            selected: {weightType!},
            onSelectionChanged: (value) {
              setState(() {
                weightType = value.first;
                _kiloController
                    .clear(); // Clear unused controllers when unit changes
                _poundController
                    .clear(); // Clear unused controllers when unit changes
                BmiRes = null; // Clear unused controllers when unit changes
                bmiCat = null; // Clear unused controllers when unit changes
              });
            },
          ),

          SizedBox(height: 5),
          Text(
            "Weight Unit:",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),

          if (weightType == WeightType.kg) ...[
            InputField(
              controller: _kiloController,
              textInputType: TextInputType.number,
              vitoreJetaLekhaThakbe: "Weight in kg",
            ),
          ] else ...[
            InputField(
              controller: _poundController,
              textInputType: TextInputType.number,
              vitoreJetaLekhaThakbe: "Weight in lb",
            ),
          ],

          SizedBox(height: 10),
          Text(
            "Height Type:",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          SizedBox(height: 5),

          SegmentedButton<HeightType>(
            segments: [
              ButtonSegment(value: HeightType.cm, label: Text("Centimeter")),
              ButtonSegment(value: HeightType.m, label: Text("Meter")),
              ButtonSegment(
                value: HeightType.feetinch,
                label: Text("Feet-Inch"),
              ),
            ],
            selected: {heightType!},
            onSelectionChanged: (value) {
              setState(() {
                heightType = value.first;
                _meterController.clear();
                _CMcontroller.clear(); //unused controller genjam kore tai ore clear korlam
                _feetController
                    .clear(); //unused controller genjam kore tai ore clear korlam
                _inchController
                    .clear(); //unused controller genjam kore tai ore clear korlam
                BmiRes =
                    null; //unused controller genjam kore tai ore clear korlam
                bmiCat =
                    null; //unused controller genjam kore tai ore clear korlam
              });
            },
          ),

          SizedBox(height: 5),
          Text(
            "Height Unit:",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          SizedBox(height: 5),

          if (heightType == HeightType.m) ...[
            InputField(
              controller: _meterController,
              textInputType: TextInputType.number,
              vitoreJetaLekhaThakbe: "Height in meter",
            ),
          ] else if (heightType == HeightType.cm) ...[
            InputField(
              controller: _CMcontroller,
              textInputType: TextInputType.number,
              vitoreJetaLekhaThakbe: "Height in centimeter",
            ),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: InputField(
                    controller: _feetController,
                    textInputType: TextInputType.number,
                    vitoreJetaLekhaThakbe: "Height in feet",
                  ),
                ),

                SizedBox(width: 10),
                Expanded(
                  child: InputField(
                    controller: _inchController,
                    textInputType: TextInputType.number,
                    vitoreJetaLekhaThakbe: "Height in inch",
                  ),
                ),
              ],
            ),
          ],

          SizedBox(height: 10),
          ElevatedButton(
            onPressed: MaapiKMota,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              foregroundColor: Colors.white,
            ),
            child: Text(
              "Calculate BMI",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),

          SizedBox(height: 10),
          if (BmiRes != null && bmiCat != null) ...[
            Text(
              "Result: $BmiRes",
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            SizedBox(height: 10),
            Card(
              color: CatagorywiseColor(bmiCat!),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  bmiCat!.name.toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
