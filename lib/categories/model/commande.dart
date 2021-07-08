import 'package:pharmacie/categories/model/medModel.dart';

class CommandeModel {
  String fullName;
  String adresse;
  String phoneNumber;
  String numCommande;
  List<MedicamentModel> mediList;
  String statut;
  String uid;
  String qrcode;
  CommandeModel({this.numCommande, this.adresse, this.mediList, this.uid, this.statut});
}
