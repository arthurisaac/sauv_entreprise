class PersonnePrevenirModel {
  String? id;
  String? civilite;
  String? nom;
  String? domicile;
  String? numeros;

  PersonnePrevenirModel({
    this.id,
    this.civilite,
    this.nom,
    this.domicile,
    this.numeros});

  PersonnePrevenirModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    civilite = json['civilite'] ?? "";
    nom = json['nom'] ?? "";
    domicile = json['domicile'] ?? "";
    numeros = json['numeros'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['civilite'] = civilite;
    data['nom'] = nom;
    data['domicile'] = domicile;
    data['numeros'] = numeros;
    return data;
  }

}