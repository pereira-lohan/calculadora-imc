import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _info = "Insira seus dados";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Color cor = Colors.blue;

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _info = "Insira seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _info = "Abaixo do Peso (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _info = "Peso Ideal (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _info = "Levemente Acima do Peso (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _info = "Obesidade Grau I (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _info = "Obesidade Grau II (${imc.toStringAsPrecision(2)})";
      } else if (imc >= 40) {
        _info = "Obesidade Grau III (${imc.toStringAsPrecision(2)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: cor,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
        ],
      ),
      backgroundColor: Color(0x344a54344a54),
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person, size: 120.0, color: cor),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: cor)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: cor, fontSize: 25.0),
                  controller: weightController,
                  validator: (value) {
                    if (value.isEmpty){
                      return "Insira o Peso";
                    }
                    if (!(double.tryParse(value) is double)){
                      return "Insira um Número";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: cor)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: cor, fontSize: 25.0),
                  controller: heightController,
                  validator: (value) {
                    if (value.isEmpty){
                      return "Insira a Altura";
                    }
                    if (!(double.tryParse(value) is double)){
                      return "Insira um Número";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: (){
                        if (_formKey.currentState.validate()) {
                          _calculate();
                        }
                      },
                      child: Text("Calcular",
                          style:
                              TextStyle(color: Colors.white, fontSize: 25.0)),
                      color: cor,
                    ),
                  ),
                ),
                Text(_info,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: cor, fontSize: 25.0))
              ],
            ),
          )),
    );
  }
}
