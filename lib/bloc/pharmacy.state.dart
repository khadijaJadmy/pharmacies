
import 'package:pharmacie/bloc/pharmacy.action.dart';
import 'package:pharmacie/enums/enums.dart';
import 'package:pharmacie/model/pharmacy.model.dart';

class PharmaciesState {
  RequestState requestState;
  List<Pharmacy> pharmacies;
  List<Pharmacy> pharmaciesbylocation;
  List<Pharmacy> pharmaciesbysearch;
  RequestState requestState2;
   RequestState requestState3;
   String search;
  //  List<Pharmacy> pharmaciesbylocation;
  String messageError;
  // PharmaciesEvent currentMessageEvent;
  // List<Pharmacy> selectedMessages=[];
  // Pharmacy currentContact;

  PharmaciesState({this.messageError,this.pharmacies,this.requestState,this.search,this.requestState3,this.pharmaciesbylocation,this.requestState2,this.pharmaciesbysearch});

  PharmaciesState.initialState():
    requestState=RequestState.NONE,
    pharmacies=[],
    messageError='',
    search='',
    pharmaciesbylocation=[],
    pharmaciesbysearch=[],
    requestState2=RequestState.NONE,
    requestState3=RequestState.NONE;
    // currentMessageEvent=null,
    // selectedMessages=[],
    // currentContact=new Pharmacy();


}