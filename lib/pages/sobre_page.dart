import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'widgets/mensagem.dart';

class SobrePage extends StatefulWidget {
  const SobrePage({Key? key}) : super(key: key);

  @override
  _SobrePageState createState() => _SobrePageState();
}

class _SobrePageState extends State<SobrePage> {
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
        backgroundColor: Colors.brown,
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
      backgroundColor: Colors.brown[50],
      body: Container(
        padding: const EdgeInsets.all(50),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text('Sobre'),
                const SizedBox(height: 150),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text(
                    'Projeto proposto para ser utilizado na gestão de starter na empresa GFT'),
                const SizedBox(height: 150),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text('Aqui ficará a Imagem'),
                const Text('Luccas Garcia'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  campoTexto(texto, controller, icone, {senha}) {
    return TextField(
      controller: controller,
      obscureText: senha != null ? true : false,
      style: const TextStyle(
        color: Colors.brown,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(icone, color: Colors.brown),
        prefixIconColor: Colors.brown,
        labelText: texto,
        labelStyle: const TextStyle(color: Colors.brown),
        border: const OutlineInputBorder(),
        focusColor: Colors.brown,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.brown,
            width: 0.0,
          ),
        ),
      ),
    );
  }
}
