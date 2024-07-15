import 'dart:convert';
import 'package:starwars_app/application/repositories/IConsultaSWRest.dart';
import 'package:starwars_app/application/services/IConsultaSWAPI.dart';
import 'package:starwars_app/domain/models/personaje.dart';
import 'package:http/http.dart' as http;
import 'package:starwars_app/infraestructure/providers/page_provider.dart';
import '../../config/env.dart';
import '../../domain/models/pelicula.dart';

String url = Env.apiUrl; 
class ConsultaSWAPIRest implements IConsultaSWAPIRest{
  final PageProvider _pageProvider;
  late Future<List<PeliculaSW>> _peliculas;

  ConsultaSWAPIRest(this._pageProvider){
    _peliculas = _getPeliculas();
  }


  @override
  Future<List<PersonajeSW>> getConsultaSWAPI() async {
    List<PeliculaSW> peliculas = await _peliculas;
    String page = _pageProvider.currentPage.toString();
    Uri uri = Uri.parse('$url/people/?page=$page');
    final response = await http.get(uri);
    if(response.statusCode == 200){
      final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> personajesResponse = data['results'];
       return personajesResponse.map((json) => PersonajeSW.fromJson(json, peliculas)).toList();
    }
    else{
      throw Exception("No se pudo consultar SWAPI");
    }
  }

 Future<List<PeliculaSW>> _getPeliculas() async{
    Uri uri = Uri.parse(url + '/films');
    final response = await http.get(uri);
    if(response.statusCode == 200){
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> peliculasResponse = data['results'];
      return peliculasResponse.map((json) => PeliculaSW.fromJson(json)).toList();
    }
    else{
      throw Exception("No se pudo consultar SWAPI");
    }
 }

}