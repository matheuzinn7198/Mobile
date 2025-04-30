import 'package:flutter/material.dart';
import 'tarefas_page.dart';// Corrigido: importa a página de tarefas

/// Função principal que inicia o app Flutter
void main() {
  runApp(MyApp()); // Inicializa o widget raiz
}

/// Widget raiz do aplicativo
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Simples', // Título do app (para debug e testes)
      home: TelaInicial(), // Página inicial: tela de login
      debugShowCheckedModeBanner: false, // Remove banner de debug
    );
  }
}

/// Tela de login e navegação inferior (BottomNavigationBar)
class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  // Controladores para ler os textos dos campos de email e senha
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  // Índice selecionado da barra inferior
  int _indiceSelecionado = 0;

  /// Função chamada ao clicar no botão "Logar". Leva diretamente à tela de tarefas.
  void _logar() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TarefasPage()), // Vai direto para a tela de tarefas
    );
  }

  /// Exibe uma mensagem temporária na tela (Snackbar)
  void _mostrarMensagem(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(texto)),
    );
  }

  /// Lógica de interação com o BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _indiceSelecionado = index;
    });

    // Mensagem temporária com base na aba selecionada
    switch (index) {
      case 0:
        _mostrarMensagem("Tela Inicial");
        break;
      case 1:
        _mostrarMensagem("Tarefas");
        break;
      case 2:
        _mostrarMensagem("Mais info.");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facilitate the service ;)'), // Título centralizado
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 60),
          Center(
            child: Container(
              width: 300,
              child: Card(
                elevation: 8, // Sombra do cartão
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Campo de email
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 16),

                      // Campo de senha
                      TextField(
                        controller: _senhaController,
                        decoration: InputDecoration(labelText: 'Senha'),
                        obscureText: true, // Oculta o texto digitado
                      ),
                      SizedBox(height: 24),

                      // Botão de login
                      ElevatedButton(
                        onPressed: _logar,
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                        child: Text('Logar'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      // Barra de navegação inferior com três abas
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceSelecionado, // Aba atual
        onTap: _onItemTapped, // Define ação ao tocar
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tarefas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Mais info.',
          ),
        ],
      ),
    );
  }
}
