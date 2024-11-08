import 'package:flutter/material.dart';
import 'package:receitasapp/common/decoration_forms.dart';
import 'package:receitasapp/common/my_colors.dart';
import 'package:receitasapp/components/my_snackbar.dart';
import 'package:receitasapp/models/receita_model.dart';
import 'package:receitasapp/screens/favoritos_id.dart';
import 'package:receitasapp/services/receita_service.dart';

class Favoritos extends StatefulWidget {
  const Favoritos({super.key});

  @override
  State<Favoritos> createState() => _FavoritosState();
}

class _FavoritosState extends State<Favoritos> {
  final ReceitaService receitaService = ReceitaService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            "Receitas Salvas",
            style: getTextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 26),
          child: StreamBuilder(
            stream: receitaService.streamReceitasFavoritas(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child:
                        Text('Erro ao carregar receitas: ${snapshot.error}'));
              } else {
                if (snapshot.hasData &&
                    snapshot.data != null &&
                    snapshot.data!.docs.isNotEmpty) {
                  List<ReceitaModel> listaReceitas = [];
                  for (var doc in snapshot.data!.docs) {
                    listaReceitas.add(ReceitaModel.fromMap(doc.data()));
                  }
                  return GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.92,
                    children: listaReceitas.map((receita) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FavoritosId(receitaModel: receita),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image:
                                              NetworkImage(receita.link_imagem),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      width: 160,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: IconButton(
                                        onPressed: () {
                                          receitaService
                                              .deleteReceitaFavorita(
                                                  receitaModel: receita)
                                              .then((value) {
                                            showMySnackBar(
                                                // ignore: use_build_context_synchronously
                                                context: context,
                                                text:
                                                    "Receita removida dos favoritos com sucesso!",
                                                isError: false);
                                          });
                                        },
                                        icon: const Icon(Icons.favorite,
                                            color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    receita.receita,
                                    style: getTextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black.withOpacity(0.75),
                                    ),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Ops! Parece que você ainda não salvou nenhuma receita! Explore o nosso cardápio e salve suas favoritas! Elas vão ser exibidas aqui!",
                        textAlign: TextAlign.justify,
                        style: getTextStyle(
                            fontSize: 17, fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(
                        height: 150,
                      ),
                      const Icon(
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
    );
  }
}
