class PujaVM {
  int idEventos;
  int idSubasta;
  int idLote;
  String fechaCreacion;
  double valor;

  PujaVM({this.idEventos, this.idSubasta, this.idLote, this.valor});

  PujaVM.fromJson(Map<String, dynamic> json) {
    idEventos = json['idEventos'];
    idSubasta = json['idSubasta'];
    idLote = json['idLote'];
    valor = json['valor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idEventos'] = this.idEventos;
    data['idSubasta'] = this.idSubasta;
    data['idLote'] = this.idLote;
    data['valor'] = this.valor;
    return data;
  }
}