import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sauvie_enrole/model/PersonnePrevenir.dart';

import 'model/Enrole.dart';

class EnroleScreen extends StatefulWidget {
  const EnroleScreen({Key? key, required this.uniq}) : super(key: key);

  final String uniq;

  @override
  State<EnroleScreen> createState() => _EnroleScreenState();
}

class _EnroleScreenState extends State<EnroleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: FutureBuilder<Enrole?>(
              future: _getEnrole(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Text("Une erreur s'est produite ");
                } else if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    Enrole? enrole = snapshot.data;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: Text("INFORMATION", textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),)),
                        _space,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              height: 150,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  "https://sauvie.aino-digital.com${enrole!.avatar}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        _space,
                        _space,
                        Text("Nom : ${enrole.nom}"),
                        _space,
                        Text("Prénom : ${enrole.prenom}"),
                        _space,
                        Text("Employeur : "),
                        _space,
                        Text("Poste : "),
                        _space,
                        Text("Date de début : "),
                        _space,
                        Text("Infos sanitaire : ", style: Theme.of(context).textTheme.titleMedium),
                        Container(
                          padding: const EdgeInsets.all(15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage("assets/images/infos_sanitaire_bg.jpeg"),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Groupe sanguin : "),
                              Text("Electrophorèse : "),
                              Text("Maladie particulière : "),
                            ],
                          ),
                        ),
                        _space,
                        Text("Personnes contacts : ", style: Theme.of(context).textTheme.titleMedium,),
                        _space,
                         ListView.builder(
                          shrinkWrap: true,
                          itemCount: enrole.personne_prevenir?.length,
                          itemBuilder: (BuildContext context, int index) {
                            PersonnePrevenirModel person =
                            enrole.personne_prevenir![index];
                            return Container(
                              padding: const EdgeInsets.all(15),
                              margin: EdgeInsets.only(bottom: 5),
                              color: const Color(0XFFEFE1DD),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("${person.nom}"),
                                  Text("${person.numeros}"),
                                  Text("${person.domicile}"),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Text("Aucun enrole trouvé !"),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }

  Future<Enrole?> _getEnrole() async {
    var url = Uri.https(
        'sauvie.aino-digital.com', '/api/sauvie/sanitaire/get_enrole');
    /*var response = await http.post(
      url,
      headers: {
        'authorization': 'Bearer KhrR2Dm97Qvh0varBrrtusFH9qegIp',
      },
      body: <String, String>{
        'uniq': 'gdL5zcsKUf',
      },
    );*/
    var response = await http.post(
      url,
      headers: {
        'authorization': 'Bearer KhrR2Dm97Qvh0varBrrtusFH9qegIp',
      },
      body: <String, String>{
        'uniq': widget.uniq,
      },
    );
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);

      var enrole = Enrole.fromJson(responseJson);
      return enrole;
    } else {
      if (kDebugMode) {
        print('Request failed with status: ${response.statusCode}.');
      }
      return null;
    }
  }

  final Widget _space = const SizedBox(
      height: 10,
    );
}
