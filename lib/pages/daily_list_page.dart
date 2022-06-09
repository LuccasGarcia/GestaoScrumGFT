import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gestao_scrum_gft/pages/widgets/mensagem.dart';

class DailyListPage extends StatefulWidget {
  const DailyListPage({Key? key}) : super(key: key);

  @override
  _DailyListPageState createState() => _DailyListPageState();
}

class _DailyListPageState extends State<DailyListPage> {
  //Declaracao da colecao de cafes
  var dailys;

  @override
  void initState() {
    super.initState();
    dailys = FirebaseFirestore.instance.collection('dailys'); //Select do NoSQL
  }

  @override
  Widget build(BuildContext context) {
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

        //
        //Exibir os documentos da colecao
        //
        child: StreamBuilder<QuerySnapshot>(
          //fonte de dados
          stream: dailys.snapshots(),
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
        backgroundColor: Colors.brown,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'daily_inserir');
        },
      ),
    );
  }

  exibirDocumento(item) {
    String data = item.data()['data'];
    String feito = item.data()['feito'];
    String fazendo = item.data()['fazendo'];
    String impedimentos = item.data()['impedimentos'];
    return ListTile(
      title: Text(data),
      // subtitle: Text(feito),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: () {
          dailys.doc(item.id).delete();
          sucesso(context, 'Item removido com sucesso');
        },
      ),

      //Passar como argumento o ID do cafe
      onTap: () {
        Navigator.pushNamed(
          context,
          'daily_inserir',
          arguments: item.id,
        );
      },
    );
  }
}
