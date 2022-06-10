import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestao_scrum_gft/pages/widgets/campoTexto.dart';

import 'widgets/mensagem.dart';

class DailyInserirPage extends StatefulWidget {
  const DailyInserirPage({Key? key}) : super(key: key);

  @override
  _DailyInserirPageState createState() => _DailyInserirPageState();
}

class _DailyInserirPageState extends State<DailyInserirPage> {
  var txtData = TextEditingController();
  var txtFeito = TextEditingController();
  var txtFazendo = TextEditingController();
  var txtImpedimentos = TextEditingController();

  //Retonar um documento pelo ID
  retornarDocumentoById(id) async {
    await FirebaseFirestore.instance
        .collection('dailys')
        .doc(id)
        .get()
        .then((doc) {
      txtData.text = doc.get('data');
      txtFeito.text = doc.get('feito');
      txtFazendo.text = doc.get('fazendo');
      txtImpedimentos.text = doc.get('impedimentos');
    });
  }

  @override
  Widget build(BuildContext context) {
    //Recuperar o id do Café
    var id = ModalRoute.of(context)!.settings.arguments;
    if (id != null) {
      if (txtData.text.isEmpty && txtFeito.text.isEmpty) {
        retornarDocumentoById(id);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestão Starters GFT'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        // automaticallyImplyLeading: false,
        actions: [
          Column(
            children: [
              IconButton(
                tooltip: 'sair',
                onPressed: () {
                  FirebaseAuth.instance.signOut(); //faz logout
                  Navigator.pushReplacementNamed(context, 'login');
                },
                icon: const Icon(Icons.logout),
              ),
              Text(
                FirebaseAuth.instance.currentUser!.email
                    .toString(), //recupera o email do currentuser
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
      backgroundColor: Colors.blue[50],
      body: Container(
        padding: const EdgeInsets.all(50),
        child: ListView(
          children: [
            Center(
                child: Text(
              'Informar Daily',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Color.fromARGB(255, 1, 55, 99),
              ),
            )),
            campoTexto('Data', txtData, Icons.calendar_today_outlined),
            const SizedBox(height: 20),
            campoTexto('Feito', txtFeito, Icons.work),
            const SizedBox(height: 40),
            campoTexto('Fazendo', txtFazendo, Icons.construction_outlined),
            const SizedBox(height: 20),
            campoTexto(
                'Impedimentos', txtImpedimentos, Icons.warning_amber_outlined),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      minimumSize: const Size(200, 45),
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text('Salvar'),
                    onPressed: () {
                      if (id == null) {
                        //Adicionar um novo documento
                        FirebaseFirestore.instance.collection('dailys').add({
                          "data": txtData.text,
                          "feito": txtFeito.text,
                          "fazendo": txtFazendo.text,
                          "impedimentos": txtImpedimentos.text,
                        });
                        sucesso(context, 'Item adicionado com sucesso.');
                      } else {
                        FirebaseFirestore.instance
                            .collection('dailys')
                            .doc(id.toString())
                            .set({
                          "data": txtData.text,
                          "feito": txtFeito.text,
                          "fazendo": txtFazendo.text,
                          "impedimentos": txtImpedimentos.text,
                        });
                        sucesso(context, 'Item alterado com sucesso.');
                      }

                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 150,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        minimumSize: const Size(200, 45),
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text('Cancelar'),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
