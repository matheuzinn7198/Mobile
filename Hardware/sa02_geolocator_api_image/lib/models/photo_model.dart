//modelagem para classe photo

import 'dart:io';

class PhotoModel{
  //atributos
  final File photoPath; //endereço da imagem para manipulação
  final String location;
  final String timeStamp;

  //constructor
  PhotoModel({
    required this.photoPath, required this.location, required this.timeStamp
  });
}