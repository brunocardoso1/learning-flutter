import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());



class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencias(),
      ),
    );
  }
}




class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta = TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Criando Transferencia')),
        body: Column(
          children: [
            Editor(controlador: _controladorCampoNumeroConta, rotulo: "Numero da conta", dica: "0000"),
            Editor(controlador: _controladorCampoValor, rotulo: "Valor", dica: "0.00", icone: Icons.monetization_on),

            RaisedButton(
              child: Text('Confirmar'),
              onPressed: () => _criaTransferencia(context),
            )
          ],
        ));
  }

  void _criaTransferencia(BuildContext context) {
    final double valor = double.tryParse(_controladorCampoValor.text);
    final int numeroConta = int.tryParse(_controladorCampoNumeroConta.text);

    if(numeroConta != null && valor != null){
      final transferenciaCriada = Transferencia(valor, numeroConta);
      debugPrint('Criando transferencia');
      debugPrint('$transferenciaCriada');
      Navigator.pop(context, transferenciaCriada);
    }
  }
}


class Editor extends StatelessWidget {

  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData icone;


  Editor({this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(
            fontSize: 16.0
        ),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
            labelText: rotulo, hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}






class ListaTransferencias extends StatelessWidget{
  final List<Transferencia> _transferencias = List();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _transferencias.add(Transferencia(100, 1111));

    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: ListView.builder(
        itemCount: _transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = _transferencias[indice];
          return ItemTransferencia(transferencia);
        },

      ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: (){
            final Future<Transferencia> future = Navigator.push(context, MaterialPageRoute(builder: (context){
              return FormularioTransferencia();
            }));
            future.then((transferenciaRecebida) {
              debugPrint('Chegou no then do future');
              debugPrint('$transferenciaRecebida');
              _transferencias.add(transferenciaRecebida);
            });

        },
        ),
    );
  }
}


class ItemTransferencia extends StatelessWidget {

  Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        child: ListTile(
          leading: Icon(Icons.account_balance_wallet_rounded),
          title: Text(_transferencia.valor.toString()),
          subtitle: Text(_transferencia.valor.toString()),
        )
    );
  }

}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString(){
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }

}