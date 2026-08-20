import 'package:flutter/material.dart';

import 'conversion.dart';

void main() => runApp(const ConverterApp());

class ConverterApp extends StatelessWidget {
  const ConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measures Converter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ConverterPage(),
    );
  }
}

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  double? _numberFrom;
  String _startMeasure = 'meters';
  String _convertedMeasure = 'feet';
  String? _resultMessage;

  void _convert() {
    final value = _numberFrom;
    if (value == null) {
      setState(() {
        _resultMessage = 'Please enter a valid number';
      });
      return;
    }

    final result = convertValue(value, _startMeasure, _convertedMeasure);

    setState(() {
      if (result == null) {
        _resultMessage = 'Choose two compatible units';
      } else {
        _resultMessage =
            '${_formatNumber(value)} $_startMeasure = ${_formatNumber(result)} $_convertedMeasure';
      }
    });
  }

  String _formatNumber(double value) {
    final formatted = value.toStringAsFixed(6);
    return formatted.replaceFirst(RegExp(r'\.?0+$'), '');
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Measures Converter'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Value', style: textTheme.titleLarge),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter a value to convert',
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                onChanged: (text) {
                  setState(() {
                    _numberFrom = double.tryParse(text.trim());
                  });
                },
              ),
              const SizedBox(height: 24),
              Text('From', style: textTheme.titleLarge),
              DropdownButton<String>(
                isExpanded: true,
                value: _startMeasure,
                items: supportedUnits
                    .map(
                      (unit) => DropdownMenuItem<String>(
                        value: unit,
                        child: Text(unit),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _startMeasure = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 24),
              Text('To', style: textTheme.titleLarge),
              DropdownButton<String>(
                isExpanded: true,
                value: _convertedMeasure,
                items: supportedUnits
                    .map(
                      (unit) => DropdownMenuItem<String>(
                        value: unit,
                        child: Text(unit),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _convertedMeasure = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 32),
              FilledButton(
                onPressed: _convert,
                child: const Text('Convert'),
              ),
              const SizedBox(height: 32),
              if (_resultMessage != null)
                Text(
                  _resultMessage!,
                  style: textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
