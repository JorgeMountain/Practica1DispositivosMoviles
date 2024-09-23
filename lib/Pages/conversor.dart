import 'package:flutter/material.dart';

class Conversor extends StatefulWidget {
  const Conversor({super.key});

  @override
  State<Conversor> createState() => _ConversorState();
}

class _ConversorState extends State<Conversor> {
  final TextEditingController _cantidad = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'COP';
  double _result = 0.0;
  final Map<String, double> _monedas = {
    'USD': 1.0, // Moneda Base
    'EUR': 0.91,
    'COP': 4289.95,
  };

  void _convert() {
    double amount = double.tryParse(_cantidad.text) ?? 0;
    if (amount >= 0) {
      double fromRate = _monedas[_fromCurrency] ?? 1.0;
      double toRate = _monedas[_toCurrency] ?? 1.0;
      setState(() {
        _result = amount * (toRate / fromRate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Conversor de Monedas",
          style: TextStyle(
            fontSize: 26, // Tamaño de la fuente del título
            fontWeight: FontWeight.bold, // Negrita
            color: Colors.brown, // Color del texto
          ),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/images/money.png'),
              width: 150,
              height: 150,
            ),
            const SizedBox(
              height: 40.0,
            ),
            TextField(
              controller: _cantidad,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Cantidad",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: _fromCurrency,
                    items: _monedas.keys.map((String currency) {
                      return DropdownMenuItem<String>(
                        value: currency,
                        child: Text(currency),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _fromCurrency = newValue!;
                      });
                    },
                  ),
                ),
                const Text(' → '),
                Expanded(
                  child: DropdownButton<String>(
                    value: _toCurrency,
                    items: _monedas.keys.map((String currency) {
                      return DropdownMenuItem<String>(
                        value: currency,
                        child: Text(currency),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _toCurrency = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Convertir'),
            ),
            const SizedBox(height: 16),
            Text(
              'Resultado: $_result $_toCurrency',
              //style: Theme.of(context).textTheme.headlineMedium,
              style: TextStyle(
                fontSize: 26, // Tamaño de la fuente del título
                fontWeight: FontWeight.bold, // Negrita
                color: Colors.brown, // Color del texto
            ),
            ),
          ],
        ),
      ),
    );
  }
}
