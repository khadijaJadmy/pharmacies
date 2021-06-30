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
      {@required PharmaciesState initialState, @required this.messagesRepository})
      : super(initialState);

  @override
  Stream<PharmaciesState> mapEventToState(PharmaciesEvent event) async* {
    if (event is LoadAllPharmaciesEvents) {
      yield PharmaciesState(
          requestState: RequestState.LOADING, pharmacies: state.pharmacies );
      try {
        List<Pharmacy> data = await messagesRepository.allPharmacys();
        print("DATAAA");
        print(data);
        
        yield PharmaciesState(
            requestState: RequestState.LOADED,
            pharmacies: data,
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
