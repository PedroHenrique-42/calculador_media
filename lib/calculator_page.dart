import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _firstGradeTextController =
      TextEditingController();
  final TextEditingController _secondGradeTextController =
      TextEditingController();
  final TextEditingController _thirdGradeTextController =
      TextEditingController();

  final _gradeInputFormatter = FilteringTextInputFormatter.allow(
    RegExp(r'^\d*\,?\d{0,2}'),
  );

  final _gradeTextInputType = TextInputType.numberWithOptions(
    decimal: true,
  );

  String? _commonValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  String? _name;
  String? _email;
  String? _grades;
  String? _average;

  double _calculateAverage({
    required double firstGrade,
    required double secondGrade,
    required double thirdGrade,
  }) {
    return (firstGrade + secondGrade + thirdGrade) / 3;
  }

  void _clearTextControllers() {
    _nameTextController.clear();
    _emailTextController.clear();
    _firstGradeTextController.clear();
    _secondGradeTextController.clear();
    _thirdGradeTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculador de Média')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameTextController,
                    decoration: InputDecoration(label: Text('Nome')),
                    validator: _commonValidator,
                  ),
                  TextFormField(
                    controller: _emailTextController,
                    decoration: InputDecoration(label: Text('E-mail')),
                    validator: _commonValidator,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _firstGradeTextController,
                          decoration: InputDecoration(label: Text('Nota 1')),
                          inputFormatters: [_gradeInputFormatter],
                          keyboardType: _gradeTextInputType,
                          validator: _commonValidator,
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _secondGradeTextController,
                          decoration: InputDecoration(label: Text('Nota 2')),
                          inputFormatters: [_gradeInputFormatter],
                          keyboardType: _gradeTextInputType,
                          validator: _commonValidator,
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _thirdGradeTextController,
                          decoration: InputDecoration(label: Text('Nota 3')),
                          inputFormatters: [_gradeInputFormatter],
                          keyboardType: _gradeTextInputType,
                          validator: _commonValidator,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState != null &&
                      !_formKey.currentState!.validate()) {
                    return;
                  }

                  setState(() {
                    final firstGradeNumber = double.parse(
                      _firstGradeTextController.text.replaceAll(',', '.'),
                    );
                    final secondGradeNumber = double.parse(
                      _secondGradeTextController.text.replaceAll(',', '.'),
                    );
                    final thirdGradeNumber = double.parse(
                      _thirdGradeTextController.text.replaceAll(',', '.'),
                    );

                    _name = _nameTextController.text;
                    _email = _emailTextController.text;
                    _grades =
                        '${firstGradeNumber.toStringAsFixed(2)} - ${secondGradeNumber.toStringAsFixed(2)} - ${thirdGradeNumber.toStringAsFixed(2)}';

                    _average = _calculateAverage(
                      firstGrade: firstGradeNumber,
                      secondGrade: secondGradeNumber,
                      thirdGrade: thirdGradeNumber,
                    ).toStringAsFixed(2);
                  });
                },
                child: Text('CALCULAR MÉDIA'),
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Resultado:'),
                  Text('Nome: ${_name ?? ''}'),
                  Text('E-mail: ${_email ?? ''}'),
                  Text('Notas: ${_grades ?? ''}'),
                  Text('Média: ${_average ?? ''}'),
                ],
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _name = null;
                    _email = null;
                    _grades = null;
                    _average = null;

                    _clearTextControllers();
                    FocusScope.of(context).unfocus();
                  });
                },
                child: Text('APAGAR OS CAMPOS'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
