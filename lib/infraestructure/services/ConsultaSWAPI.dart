import 'package:starwars_app/domain/models/personaje.dart';
import '../../application/repositories/IConsultaSWRest.dart';
import '../../application/services/IConsultaSWAPI.dart';

class ConsultaSWAPI implements IConsultaSWAPI{
  late final IConsultaSWAPIRest _consultaSWAPIRest;
  ConsultaSWAPI(this._consultaSWAPIRest);
  @override
  Future<List<PersonajeSW>> getConsultaSWAPI() async {
    return await _consultaSWAPIRest.getConsultaSWAPI();
  }

}