import '../../domain/models/personaje.dart';

abstract class IConsultaSWAPIRest {
  Future<List<PersonajeSW>> getConsultaSWAPI();
}