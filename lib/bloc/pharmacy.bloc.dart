import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pharmacie/bloc/pharmacy.action.dart';
import 'package:pharmacie/bloc/pharmacy.state.dart';
import 'package:pharmacie/enums/enums.dart';
import 'package:pharmacie/model/pharmacy.model.dart';
import 'package:pharmacie/repositories/pharmacies.repo.dart';

class PharmaciesBloc extends Bloc<PharmaciesEvent, PharmaciesState> {
  PharmaciesRepository messagesRepository;

  PharmaciesBloc(
      {@required PharmaciesState initialState,
      @required this.messagesRepository})
      : super(initialState);

  @override
  Stream<PharmaciesState> mapEventToState(PharmaciesEvent event) async* {
    if (event is LoadAllPharmaciesEvents) {
      yield PharmaciesState(
          requestState: RequestState.LOADING,
          pharmacies: state.pharmacies,
          pharmaciesbysearch: state.pharmaciesbysearch,
          requestState3: state.requestState3,
          search: state.search,
          pharmaciesbylocation: state.pharmaciesbylocation);
      try {
        List<Pharmacy> data = await messagesRepository.allPharmacys();
        print("DATAAA CALLING LOAD ALL PHARMACIES EVENT");
        // ignore: missing_return
        data.where((element) {
          print(element.name);
        });
        print("THESE ARE ALL THE ELEMENTS");
        print(data);
        print("OLLLD DATA FOR SEARCH");
        print(state.pharmaciesbysearch);
        print(state.pharmacies);
        print(state.search);
        print(state.requestState3);

        yield PharmaciesState(
            requestState: RequestState.LOADED,

            pharmacies: state.pharmaciesbysearch!=null?state.pharmaciesbysearch:data,
            pharmaciesbylocation: state.pharmaciesbylocation,
            pharmaciesbysearch: state.pharmaciesbysearch==null?null:state.pharmaciesbysearch,
            requestState2: state.requestState2);
      } catch (e) {
        yield PharmaciesState(
            requestState: RequestState.ERROR,
            messageError: e.toString(),
            pharmacies: state.pharmacies,
            requestState2: state.requestState2);
      }
    } else if (event is LoadPharmaciesBylocationEvents) {
      yield PharmaciesState(
          pharmaciesbylocation: state.pharmacies,
          pharmacies: state.pharmacies,
          requestState2: RequestState.LOADING);
      try {
        List<Pharmacy> olddata = state.pharmacies;
        List<Pharmacy> data = await messagesRepository.pharmacyByLocation();
        print("DATAAA");
        print("DATAAA CALLING LOAD  PHARMACIES BY LOCATION EVENT");
        print(data);
        print(data.length);
        print("DATA LENGHHHHT");
             for(int i=0;i<data.length;i++){
        print(data[i].name);
         print(data[i].description);
          print(data[i].image);
           print(data[i].location);
      }
        // data.add(new Pharmacy(id: 3,description:'test',name: 'test',location:'test',image: 'https://image.shutterstock.com/image-photo/chemist-medicines-arranged-shelves-pharmacy-260nw-1715610814.jpg'));

        yield PharmaciesState(
          requestState: state.requestState,
          pharmaciesbylocation: data,
          pharmacies: olddata,
          requestState2: RequestState.LOADED,
        );
      } catch (e) {
        yield PharmaciesState(
          requestState: RequestState.ERROR,
          messageError: e.toString(),
          pharmaciesbylocation: state.pharmacies,
        );
      }
    } else if (event is LoadPharmaciesBySearchName) {
      print("SSSSAAAERCHH");
      print(event.payload);
      yield PharmaciesState(
          // requestState: RequestState.LOADING,
          pharmacies: state.pharmacies,
          
          pharmaciesbylocation: state.pharmaciesbylocation,
          // requestState2: state.requestState2
          );
      try {
        List<Pharmacy> data =
            await messagesRepository.pharmacyByName(event.payload);
        print("DATAAA");
        print("DATAAA CALLING LOAD  PHARMACIES BY SEARCH NAME EVENT");
        print(data);
        print("DATA LENGHT SEARCH");
        print(data.length);
    
        //  data=[];
        // data.add(new Pharmacy(id: 3,description:'test',name: 'test',location:'test',image: 'https://image.shutterstock.com/image-photo/chemist-medicines-arranged-shelves-pharmacy-260nw-1715610814.jpg'));
        print("NEW DATA");
        print(data);
        yield PharmaciesState(
          // requestState: state.requestState,
          // requestState3: RequestState.LOADING,
          search: event.payload,
          pharmacies: state.pharmacies,
          pharmaciesbylocation: state.pharmaciesbylocation,
          pharmaciesbysearch: data
          // requestState2: state.requestState2,
        );
      } catch (e) {
        yield PharmaciesState(
          requestState: RequestState.ERROR,
          messageError: e.toString(),
          pharmacies: state.pharmacies,
        );
      }
    }
  }
}
