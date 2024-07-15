import 'package:starwars_app/domain/models/pelicula.dart';

class PersonajeSW {
    String name;
    String hairColor;
    String eyeColor;
    String gender;
    String homeworld;
    List<String> films;

    PersonajeSW({
        required this.name,
        required this.hairColor,
        required this.eyeColor,
        required this.gender,
        required this.homeworld,
        required this.films,
    });

    factory PersonajeSW.fromJson(Map<String, dynamic> json, List<PeliculaSW> peliculas) => PersonajeSW(
        name: json["name"],
        hairColor: json["hair_color"],
        eyeColor: json["eye_color"],
        gender: _traducirGenero(json["gender"]),
        homeworld: json["homeworld"],
        films: List<String>.from(json["films"].map((x) => x = peliculas.firstWhere((pelicula) => pelicula.url == x).title)),
    );

    static String _traducirGenero(String genero){
      switch(genero){
        case 'male':
          return 'Masculino';
        case 'female':
          return 'Femenino';
        default:
          return 'Sin datos';
      }    
    }
}
