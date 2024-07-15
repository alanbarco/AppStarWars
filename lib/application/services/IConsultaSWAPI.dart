import '../../domain/models/personaje.dart';

abstract  class IConsultaSWAPI {
  Future<List<PersonajeSW>> getConsultaSWAPI();
}