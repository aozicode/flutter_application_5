import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 90, 232, 254)),
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  int sum = 0;
  int difference = 0;
  int product = 0;
  double quotient = 0.0;

  // Controllers for the text fields
  final TextEditingController add1Controller = TextEditingController();
  final TextEditingController add2Controller = TextEditingController();
  final TextEditingController sub1Controller = TextEditingController();
  final TextEditingController sub2Controller = TextEditingController();
  final TextEditingController mul1Controller = TextEditingController();
  final TextEditingController mul2Controller = TextEditingController();
  final TextEditingController div1Controller = TextEditingController();
  final TextEditingController div2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Unit 5 Calculator"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Add Row
          _buildOperationRow(
            controller1: add1Controller,
            controller2: add2Controller,
            operationIcon: const Icon(CupertinoIcons.add),
            onPressed: () {
              setState(() {
                sum = (int.tryParse(add1Controller.text) ?? 0) +
                    (int.tryParse(add2Controller.text) ?? 0);
              });
            },
            clearAction: () {
              setState(() {
                add1Controller.clear();
                add2Controller.clear();
              });
            },
            resultText: '$sum',
          ),

          // Subtraction Row
          _buildOperationRow(
            controller1: sub1Controller,
            controller2: sub2Controller,
            operationIcon: const Icon(CupertinoIcons.minus),
            onPressed: () {
              setState(() {
                difference = (int.tryParse(sub1Controller.text) ?? 0) -
                    (int.tryParse(sub2Controller.text) ?? 0);
              });
            },
            clearAction: () {
              setState(() {
                sub1Controller.clear();
                sub2Controller.clear();
              });
            },
            resultText: '$difference',
          ),

          // Multiplication Row
          _buildOperationRow(
            controller1: mul1Controller,
            controller2: mul2Controller,
            operationIcon: const Icon(CupertinoIcons.multiply),
            onPressed: () {
              setState(() {
                product = (int.tryParse(mul1Controller.text) ?? 0) *
                    (int.tryParse(mul2Controller.text) ?? 0);
              });
            },
            clearAction: () {
              setState(() {
                mul1Controller.clear();
                mul2Controller.clear();
              });
            },
            resultText: '$product',
          ),

          // Division Row
          _buildOperationRow(
            controller1: div1Controller,
            controller2: div2Controller,
            operationIcon: const Icon(CupertinoIcons.divide),
            onPressed: () {
              setState(() {
                double firstDivNum = double.tryParse(div1Controller.text) ?? 0;
                double secondDivNum = double.tryParse(div2Controller.text) ?? 0;
                quotient = secondDivNum != 0 ? firstDivNum / secondDivNum : 0.0;
              });
            },
            clearAction: () {
              setState(() {
                div1Controller.clear();
                div2Controller.clear();
              });
            },
            resultText:
                '${quotient != 0 ? (quotient % 1 == 0 ? quotient.toInt() : quotient.toStringAsFixed(2)) : 'Error'}',
          ),
        ],
      ),
    );
  }

  // Helper method to build each operation row
  Widget _buildOperationRow({
    required TextEditingController controller1,
    required TextEditingController controller2,
    required Icon operationIcon,
    required VoidCallback onPressed,
    required VoidCallback clearAction,
    required String resultText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          child: TextField(
            controller: controller1,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 3.0,
                ),
              ),
              labelText: "First Number",
            ),
          ),
        ),
        SizedBox(width: 8),
        operationIcon,
        SizedBox(width: 8),
        Container(
          width: 100,
          child: TextField(
            controller: controller2,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 3.0,
                ),
              ),
              labelText: "Second Number",
            ),
          ),
        ),
        SizedBox(width: 8),
        IconButton(
          icon: const Icon(CupertinoIcons.equal),
          onPressed: onPressed,
          tooltip: 'Calculate',
        ),
        SizedBox(width: 8),
        Text(
          resultText,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 16),
        ElevatedButton.icon(
          onPressed: clearAction,
          label: const Text('Clear'),
          icon: const Icon(CupertinoIcons.clear_circled), 
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(8), 
          ),
        ),
      ],
    );
  }
}
