import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestao_scrum_gft/pages/widgets/campoTexto.dart';

import 'widgets/mensagem.dart';

class StarterInserirPage extends StatefulWidget {
  const StarterInserirPage({Key? key}) : super(key: key);

  @override
  _StarterInserirPageState createState() => _StarterInserirPageState();
}

class _StarterInserirPageState extends State<StarterInserirPage> {
  var txtNome = TextEditingController();
  var txtTecnologia = TextEditingController();

  //Retonar um documento pelo ID
  retornarDocumentoById(id) async {
    await FirebaseFirestore.instance
        .collection('starters')
        .doc(id)
        .get()
        .then((doc) {
      txtNome.text = doc.get('nome');
      txtTecnologia.text = doc.get('tecnologia');
    });
  }

  @override
  Widget build(BuildContext context) {
    //Recuperar o id do Café
    var id = ModalRoute.of(context)!.settings.arguments;
    if (id != null) {
      if (txtNome.text.isEmpty && txtTecnologia.text.isEmpty) {
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
              'Cadastro de Starters',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Color.fromARGB(255, 1, 55, 99),
              ),
            )),
            campoTexto('Nome', txtNome, Icons.person_add),
            const SizedBox(height: 20),
            campoTexto('Tecnologia', txtTecnologia, Icons.computer_outlined),
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
                        FirebaseFirestore.instance.collection('starters').add({
                          "nome": txtNome.text,
                          "tecnologia": txtTecnologia.text,
                        });
                        sucesso(context, 'Item adicionado com sucesso.');
                      } else {
                        FirebaseFirestore.instance
                            .collection('starters')
                            .doc(id.toString())
                            .set({
                          "nome": txtNome.text,
                          "tecnologia": txtTecnologia.text,
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
