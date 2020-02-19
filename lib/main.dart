import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController weightController = new TextEditingController();
  TextEditingController heightController = new TextEditingController();
  String _infoText = 'Informe seus dados';

  _resetText() {
    weightController.text = '';
    heightController.text = '';
    setState(() {
      _infoText = 'Informe seus dados';
    });
  }

  _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      String imcFormat = (weight / (height * height)).toStringAsPrecision(4);

      if (imc < 16) {
        _infoText = 'Desnutrido ($imcFormat)';
      } else if (imc < 17) {
        _infoText = 'Muito abaixo do peso ($imcFormat))';
      } else if (imc < 25) {
        _infoText = 'Peso ideal ($imcFormat)';
      } else if (imc < 30) {
        _infoText = 'Acima do peso ($imcFormat)';
      } else if (imc < 35) {
        _infoText = 'Obesidade grau I ($imcFormat)';
      } else if (imc < 40) {
        _infoText = 'Obesidade grau II ($imcFormat)';
      } else {
        _infoText = 'Obesidade grau III ($imcFormat)';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetText,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person, size: 120.0, color: Colors.deepOrangeAccent),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Peso (Kg)',
                      labelStyle: TextStyle(color: Colors.deepOrangeAccent)),
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.deepOrangeAccent, fontSize: 25.0),
                  controller: weightController,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Informe seu peso!';
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Altura (Cm)',
                      labelStyle: TextStyle(color: Colors.deepOrangeAccent)),
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.deepOrangeAccent, fontSize: 25.0),
                  controller: heightController,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Informe sua altura!';
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calculate();
                          }
                        },
                        child: Text('Calcular',
                            style:
                                TextStyle(color: Colors.white, fontSize: 25.0)),
                        color: Colors.deepOrangeAccent,
                      )),
                ),
                Text(
                  _infoText,
                  style:
                      TextStyle(color: Colors.deepOrangeAccent, fontSize: 25.0),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          )),
    );
  }
}
