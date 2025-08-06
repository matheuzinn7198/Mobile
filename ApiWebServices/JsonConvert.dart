//Teste de Conversão de Json <-> Dart
import 'dart:convert'; //nativa -> não precisa baixar para o pubspec

void main(){
  String UsuarioJson = '''{
                      "id": "1ab2",
                      "user": "usuario1",
                      "nome": "Matheus",
                      "idade": 25,
                      "cadastrado": true
                      }''';
  //para manipular o texto
  //converter (decode) Json em Map                      
  Map<String, dynamic> usuario = json.decode(UsuarioJson);
  //manipular informações do Json -> Map
  print(usuario['idade']);
  usuario['idade'] = 26;
  //converter (encode) de Map -> Json
  UsuarioJson = json.encode(usuario);
  //tenho novamente um Json em formato de texto
  print(UsuarioJson);

}

