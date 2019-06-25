import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _decimal = TextEditingController();
  TextEditingController _binary = TextEditingController();
  TextEditingController _octal = TextEditingController();
  TextEditingController _hexa = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conversor de Bases"),
        centerTitle: true,
        backgroundColor: Colors.red[700],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _clearAll();
              FocusScope.of(context).detach();
            },
            // Implementar key para identificar o pressionamento do botão e tirar foco
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 4.0),
            child: TextField(
              maxLines: 1,
              controller: _decimal,
              onChanged: _fromDec,
              keyboardType: TextInputType.numberWithOptions(decimal: false),
              decoration: InputDecoration(
                labelText: "Decimal",
                hintText: "0",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
            child: TextField(
              maxLines: 1,
              controller: _binary,
              onChanged: _fromBin,
              keyboardType: TextInputType.numberWithOptions(decimal: false),
              decoration: InputDecoration(
                  labelText: "Binário", hintText: "0", border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
            child: TextField(
              maxLines: 1,
              controller: _octal,
              onChanged: _fromOct,
              keyboardType: TextInputType.numberWithOptions(decimal: false),
              decoration:
                  InputDecoration(labelText: "Octal", hintText: "0", border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
            child: TextField(
              maxLines: 1,
              controller: _hexa,
              onChanged: _fromHex,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: "Hexadecimal", hintText: "0", border: OutlineInputBorder()),
            ),
          ),
        ],
      ),
    );
  }

  void _fromDec(String text) {
    setState(() {
      if (text.isNotEmpty) {
        _binary.text = _dec2bin(text);
        _octal.text = _dec2oct(text);
        _hexa.text = _dec2hex(text);
      } else {
        _clearAll();
      }
    });
  }

  void _fromBin(String text) {
    int exp = text.length - 1;
    int res = 0;

    for (int i = 0; i < text.length; i++) {
      res += int.parse(text[i]) * pow(2, exp - i);
    }
    setState(() {
      if (text.isNotEmpty) {
        _decimal.text = res.toString();
        _octal.text = _dec2oct(_decimal.text);
        _hexa.text = _dec2hex(_decimal.text);
      } else {
        _clearAll();
      }
    });
  }

  void _fromOct(String text) {
    int exp = text.length - 1;
    int res = 0;
    for (var i = 0; i < text.length; i++) {
      res += int.parse(text[i]) * pow(8, exp);
      exp--;
    }
    setState(() {
      if (text.isNotEmpty) {
        _decimal.text = res.toString();
        _binary.text = _dec2bin(res.toString());
        _hexa.text = _dec2hex(res.toString());
      } else {
        _clearAll();
      }
    });
  }

  void _fromHex(String text) {
    Map<String, int> especiais = {"A": 10, "B": 11, "C": 12, "D": 13, "E": 14, "F": 15};
    int exp = text.length - 1;
    print(exp);
    int res = 0;
    for (var i = 0; i < text.length; i++) {
      if (especiais.containsKey(text[i].toUpperCase())) {
        res += especiais[text[i].toUpperCase()] * pow(16, exp);
      } else {
        res += int.parse(text[i]) * pow(16, exp);
      }
      exp--;
    }
    setState(() {
      if (text.isNotEmpty) {
        _decimal.text = res.toString();
        _binary.text = _dec2bin(_decimal.text);
        _octal.text = _dec2oct(_decimal.text);
      } else {
        _clearAll();
      }
    });
  }

  void _clearAll() {
    setState(() {
      _decimal.text = "";
      _binary.text = "";
      _octal.text = "";
      _hexa.text = "";
    });
  }

  String _dec2bin(String text) {
    int dec = int.parse(text);
    String nBin = '';
    while (dec >= 1) {
      nBin = (dec % 2).toString() + nBin;
      dec ~/= 2;
    }
    return nBin;
  }

  String _dec2oct(String text) {
    String res = '';
    int dec = int.parse(text);
    while (dec >= 1) {
      res = (dec % 8).toString() + res;
      dec ~/= 8;
    }
    return res;
  }

  String _dec2hex(String text) {
    Map<int, String> especiais = {10: "A", 11: "B", 12: "C", 13: "D", 14: "E", 15: "F"};
    String res = '';
    int dec = int.parse(text), aux;
    while (dec >= 1) {
      if (dec % 16 > 9) {
        aux = dec % 16;
        res = especiais[aux].toString() + res;
      } else {
        res = (dec % 16).toString() + res;
      }
      dec ~/= 16;
    }
    return res;
  }
}
