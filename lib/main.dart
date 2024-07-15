import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:starwars_app/application/repositories/IConsultaSWRest.dart';
import 'package:starwars_app/application/services/IConsultaSWAPI.dart';
import 'package:starwars_app/infraestructure/providers/filter_provider.dart';
import 'package:starwars_app/infraestructure/providers/page_provider.dart';
import 'package:starwars_app/ui/screens/home/home_screen.dart';
import 'infraestructure/repositories/ConsultaSWAPIRest.dart';
import 'infraestructure/services/ConsultaSWAPI.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => PageProvider()),
      ChangeNotifierProvider(create: (context) => FilterProvider()),
      ProxyProvider<PageProvider, IConsultaSWAPIRest>(
        update: (context, pageProvider, previous) => ConsultaSWAPIRest(pageProvider),
      ),
      ProxyProvider<IConsultaSWAPIRest, IConsultaSWAPI>(
        update: (context, consultaSWAPIRest, previous) => ConsultaSWAPI(consultaSWAPIRest),
      ),
    ],
    child: MainApp())
    );
    
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        accentColor: Colors.yellow
      ),
      home: HomeScreen(),
    );
  }
}
