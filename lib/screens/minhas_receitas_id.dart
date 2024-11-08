import 'package:flutter/material.dart';
import 'package:receitasapp/common/decoration_forms.dart';
import 'package:receitasapp/common/my_colors.dart';
import 'package:receitasapp/models/receita_model.dart';

class MinhasReceitasId extends StatefulWidget {
  final ReceitaModel receitaModel;
  const MinhasReceitasId({super.key, required this.receitaModel});

  @override
  State<MinhasReceitasId> createState() => _MinhasReceitasIdState();
}

class _MinhasReceitasIdState extends State<MinhasReceitasId> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 50),
                  child: Image.network(
                    widget.receitaModel.link_imagem,
                    width: double.infinity,
                    height: 235,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 80,
                  child: Container(
                    height: 60,
                    width: 260,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyColors.cinzaPrincipal,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.receitaModel.tempo,
                          style: getTextStyle(
                              fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                        VerticalDivider(
                          color: MyColors.azulPrincipal,
                          width: 2,
                        ),
                        Text(
                          widget.receitaModel.porcao,
                          style: getTextStyle(
                              fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 26, right: 26, bottom: 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Tipo: ${widget.receitaModel.tipo}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Descrição:",
                    style:
                        getTextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.receitaModel.descricao,
                    style: getTextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: MyColors.textoAzul),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "Ingredientes:",
                    style:
                        getTextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(0),
                    itemCount:
                        widget.receitaModel.ingredientes.split(',').length,
                    itemBuilder: (context, index) {
                      String ingrediente = widget.receitaModel.ingredientes
                          .split(',')[index]
                          .trim();
                      return ListTile(
                        dense: true,
                        leading: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Icon(
                            Icons.circle,
                            size: 8,
                          ),
                        ),
                        title: Text(
                          ingrediente,
                          style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: MyColors.textoAzul),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        visualDensity: VisualDensity.compact,
                      );
                    },
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Modo de Preparo:',
                    style:
                        getTextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.receitaModel.modo_preparo,
                    textAlign: TextAlign.justify,
                    style: getTextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: MyColors.textoAzul),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
