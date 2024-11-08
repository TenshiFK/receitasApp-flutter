class ReceitaModel {
  String id;
  String receita;
  String cine;
  String descricao;
  String ingredientes;
  String modo_preparo;
  String porcao;
  String tempo;
  String link_imagem;
  String tipo;
  bool? favorite;

  ReceitaModel({
    required this.id,
    required this.receita,
    required this.cine,
    required this.descricao,
    required this.ingredientes,
    // ignore: non_constant_identifier_names
    required this.modo_preparo,
    required this.porcao,
    required this.tempo,
    // ignore: non_constant_identifier_names
    required this.link_imagem,
    required this.tipo,
    this.favorite,
  });

  ReceitaModel.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        receita = map["receita"],
        cine = map["cine"],
        descricao = map["descricao"],
        ingredientes = map["ingredientes"],
        modo_preparo = map["modo_preparo"],
        porcao = map["porcao"],
        tempo = map["tempo"],
        link_imagem = map["link_imagem"],
        tipo = map["tipo"],
        favorite = map["favorite"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "receita": receita,
      "cine": cine,
      "descricao": descricao,
      "ingredientes": ingredientes,
      "modo_preparo": modo_preparo,
      "porcao": porcao,
      "tempo": tempo,
      "link_imagem": link_imagem,
      "tipo": tipo,
      "favorite": favorite
    };
  }
}
