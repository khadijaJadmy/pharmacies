
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pharmacie/auth/authentification.dart';
import 'package:pharmacie/bloc/pharmacy.bloc.dart';
import 'package:pharmacie/repositories/pharmacies.repo.dart';
import 'package:pharmacie/ui/anotherhome/screens/home/components/body.dart';
import 'package:pharmacie/ui/anotherhome/screens/home/home_screen.dart' as Ho;
// import 'package:pharmacie/ui/auth/authentification.dart';
import 'package:pharmacie/ui/home/home.dart';
import 'package:pharmacie/ui/pages/pharmacy/pharmacy.page.dart';
import 'package:pharmacie/ui/welcome.dart';
import 'bloc/pharmacy.state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'enums/enums.dart';
import 'livreur/detailCommande.dart';
import 'livreur/listCommande.dart';

// void main() {
//   GetIt.instance.registerLazySingleton(() => new PharmaciesRepository());

//   runApp(MyApp());
// }
Future<void> main()  async {
   

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   GetIt.instance.registerLazySingleton(() => new PharmaciesRepository());
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>PharmaciesBloc(
          initialState: PharmaciesState.initialState(),
          messagesRepository: GetIt.instance<PharmaciesRepository>()
        )
        ),
   
      
    ],
    
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.grey),
      routes: {

        '/pharmacies' :(context)=>
        //Body()
        // Livreurstate()
        SplashScreen(),


      },
      initialRoute: '/pharmacies',
    ));
  }
}
