import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starwars_app/domain/models/personaje.dart';

class CardPersonaje extends StatelessWidget { 
  final PersonajeSW personaje;
  const CardPersonaje({required this.personaje});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(personaje.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          Text('Género:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(personaje.gender),
          Text('Color de ojos:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(personaje.eyeColor),
          Text('Peliculas', style: TextStyle(fontWeight: FontWeight.bold)),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: personaje.films.map((film) => Text('-$film')).toList(),
            ),
          ]),           
    ));
  }
}