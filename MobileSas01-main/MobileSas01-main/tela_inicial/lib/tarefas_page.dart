import 'package:flutter/material.dart';

// Esta é a tela principal do app, onde o usuário irá visualizar, adicionar e gerenciar tarefas.
class TarefasPage extends StatefulWidget {
  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

// Classe com estado da página de tarefas.
// StatefulWidget é usado pois o conteúdo muda dinamicamente (tarefas são adicionadas/removidas).
class _TarefasPageState extends State<TarefasPage> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController(); // Controla o texto inserido no TextField
  List<String> pendentes = [];     // Lista de tarefas ainda não concluídas
  List<String> concluidas = [];    // Lista de tarefas já marcadas como concluídas

  late TabController _tabController; // Controla as abas (pendentes e concluídas)

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Criação do controller com duas abas
  }

  // Função para adicionar nova tarefa. Só adiciona se houver texto no campo.
  void adicionar() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        pendentes.add(_controller.text); // Adiciona à lista de pendentes
        _controller.clear(); // Limpa o campo de texto
      });
    }
  }

  // Remove tarefa da lista correspondente (pendente ou concluída)
  void remover(int index, bool isPendente) {
    setState(() {
      if (isPendente) pendentes.removeAt(index);
      else concluidas.removeAt(index);
    });
  }

  // Marca tarefa como concluída (move da lista de pendentes para concluídas)
  void concluir(int index) {
    setState(() {
      concluidas.add(pendentes[index]);
      pendentes.removeAt(index);
    });
  }

  // Desfaz conclusão (move da lista de concluídas para pendentes)
  void desfazer(int index) {
    setState(() {
      pendentes.add(concluidas[index]);
      concluidas.removeAt(index);
    });
  }

  // Ao clicar no botão de configurações, navega para a página de resumo.
  // Exemplo de navegação com passagem de dados entre páginas.
  void abrirResumo() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResumoPage( // <-- Classe ainda não mostrada aqui, mas deve exibir infográfico com resumo
          pendentes: pendentes,
          concluidas: concluidas,
        ),
      ),
    );
  }

  // Método de construção visual da interface
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Define número de abas (necessário para TabBarView funcionar corretamente)
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tarefas'),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {}, // Botão de notificações (sem funcionalidade no momento)
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: abrirResumo, // Abre página de resumo ao clicar
            )
          ],
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Pendentes'), // Primeira aba
              Tab(text: 'Concluídas'), // Segunda aba
            ],
          ),
        ),

        // Drawer (menu lateral) com 3 itens
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
              ListTile(title: Text('Dashboard'), leading: Icon(Icons.dashboard)),
              ListTile(title: Text('Configurações'), leading: Icon(Icons.settings)),
              ListTile(title: Text('Ajuda'), leading: Icon(Icons.help)),
            ],
          ),
        ),

        body: Column(
          children: [
            // Campo de texto para digitar nova tarefa
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Nova tarefa',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: adicionar, // Chama função que adiciona tarefa
                  ),
                ),
              ),
            ),

            // Área que muda de acordo com a aba selecionada
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  buildLista(pendentes, true),  // Exibe lista de pendentes
                  buildLista(concluidas, false), // Exibe lista de concluídas
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função que constrói a lista de tarefas com botões apropriados para cada tipo
  Widget buildLista(List<String> tarefas, bool isPendente) {
    return ListView.builder(
      itemCount: tarefas.length,
      itemBuilder: (_, i) => ListTile(
        title: Text(tarefas[i]),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Botões que mudam de acordo com o tipo de tarefa
            if (isPendente)
              IconButton(onPressed: () => concluir(i), icon: Icon(Icons.check, color: Colors.green)),
            if (!isPendente)
              IconButton(onPressed: () => desfazer(i), icon: Icon(Icons.undo, color: Colors.orange)),
            IconButton(onPressed: () => remover(i, isPendente), icon: Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}

// Página com explicações sobre o funcionamento do app
class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Este app permite:\n- Adicionar tarefas\n- Marcar como feitas\n- Remover\n\nFeito com Flutter!',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}

//-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/


// Tela de resumo das tarefas. Mostra um infográfico e uma lista detalhada.
// Recebe duas listas: pendentes e concluídas.
class ResumoPage extends StatelessWidget {
  final List<String> pendentes;
  final List<String> concluidas;

  // Construtor que exige listas obrigatórias
  ResumoPage({required this.pendentes, required this.concluidas});

  @override
  Widget build(BuildContext context) {
    // Obtém a data atual para simular um "prazo mais próximo"
    DateTime hoje = DateTime.now();

    // Neste exemplo, considera que o prazo mais próximo é o dia seguinte.
    // Se não houver tarefas pendentes, exibe um traço.
    String prazoMaisProximo = pendentes.isNotEmpty
        ? hoje.add(Duration(days: 1)).toString().split(' ')[0]
        : '-';

    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações - Gerenciar tarefas'), // Título da página
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Infográfico com informações resumidas em cards
            GridView.count(
              crossAxisCount: 2, // Define layout em 2 colunas
              shrinkWrap: true,  // Permite que o GridView fique dentro da Column
              physics: NeverScrollableScrollPhysics(), // Remove scroll interno
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                // Quatro cartões com informações importantes
                buildCard('Pendentes', pendentes.length.toString(), Colors.orange),
                buildCard('Concluídas', concluidas.length.toString(), Colors.green),
                buildCard('Prazo mais próximo', prazoMaisProximo, Colors.blue),
                buildCard('Total', (pendentes.length + concluidas.length).toString(), Colors.purple),
              ],
            ),

            SizedBox(height: 20),

            // Lista expandida com os detalhes de cada tarefa
            Expanded(
              child: ListView(
                children: [
                  Text('Detalhamento:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text('Pendentes:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ...pendentes.map((t) => Text('- $t')), // Lista as tarefas pendentes

                  SizedBox(height: 10),
                  Text('Concluídas:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ...concluidas.map((t) => Text('- $t')), // Lista as tarefas concluídas
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Função para criar os cartões do infográfico
  Widget buildCard(String title, String value, Color color) {
    return Card(
      elevation: 4,
      color: color.withOpacity(0.1), // Cor de fundo suave
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(value, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
