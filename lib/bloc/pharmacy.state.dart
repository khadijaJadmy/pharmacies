
import 'package:pharmacie/bloc/pharmacy.action.dart';
import 'package:pharmacie/enums/enums.dart';
import 'package:pharmacie/model/pharmacy.model.dart';

class PharmaciesState {
  RequestState requestState;
  List<Pharmacy> pharmacies;
  String messageError;
  // PharmaciesEvent currentMessageEvent;
  // List<Pharmacy> selectedMessages=[];
  // Pharmacy currentContact;

  PharmaciesState({this.messageError,this.pharmacies,this.requestState});

  PharmaciesState.initialState():
    requestState=RequestState.NONE,
    pharmacies=[],
    messageError='';
    // currentMessageEvent=null,
    // selectedMessages=[],
    // currentContact=new Pharmacy();


}