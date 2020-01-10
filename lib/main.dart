import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        title: Text("Conversor de Bases Numéricas"),
        centerTitle: true,
        backgroundColor: Colors.red[700],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _clearAll();
              FocusScope.of(context).unfocus();
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 4.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 70,
                  height: 60,
                  alignment: Alignment.center,
                  child: Text(
                    "DEC",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.red[700],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(4),
                          topLeft: Radius.circular(4))),
                ),
                Expanded(
                  child: TextField(
                    maxLines: 1,
                    controller: _decimal,
                    onChanged: _fromDec,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: false),
                    inputFormatters: [
                      WhitelistingTextInputFormatter(
                        RegExp(
                          '[\0, \1, \2, \3, \4, \5, \6, \7, \8, \9,]',
                        ),
                      )
                    ],
                    // inputFormatters: <TextInputFormatter>[
                    //   WhitelistingTextInputFormatter.digitsOnly
                    // ],
                    decoration: InputDecoration(
                        labelText: "Decimal",
                        hintText: "0",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(4.0),
                                bottomRight: Radius.circular(4.0)))),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 70,
                  height: 60,
                  alignment: Alignment.center,
                  child: Text(
                    "BIN",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.red[700],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(4),
                          topLeft: Radius.circular(4))),
                ),
                Expanded(
                  child: TextField(
                    maxLines: 1,
                    controller: _binary,
                    onChanged: _fromBin,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: false),
                    inputFormatters: [
                      WhitelistingTextInputFormatter(
                        RegExp('[\0, \1]'),
                      )
                    ],
                    // inputFormatters: <TextInputFormatter>[
                    //   WhitelistingTextInputFormatter.digitsOnly
                    // ],
                    decoration: InputDecoration(
                        labelText: "Binário",
                        hintText: "0",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(4.0),
                                bottomRight: Radius.circular(4.0)))),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 70,
                  height: 60,
                  alignment: Alignment.center,
                  child: Text(
                    "OCT",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.red[700],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(4),
                          topLeft: Radius.circular(4))),
                ),
                Expanded(
                  child: TextField(
                    maxLines: 1,
                    controller: _octal,
                    onChanged: _fromOct,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: false),
                    inputFormatters: [
                      WhitelistingTextInputFormatter(
                        RegExp('[\0, \1, \2, \3, \4, \5, \6, \7,]',
                            caseSensitive: false),
                      )
                    ],
                    // inputFormatters: <TextInputFormatter>[
                    //   WhitelistingTextInputFormatter.digitsOnly
                    // ],
                    decoration: InputDecoration(
                        labelText: "Octal",
                        hintText: "0",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(4.0),
                                bottomRight: Radius.circular(4.0)))),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 70,
                  height: 60,
                  alignment: Alignment.center,
                  child: Text(
                    "HEX",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.red[700],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(4),
                          topLeft: Radius.circular(4))),
                ),
                Expanded(
                  child: TextField(
                    maxLines: 1,
                    controller: _hexa,
                    onChanged: _fromHex,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.characters,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(
                        RegExp(
                            '[\0, \1, \2, \3, \4, \5, \6, \7, \8, \9, \a, \A, \b, \B, \c, \C, \d, \D, \e, \E, \f, \F]',
                            caseSensitive: false),
                      )
                    ],
                    decoration: InputDecoration(
                        labelText: "Hexadecimal",
                        hintText: "0",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(4.0),
                                bottomRight: Radius.circular(4.0)))),
                  ),
                ),
              ],
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
    Map<String, int> especiais = {
      "A": 10,
      "B": 11,
      "C": 12,
      "D": 13,
      "E": 14,
      "F": 15
    };
    int exp = text.length - 1;
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
    Map<int, String> especiais = {
      10: "A",
      11: "B",
      12: "C",
      13: "D",
      14: "E",
      15: "F"
    };
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
