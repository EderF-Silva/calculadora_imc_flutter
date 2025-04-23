import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: IMCCalculator(), debugShowCheckedModeBanner: false));
}

class IMCCalculator extends StatefulWidget {
  @override
  _IMCCalculatorState createState() => _IMCCalculatorState();
}

class _IMCCalculatorState extends State<IMCCalculator> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  double? _imc;
  String _message = '';
  Color _resultColor = Colors.black;

  void _calculateIMC() {
    double? weight = double.tryParse(weightController.text);
    double? height = double.tryParse(heightController.text);

    if (weight == null || height == null || height == 0) {
      setState(() {
        _message = 'Por favor, insira valores válidos!';
        _resultColor = Colors.red;
        _imc = null;
      });
      return;
    }

    double imc = weight / (height * height);

    String classification;
    Color color;

    if (imc < 18.5) {
      classification = 'Abaixo do peso';
      color = Colors.orange;
    } else if (imc < 24.9) {
      classification = 'Peso ideal';
      color = Colors.green;
    } else if (imc < 29.9) {
      classification = 'Sobrepeso';
      color = Colors.yellow[800]!;
    } else if (imc < 34.9) {
      classification = 'Obesidade Grau I';
      color = Colors.deepOrange;
    } else if (imc < 39.9) {
      classification = 'Obesidade Grau II';
      color = Colors.redAccent;
    } else {
      classification = 'Obesidade Grau III';
      color = Colors.red;
    }

    setState(() {
      _imc = imc;
      _message = 'IMC: ${imc.toStringAsFixed(2)}\n$classification';
      _resultColor = color;
    });
  }

  void _clearFields() {
    setState(() {
      weightController.clear();
      heightController.clear();
      _message = '';
      _imc = null;
      _resultColor = Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Peso (kg)'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Altura (m)'),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculateIMC,
              child: Text('Calcular'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _clearFields,
              child: Text('Limpar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[600],
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
            ),
            SizedBox(height: 32),
            Text(
              _message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: _resultColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
