import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:receitasapp/common/decoration_forms.dart';
import 'package:receitasapp/common/my_colors.dart';
import 'package:receitasapp/models/receita_model.dart';
import 'package:receitasapp/screens/add_edit_receita.dart';
import 'package:receitasapp/screens/minhas_receitas_id.dart';
import 'package:receitasapp/services/receita_service.dart';

class MinhasReceitas extends StatefulWidget {
  final User user;
  const MinhasReceitas({super.key, required this.user});

  @override
  State<MinhasReceitas> createState() => _MinhasReceitasState();
}

class _MinhasReceitasState extends State<MinhasReceitas> {
  final ReceitaService receitaService = ReceitaService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 38),
            child: Text(
              "Minhas receitas",
              style: getTextStyle(fontSize: 26, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 26),
              child: StreamBuilder(
                stream: receitaService.streamReceitas(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text(
                            'Erro ao carregar receitas: ${snapshot.error}'));
                  } else {
                    if (snapshot.hasData &&
                        snapshot.data != null &&
                        snapshot.data!.docs.isNotEmpty) {
                      List<ReceitaModel> listaReceitas = [];
                      for (var doc in snapshot.data!.docs) {
                        listaReceitas.add(ReceitaModel.fromMap(doc.data()));
                      }
                      return ListView.builder(
                        itemCount: listaReceitas.length,
                        itemBuilder: (context, index) {
                          ReceitaModel receitaModel = listaReceitas[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MinhasReceitasId(
                                      receitaModel: receitaModel),
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: MyColors
                                        .cinzaPrincipal, // Arredonda todos os cantos
                                  ),
                                  height: 65,
                                  margin: EdgeInsets.only(bottom: 16),
                                  alignment: Alignment.center,
                                  child: ListTile(
                                    title: Text(
                                      receitaModel.receita,
                                      style: getTextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ), // Adicionamos o título do cinema
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 9,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddEditReceita(
                                                receitaModel: receitaModel,
                                              ),
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.edit_note_outlined),
                                        iconSize: 28,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title:
                                                      Text("Excluir Receita"),
                                                  content: Text(
                                                      "Deseja mesmo escluir ${receitaModel.receita}?"),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(context,
                                                              'Cancelar'),
                                                      child: const Text(
                                                        'Cancelar',
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        receitaService
                                                            .deleteReceita(
                                                                receitaModel:
                                                                    receitaModel)
                                                            .then(
                                                          (value) {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        );
                                                      },
                                                      child: const Text(
                                                        'Excluir',
                                                        style: TextStyle(
                                                            color: MyColors
                                                                .azulPrincipal),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        icon:
                                            Icon(Icons.delete_outline_rounded),
                                        iconSize: 28,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Ops! Parece que você ainda não cadastrou nenhuma receita! Adicione suas receitas e elas serão exibidas aqui!",
                            textAlign: TextAlign.justify,
                            style: getTextStyle(
                                fontSize: 17, fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 150,
                          ),
                          Icon(
                            Icons.fastfood_outlined,
                            size: 130,
                            color: MyColors.azulPrincipal,
                          ),
                        ],
                      );
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
