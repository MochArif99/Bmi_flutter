import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  double bmi = 0;
  String bmiCategory = "-";

  void calculateBmi() {
    if (formKey.currentState!.validate()) {
      final weight = double.parse(weightController.text);
      final height = double.parse(heightController.text) / 100;
      setState(() {
        bmi = weight / (height * height);
        bmiCategory = Bmicategory();
      });
    }
  }

  String Bmicategory() {
    if (bmi < 18.5) {
      return 'Kurang';
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return 'Normal';
    } else {
      return 'Berlebihan';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("BMI Calculator"),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: weightController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan berat badan (Kg)';
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Masukkan berat badan (Kg)",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: heightController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan tinggi anda (Cm)';
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Masukkan tinggi anda (Cm)",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                "BMI anda: ${bmi.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                "Kategori: $bmiCategory",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: calculateBmi,
                  child: Text("Hitung BMI"),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(40),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}