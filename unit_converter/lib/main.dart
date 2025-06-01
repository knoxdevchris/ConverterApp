import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

// Main app widget
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

// State class to manage the app's state
class MyAppState extends State<MyApp> {
  double _numberFrom = 0; // Input value
  String _startMeasure = 'meters'; // Default starting unit
  String _convertedMeasure = 'feet'; // Default target unit
  String? _resultMessage; // Result message

  // List of measures
  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds (lbs)',
    'ounces',
  ];

  // Map for indexing measures
  final Map<String, int> _measuresMap = {
    'meters': 0,
    'kilometers': 1,
    'grams': 2,
    'kilograms': 3,
    'feet': 4,
    'miles': 5,
    'pounds (lbs)': 6,
    'ounces': 7,
  };

  // Conversion formulas matrix
  final dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0], // meters
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0], // kilometers
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274], // grams
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274], // kilograms
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0], // feet
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0], // miles
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16], // pounds
    '7': [0, 0, 28.3495, 0.0283495, 0, 0, 0.0625, 1], // ounces
  };

  // Conversion method
  void convert(double value, String from, String to) {
    int nFrom = _measuresMap[from]!;
    int nTo = _measuresMap[to]!;
    var multiplier = _formulas[nFrom.toString()][nTo];
    var result = value * multiplier;

    if (result == 0) {
      _resultMessage = 'This conversion cannot be performed';
    } else {
      _resultMessage = '${value.toString()} $from are ${result.toString()} $to';
    }
    setState(() {
      _resultMessage = _resultMessage;
    });
  }

  @override
  void initState() {
    _numberFrom = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Styling
    final TextStyle inputStyle = TextStyle(
      fontSize: 20,
      color: Colors.blue[900],
    );
    final TextStyle labelStyle = TextStyle(
      fontSize: 24,
      color: Colors.grey[700],
    );

    return MaterialApp(
      title: 'Measures Converter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Measures Converter'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Value',
                        style: labelStyle,
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        style: inputStyle,
                        decoration: const InputDecoration(
                          hintText: "Please insert the measure to be converted",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          var rv = double.tryParse(text);
                          if (rv != null) {
                            setState(() {
                              _numberFrom = rv;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'From',
                        style: labelStyle,
                      ),
                      DropdownButton<String>(
                        isExpanded: true,
                        style: inputStyle,
                        value: _startMeasure,
                        items: _measures.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: inputStyle),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _startMeasure = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'To',
                        style: labelStyle,
                      ),
                      DropdownButton<String>(
                        isExpanded: true,
                        style: inputStyle,
                        value: _convertedMeasure,
                        items: _measures.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: inputStyle),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _convertedMeasure = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        child: Text('Convert', style: inputStyle),
                        onPressed: () {
                          if (_numberFrom == 0) {
                            setState(() {
                              _resultMessage = 'Please enter a non-zero value';
                            });
                            return;
                          }
                          convert(_numberFrom, _startMeasure, _convertedMeasure);
                        },
                      ),
                      const SizedBox(height: 40),
                      Text(
                        _resultMessage ?? '',
                        style: labelStyle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}