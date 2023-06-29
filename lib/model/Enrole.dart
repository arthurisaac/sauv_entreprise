import 'package:sauvie_enrole/model/PersonnePrevenir.dart';

class Enrole {
  String id = "0";
  String nom = "";
  String prenom = "";
  String telephone = "";
  String avatar = "";
  List<PersonnePrevenirModel>? personne_prevenir = [];

  Enrole({required this.id, required this.nom});

  Enrole.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    avatar = json['avatar'];
    prenom = json['prenom'];
    telephone = json['telephone'];

    List<PersonnePrevenirModel> prevenirModel = [];
    json['personne_a_prevenir']?.forEach((e) => prevenirModel.add(PersonnePrevenirModel.fromJson(e)));
    personne_prevenir = prevenirModel;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nom'] = nom;
    data['avatar'] = avatar;
    data['prenom'] = prenom;
    data['telephone'] = telephone;

    return data;
  }
}