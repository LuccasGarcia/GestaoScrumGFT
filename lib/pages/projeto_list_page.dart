import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gestao_scrum_gft/pages/widgets/mensagem.dart';

class ProjetoListPage extends StatefulWidget {
  const ProjetoListPage({Key? key}) : super(key: key);

  @override
  _ProjetoListPageState createState() => _ProjetoListPageState();
}

class _ProjetoListPageState extends State<ProjetoListPage> {
  //Declaracao da colecao de cafes
  var projetos;

  @override
  void initState() {
    super.initState();
    projetos =
        FirebaseFirestore.instance.collection('projetos'); //Select do NoSQL
  }

  @override
  Widget build(BuildContext context) {
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

        //
        //Exibir os documentos da colecao
        //
        child: StreamBuilder<QuerySnapshot>(
          //fonte de dados
          stream: projetos.snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(child: Text('Não foi possível conectar.'));
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                final dados = snapshot.requireData;
                return ListView.builder(
                  itemCount: dados.size,
                  itemBuilder: (context, index) {
                    return exibirDocumento(dados.docs[index]);
                  },
                );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'projeto_inserir');
        },
      ),
    );
  }

  exibirDocumento(item) {
    String modulo = item.data()['modulo'];
    String nota = item.data()['nota'];
    return ListTile(
      title: Text(modulo),
      subtitle: Text(nota),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: () {
          projetos.doc(item.id).delete();
          sucesso(context, 'Item removido com sucesso');
        },
      ),

      //Passar como argumento o ID do cafe
      onTap: () {
        Navigator.pushNamed(
          context,
          'projeto_inserir',
          arguments: item.id,
        );
      },
    );
  }
}
