import 'package:aluraflutter/screens/Transferencia/lista.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData( // Define o tema do aplicativo
        primaryColor: Colors.purple[800],
        accentColor: Colors.orange[600],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.orange[300],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: ListaTransferencias(),
    );
  }
}

















