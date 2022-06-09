import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'widgets/mensagem.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  var txtNome = TextEditingController();
  var txtPreco = TextEditingController();

  //Retonar um documento pelo ID
  retornarDocumentoById(id) async {
    await FirebaseFirestore.instance
        .collection('cafes')
        .doc(id)
        .get()
        .then((doc) {
      txtNome.text = doc.get('nome');
      txtPreco.text = doc.get('preco');
    });
  }

  @override
  Widget build(BuildContext context) {
    //Recuperar o id do Café
    var id = ModalRoute.of(context)!.settings.arguments;
    if (id != null) {
      if (txtNome.text.isEmpty && txtPreco.text.isEmpty) {
        retornarDocumentoById(id);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestão Starters GFT'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 70),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    minimumSize: const Size(200, 45),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('Cadastro Starters'),
                  onPressed: () {
                    Navigator.pushNamed(context, 'starter_list');
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 70),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    minimumSize: const Size(200, 45),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('Infromar Daily'),
                  onPressed: () {
                    Navigator.pushNamed(context, 'daily_starter');
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 70),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    minimumSize: const Size(200, 45),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('Avaliar Projeto'),
                  onPressed: () {
                    Navigator.pushNamed(context, 'projeto_starter');
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 200),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    minimumSize: const Size(200, 45),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('Sobre o Projeto'),
                  onPressed: () {
                    Navigator.pushNamed(context, 'sobre');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
