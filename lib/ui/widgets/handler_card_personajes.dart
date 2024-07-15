import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starwars_app/domain/models/personaje.dart';
import 'package:starwars_app/ui/widgets/card_personaje.dart';

import '../../application/services/IConsultaSWAPI.dart';
import '../../infraestructure/providers/filter_provider.dart';
import '../../infraestructure/providers/page_provider.dart';
import 'filter_button.dart';

class HandlerCardPersonaje extends StatefulWidget{
  final Future<List<PersonajeSW>> personajes;
  final String page;
  HandlerCardPersonaje({required this.personajes, required this.page});

  @override
  State<HandlerCardPersonaje> createState() => _HandlerCardPersonajeState();
}

class _HandlerCardPersonajeState extends State<HandlerCardPersonaje> {
  final scrollController = ScrollController();  
  late Future<List<PersonajeSW>> personajesPromesa;
  List<PersonajeSW> personajesData = [];
  List<PersonajeSW> personajesFiltro = [];
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    personajesPromesa = widget.personajes;
    scrollController.addListener(() {
        _cargarMasPersonajes();
    });
  }
  void _cargarMasPersonajes() async {
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      final pageProvider = Provider.of<PageProvider>(context, listen: false);
      final apiService = Provider.of<IConsultaSWAPI>(context, listen: false);
      if (!isLoadingMore) {
        setState(() {
          isLoadingMore = true;
        });
      }
      pageProvider.incrementPage();
      try{
        final nuevosPersonajesData = await apiService.getConsultaSWAPI();
         setState(() {
          personajesData.addAll(nuevosPersonajesData);        
          _filtrarPersonajes(Provider.of<FilterProvider>(context, listen: false).value);
          isLoadingMore = false;
        });
      }catch(e){
        setState(() {
          isLoadingMore = false;
        });
      }
     
    }
  }

  void _filtrarPersonajes(String filterValue){
    if(filterValue != 'Todos'){
        personajesFiltro = personajesData.where((element) => element.gender == filterValue).toList();
    }else{
        personajesFiltro = personajesData;
    }
  }
 
  @override
  Widget build(BuildContext context) {    
    final filterProvider = Provider.of<FilterProvider>(context);
    return Column(
      children: [
        FilterButton(),
        Expanded(
          child: FutureBuilder<List<PersonajeSW>>(
            future: personajesPromesa,
            builder: (context, snapshot){ 
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }else{
                if(personajesData.isEmpty){
                  personajesData.addAll(snapshot.data as List<PersonajeSW>);
                }
                _filtrarPersonajes(filterProvider.value);
                return ListView.builder(
                controller: scrollController,
                itemCount: personajesFiltro.length + (isLoadingMore ? 1 : 0),
                itemBuilder: (context, index){
                  if(index < personajesFiltro.length){
                    return CardPersonaje(personaje: personajesFiltro[index]);
                  }else{
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                  }                       
                },);
              }
            },),
        ),
      ],
    );
  }
}