import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:receitasapp/common/decoration_forms.dart';
import 'package:receitasapp/components/my_snackbar.dart';
import 'package:receitasapp/models/receita_model.dart';
import 'package:receitasapp/screens/receita_id.dart';
import 'package:receitasapp/services/api.dart';
import 'package:receitasapp/services/receita_service.dart';
import 'package:uuid/uuid.dart';

class MyReceitas extends StatefulWidget {
  final String? filtros;
  const MyReceitas({super.key, required this.filtros});

  @override
  State<MyReceitas> createState() => _MyReceitasState();
}

class _MyReceitasState extends State<MyReceitas> {
  List<dynamic>? receitas;

  final player = AudioPlayer();

  final ReceitaService _receitaService = ReceitaService();

  bool isLoading = true;

  void _executar() {
    player.play(AssetSource("button-pressed.mp3"));
  }

  Future<void> fetchReceitas() async {
    try {
      setState(() {
        isLoading = true;
      });
      // Carrega todas as receitas
      final todasReceitas = await ApiReceitas.fetchReceitas();

      if (widget.filtros != null && widget.filtros != 'Filtros') {
        receitas = todasReceitas.where((receita) {
          return receita['tipo'] == widget.filtros;
        }).toList();
      } else {
        receitas = todasReceitas;
      }

      print("Receitas filtradas: $receitas");

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Erro ao carregar as receitas: $e');
    }
  }

  void favoritarReceita(String idReceita) {
    print(idReceita);

    int id = int.parse(idReceita);

    final recipe = receitas![id - 1];

    print(recipe);

    String receita = recipe['receita'];
    String cine = recipe['cine'];
    String descricao = recipe['descricao'];
    String modo_preparo = recipe['modo_preparo'];
    String ingredientes = recipe['ingredientes'];
    String link_imagem = recipe['link_imagem'];
    String tipo = recipe['tipo'];
    String porcao = recipe['porcao'];
    String tempo = recipe['tempo'];
    bool favorite = true;

    ReceitaModel receitaModel = ReceitaModel(
        id: Uuid().v1(),
        receita: receita,
        cine: cine,
        descricao: descricao,
        ingredientes: ingredientes,
        modo_preparo: modo_preparo,
        porcao: porcao,
        tempo: tempo,
        link_imagem: link_imagem,
        tipo: tipo,
        favorite: favorite);

    _receitaService.addFavoritos(receitaModel).then((value) {
      showMySnackBar(
          context: context,
          isError: false,
          text: "Receita favoritada com sucesso!");
    });
  }

  @override
  void initState() {
    super.initState();
    fetchReceitas();
  }

  @override
  void didUpdateWidget(covariant MyReceitas oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Verifica se o filtro mudou e chama fetchReceitas novamente
    if (widget.filtros != oldWidget.filtros) {
      fetchReceitas(); // Recarrega as receitas com o novo filtro
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : CustomScrollView(
              primary: false,
              slivers: <Widget>[
                SliverPadding(
                  padding: EdgeInsets.all(0),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 212,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final recipe = receitas![index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (
                                  context,
                                ) =>
                                    ReceitaId(idReceita: recipe['id']),
                              ),
                            );
                          },
                          child: Container(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              recipe['link_imagem']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      width: 160,
                                      height: 150,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: IconButton(
                                        onPressed: () {
                                          favoritarReceita(recipe['id']);
                                          _executar();
                                        },
                                        icon: Icon(Icons.favorite_outline,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, left: 12),
                                      child: Text(
                                        style: getTextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Colors.black.withOpacity(0.75)),
                                        "${recipe['cine']}: ${recipe['receita']}",
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: receitas!.length,
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
