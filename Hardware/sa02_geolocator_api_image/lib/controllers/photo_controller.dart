//classe controller
//pegar a geolocalização
//busca api para transformar lat e lon em localização
//tirar a foto
//retornar o OBJ
import 'dart:convert';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:sa02_geolocator_api_image/models/photo_model.dart';

class PhotoController {
  //controlador para camera
  final _picker = ImagePicker();
  File? _file;
  String? location;

  //método que retorna um obj de photoModel
  Future<PhotoModel> getImageWithLocation() async{
    //verificar se a geolocalização esta habilitada
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnable){
      throw Exception("Serviço desabilitado");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        throw Exception("continua não permitida");
      }
    }
    //foi liberado pelo usuario
    Position position = await Geolocator.getCurrentPosition();//lat e lon
    //chamar a api e buscar o nome da localização
    final result = await http.get(
      Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?appid=CHAVE_API&lat=${position.latitude}&lon=${position.longitude}"
      )
    );
    //verificar se api encontrou alguma coisa
    if(result.statusCode ==200){
      //transformar em MAP<String, dynamic>
      Map<String,dynamic> data = jsonDecode(result.body);

      location = data["name"].toString();
    }

    //tirar a foto
    final XFile? photoTirada = await _picker.pickImage(source: ImageSource.camera);
    //verificar se a foto foi tirada
    if(photoTirada != null){
      _file = File(photoTirada.path);
      }else{
        throw Exception("Foto não tirada");
    }

  //criar o obj de PhotoModel e retornar
    final photo = PhotoModel(
      photoPath: _file!, 
      location: location!, 
      timeStamp: DateTime.now().toIso8601String()
      ); //data internacional (intl)
  
  return photo;
  }
}