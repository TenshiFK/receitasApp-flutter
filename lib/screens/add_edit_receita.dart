import 'package:flutter/material.dart';
import 'package:receitasapp/common/decoration_forms.dart';
import 'package:receitasapp/common/my_colors.dart';
import 'package:receitasapp/components/my_snackbar.dart';
import 'package:receitasapp/models/receita_model.dart';
import 'package:receitasapp/services/receita_service.dart';
import 'package:uuid/uuid.dart';

class AddEditReceita extends StatefulWidget {
  final ReceitaModel? receitaModel;
  const AddEditReceita({super.key, this.receitaModel});

  @override
  State<AddEditReceita> createState() => _AddEditReceitaState();
}

class _AddEditReceitaState extends State<AddEditReceita> {
  TextEditingController _receitaController = TextEditingController();
  TextEditingController _cineController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();
  TextEditingController _modo_preparoController = TextEditingController();
  TextEditingController _ingredientesController = TextEditingController();
  TextEditingController _link_imagemController = TextEditingController();
  TextEditingController _tipoController = TextEditingController();
  TextEditingController _porcaoController = TextEditingController();
  TextEditingController _tempoController = TextEditingController();

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  ReceitaService _receitaService = ReceitaService();

  enviarForm() {
    String receita = _receitaController.text;
    String cine = _cineController.text;
    String descricao = _descricaoController.text;
    String modo_preparo = _modo_preparoController.text;
    String ingredientes = _ingredientesController.text;
    String link_imagem = _link_imagemController.text;
    String tipo = _tipoController.text;
    String porcao = _porcaoController.text;
    String tempo = _tempoController.text;

    ReceitaModel receitaForm = ReceitaModel(
        id: Uuid().v1(),
        receita: receita,
        cine: cine,
        descricao: descricao,
        ingredientes: ingredientes,
        modo_preparo: modo_preparo,
        porcao: porcao,
        tempo: tempo,
        link_imagem: link_imagem,
        tipo: tipo);

    if (widget.receitaModel != null) {
      receitaForm.id = widget.receitaModel!.id;
    }

    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      _receitaService.addReceita(receitaForm).then((value) {
        setState(() {
          isLoading = false;
          _receitaController.text = "";
          _cineController.text = "";
          _descricaoController.text = "";
          _modo_preparoController.text = "";
          _ingredientesController.text = "";
          _link_imagemController.text = "";
          _tipoController.text = "";
          _porcaoController.text = "";
          _tempoController.text = "";

          showMySnackBar(
              context: context,
              isError: false,
              text: (widget.receitaModel != null)
                  ? "Receita editada com sucesso!"
                  : "Receita adicionada com sucesso!");
        });
      });
    }
  }

  @override
  void initState() {
    if (widget.receitaModel != null) {
      _receitaController.text = widget.receitaModel!.receita;
      _cineController.text = widget.receitaModel!.cine;
      _descricaoController.text = widget.receitaModel!.descricao;
      _modo_preparoController.text = widget.receitaModel!.modo_preparo;
      _ingredientesController.text = widget.receitaModel!.ingredientes;
      _link_imagemController.text = widget.receitaModel!.link_imagem;
      _tipoController.text = widget.receitaModel!.tipo;
      _porcaoController.text = widget.receitaModel!.porcao;
      _tempoController.text = widget.receitaModel!.tempo;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 26, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Envie sua receita:",
                style: getTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Material(
                      elevation: 2,
                      shadowColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        controller: _receitaController,
                        decoration:
                            getReceitasInputDecoration("Título da receita:"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "O Campo não deve estar vazio!";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Material(
                      elevation: 2,
                      shadowColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        controller: _descricaoController,
                        decoration:
                            getReceitasInputDecoration("Descrição da receita:"),
                        minLines: 3,
                        maxLines: null,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "O Campo não deve estar vazio!";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Material(
                      elevation: 2,
                      shadowColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        controller: _ingredientesController,
                        decoration: getReceitasInputDecoration("Ingredientes:"),
                        minLines: 4,
                        maxLines: null,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "O Campo não deve estar vazio!";
                          }
                          return null;
                        },
                      ),
                    ),
                    Text(
                      "Informe os ingredientes separando-os por vírgulas (,)",
                      textAlign: TextAlign.left,
                      style: getTextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Material(
                            elevation: 2,
                            shadowColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: TextFormField(
                              controller: _porcaoController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "O Campo não deve estar vazio!";
                                }
                                return null;
                              },
                              decoration: getReceitasInputDecoration(
                                  "Número de porções:"),
                            ),
                          ),
                        ),
                        SizedBox(width: 18),
                        Expanded(
                          child: Material(
                            elevation: 2,
                            shadowColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: TextFormField(
                              controller: _tempoController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "O Campo não deve estar vazio!";
                                }
                                return null;
                              },
                              decoration: getReceitasInputDecoration(
                                  "Tempo de preparo:"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Material(
                            elevation: 2,
                            shadowColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: TextFormField(
                              controller: _tipoController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "O Campo não deve estar vazio!";
                                }
                                return null;
                              },
                              decoration: getReceitasInputDecoration("Tipo:"),
                            ),
                          ),
                        ),
                        SizedBox(width: 18),
                        Expanded(
                          child: Material(
                            elevation: 2,
                            shadowColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: TextFormField(
                              controller: _cineController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "O Campo não deve estar vazio!";
                                }
                                return null;
                              },
                              decoration:
                                  getReceitasInputDecoration("Universo Geek:"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Material(
                      elevation: 2,
                      shadowColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        controller: _modo_preparoController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "O Campo não deve estar vazio!";
                          }
                          return null;
                        },
                        decoration:
                            getReceitasInputDecoration("Modo de Preparo:"),
                        minLines: 4,
                        maxLines: null,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Material(
                      elevation: 2,
                      shadowColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        controller: _link_imagemController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "O Campo não deve estar vazio!";
                          }
                          return null;
                        },
                        decoration: getReceitasInputDecoration("Url da foto:"),
                        minLines: 1,
                        maxLines: null,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.azulPrincipal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        minimumSize: Size(double.infinity, 48),
                      ),
                      onPressed: () {
                        enviarForm();
                      },
                      child: (isLoading)
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              (widget.receitaModel != null)
                                  ? "Editar receita"
                                  : "Publicar receita",
                              style: getTextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
