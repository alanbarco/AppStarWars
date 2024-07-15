import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:starwars_app/ui/widgets/handler_card_personajes.dart';

import '../../../application/services/IConsultaSWAPI.dart';
import '../../../infraestructure/providers/page_provider.dart';
import '../../widgets/logo.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final apiService = Provider.of<IConsultaSWAPI>(context);
    final pageProvider = Provider.of<PageProvider>(context);
    return OrientationBuilder(builder: (context, orientation){
      return Scaffold(
        appBar: AppBar(
          title: orientation == Orientation.landscape
            ? Center(
              child: Transform.rotate(
                  angle: -90 * pi / 180,
                  child: Image.asset('assets/images/cubo.png', width: 50)),
            )
            : Center(child: Image.asset('assets/images/cubo.png', width: 50))    
        ),
        body: HandlerCardPersonaje(personajes: apiService.getConsultaSWAPI(), page: pageProvider.currentPage.toString())
      );
    }
    );
  }
}