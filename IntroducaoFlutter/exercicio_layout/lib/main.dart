import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.black
                ),
                Positioned(
                  top: 30,
                  child: CircleAvatar(
                    radius: 75,
                    backgroundImage: NetworkImage("https://imgs.search.brave.com/oxeU6ub3i6nP4RD-QMcA0zp3O8AMe6Q6sr7Jg_81z0s/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zdGF0/aWMxLnB1cmVwZW9w/bGUuY29tLmJyL2Fy/dGljbGVzLzIvMzkv/OTIvNDIvQC80NTQ2/MDcwLWNyaXN0aWFu/by1yb25hbGRvLWph/LXBpbnRhLWFzLXVu/aGFzLWRvLXQtNTgw/eDU4MC0yLmpwZw"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              'Cristiano Ronaldo',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Text(
              'Goat 🐐',
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.message),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cristiano Ronaldo dos Santos Aveiro (El Bicho)',
                style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                Text('5 de fevereiro de 1985 (40 anos)',
                style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                Text('Funchal, Madeira, Portugal',
                style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                Text('Atleta profissional',
                style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                Text('SIUUUUUUU',
                style: TextStyle(fontSize: 25, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Pesquisar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}