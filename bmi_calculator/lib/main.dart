import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: CalculateScreen(),

      ///BMI calculation mechanism
    );
  }
}

class CalculateScreen extends StatelessWidget {
  //user inputs for height & weight
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  CalculateScreen({super.key});

  void calculateBMI() {
    ///assigning input values to the variables
    double height = double.tryParse(heightController.text) ?? 0.0;
    double weight = double.tryParse(weightController.text) ?? 0.0;

    ///calculating and asssigning the BMI value
    double bmi = weight / (height * height);

    ///converting BMI value to a string
    String convertedBmi;

    if (height == 0.0 || weight == 0.0) {
      convertedBmi = '! Your Inputs are invalid !';
    } else {
      bmi = weight / (height * height);
      convertedBmi = 'Your BMI is ${bmi.toStringAsFixed(2)}';
    }
    Get.to(() => ResultScreen(
          bmi,
          converted_bmi: convertedBmi,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 28, 28),
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: const Color.fromARGB(255, 60, 95, 111),
        automaticallyImplyLeading: false,
        title: const Center(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 30),
            child: Text(
              'BMI CALCULATOR',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 28,
              ),
            ),
          ),
        ),
        elevation: 5,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 100, bottom: 100),
        child: Card(
          color: const Color.fromARGB(255, 166, 130, 124),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5,
                sigmaY: 5,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: heightController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Enter height (m)',
                        prefixIcon: Icon(Icons.height_rounded),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: weightController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: 'Enter weight (kg)',
                          prefixIcon: Icon(
                            Icons.scale,
                            size: 15,
                          )),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        ///button for get the Information page
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const InfoPage()));
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.only(bottom: 5),
                            fixedSize: const Size(80, 40),
                            backgroundColor:
                                const Color.fromARGB(255, 37, 45, 53),
                          ),
                          child: const Text(
                            style: TextStyle(
                              color: Color.fromARGB(179, 255, 255, 255),
                            ),
                            'Info ',
                          ),
                        ),
                        const Spacer(),

                        ///button for see the Results page
                        ElevatedButton(
                          onPressed: calculateBMI,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.only(bottom: 5),
                            fixedSize: const Size(110, 40),
                            backgroundColor:
                                const Color.fromARGB(255, 37, 45, 53),
                          ),
                          child: const Text(
                            style: TextStyle(
                              color: Color.fromARGB(179, 255, 255, 255),
                            ),
                            'Calculate',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final double bmi;
  // ignore: non_constant_identifier_names
  final String converted_bmi;

  // ignore: non_constant_identifier_names
  const ResultScreen(this.bmi, {super.key, required this.converted_bmi});

  ///Returning the appropriate BMI category
  String getCategory() {
    if (bmi < 17) {
      return 'Undernourishment';
    } else if (bmi >= 17 && bmi < 18.4) {
      return 'Slight Undernourishment';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Normal weight';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'Overweight';
    } else if (bmi >= 30 && bmi < 39.9) {
      return 'Obesity';
    } else if (bmi > 40) {
      return 'Pahtological Obesity';
    } else {
      return '----';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ' RESULT',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color.fromARGB(255, 100, 97, 97),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ' $converted_bmi', //shwoing the BMI as the output
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'Category: ${getCategory()}', //shwoing the BMI category as the output
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 28, 28),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 83, 80, 80),
        title: const Text(
          'BMI CATEGORIES',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0)),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 0, right: 0, top: 175, bottom: 175),
          child: Card(
            color: const Color.fromARGB(255, 211, 163, 163),
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'lib/assets/BMI_CATEGORIES.png',
                        width: 400,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
