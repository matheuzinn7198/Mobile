import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){ // método principal para rodar a aplicação
  runApp(MaterialApp( // base de todos os widget(Elementos visuais do Aplicativo)
    home: TelaPerfil(), //tela Inicial
    //routes:{

    //} , // rotas de navegação
    //theme: , //thema do aplicativo
    //darkTheme: , //tema alternativo 
    debugShowCheckedModeBanner: false, //remove o banner vermelho de debug
  ));
}

class TelaPerfil extends StatefulWidget{ //tela dinamica
  @override
  State<TelaPerfil> createState() => _TelaPerfilState(); //chama a mudança
}

class _TelaPerfilState extends State<TelaPerfil>{ //realiza a construção da tela
  //atributos
  TextEditingController _nomeController = TextEditingController(); // receber os dados do input
  TextEditingController _idadeController = TextEditingController();

  String? _nome; //permite as variaveis nulas
  String? _idade; //permite as variaveis nulas

  String? _corSelecionada;

  String? _cor;

  Map<String, Color> coresDisponiveis = {
    "Azul": Colors.blue,
    "Verde":Colors.green,
    "Vermelho":Colors.red,
    "Amarelo":Colors.yellow,
    "Cinza":Colors.grey,
    "Preto":Colors.black,
    "Branco":Colors.white
  };

  //cor de fundo
  Color _corFundo = Colors.white;

  //métodos
    @override
  void initState() { //método para carregar informações antes de buildar a tela
    // TODO: implement initState
    super.initState();
    _carregarPreferencias();
  }

  _carregarPreferencias() async { //método assincrono (sem ordem de execução)
  //conectar com SharedPreferences
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  setState(() { //mudança de estado do aplicativo
    _nome = _prefs.getString("nome");
    _idade = _prefs.getString("idade");
    _cor = _prefs.getString("cor");
    if(_cor != null){
      _corFundo = coresDisponiveis[_cor!]!; // !permite nulo
      _corSelecionada = _cor;
    }
  });
  }

  _salvarPreferencias() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _nome = _nomeController.text.trim();
    _idade = _idadeController.text.trim();
    _corFundo = coresDisponiveis[_cor!]!; 

    await _prefs.setString("nome", _nome ?? ""); //armazena o nome
    await _prefs.setString("idade", _idade ?? ""); //armazena a idade
    await _prefs.setString("cor", _cor ?? "Branco"); // armazena a cor, caso nulo armazena branco
    setState(() {
    
    });
  }
  //build
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: _corFundo,
      appBar: AppBar(title: Text("Meu Perfil Persistente"), backgroundColor: Colors.purple,),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: "Nome"),
            ),
            TextField(
              controller: _idadeController,
              decoration: InputDecoration(labelText: "Idade"),
              keyboardType: TextInputType.numberWithOptions(), //teclado para números
            ),
            SizedBox(height: 16,),
            DropdownButtonFormField(
              value: _cor,
              decoration: InputDecoration(labelText: "Cor Favorita"),
              items: coresDisponiveis.keys.map(
                (cor){
                  return DropdownMenuItem(
                    value: cor,
                    child: Text(cor));
                }
              ).toList(),
              onChanged: (valor){
                setState(() {
                  _cor = valor;
                });
              }),
              SizedBox(height: 16,),
              ElevatedButton(
                onPressed: _salvarPreferencias, 
                child: Text("Salvar Dados")),
                SizedBox(height: 16,),
                Divider(),
                SizedBox(height: 16,),
                Text("Dados Salvos:"),
                if(_nome != null) //usando if dentro dos elementos visuais
                  Text("Nome : $_nome"),
                  if(_idade != null)
                  Text("Idade: $_idade"),
                  if(_cor != null)
                  Text("Cor Favorita: $_cor")
          ],
        ),),
    );
  }
}