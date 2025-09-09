import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_firebase/firebase_options.dart';
import 'package:todo_list_firebase/views/auth_widget.dart';

void main()async { //conectar com o firebase
//garantir o carregamento primeiro das bindings
  WidgetsFlutterBinding.ensureInitialized();
//inicializar o firebase
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform //garante a conexão somente com android
);
runApp(MaterialApp(
  title: "Lista de Tarefas firebase",
  home: AuthWidget(), //widget que decide qual tela mostrar
));

}

