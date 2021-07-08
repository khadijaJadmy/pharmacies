import 'package:pharmacie/categories/model/medModel.dart';

class CommandeModel {
  String fullName;
  String adresse;
  String phoneNumber;
  String qrcode;
  String statut;
  String uid;
  String numCommande;
  List<MedicamentModel> mediList;
  CommandeModel({this.statut,this.uid,this.numCommande,this.adresse, this.qrcode,this.mediList});
}
