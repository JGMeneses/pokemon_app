import 'package:flutter/material.dart';
import 'package:poke_app/database/database.dart';
import 'package:poke_app/ui/tela_captura.dart';
import 'package:poke_app/ui/tela_pokemonCapturado.dart';
import 'package:poke_app/ui/tela_sobre.dart';

class TelaHome extends StatelessWidget {
  const TelaHome({super.key, required this.db});
  final AppDatabase db;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        title: Center(
          child: Padding(
              padding: const EdgeInsets.only(
                  right: 25.0), // Adicione o espaço desejado à esquerda
              child: Image.asset(
                'assets/poke.png',
                width: 120, // Ajuste o tamanho conforme necessário
                height: 50,
              )),
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/icon/app_icon2.png',
              width: 30,
              height: 30,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaSobre(db: db),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 0, 0),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/poke.png',
                        width: 170,
                        height: 100,
                      ),
                      const SizedBox(height: 10),
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Menu Treinador',
                          style: TextStyle(
                            color: Color.fromARGB(205, 254, 250, 27),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            ListTile(
              leading: Image.asset(
                "assets/icon/pokebola-icon.png",
                width: 30,
                height: 30,
              ),
              title: const Text('Capturar Pokémon'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaCaptura(db: db),
                  ),
                );
              },
            ),
            ListTile(
              leading: Image.asset(
                "assets/icon/podebola-estrela-icon.png",
                width: 30,
                height: 30,
              ),
              title: const Text(
                'Meus Pokémons',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaPokemonCapturado(
                      database: db,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: const HomeBody(),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bem-vindo à Pokedex!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Explore o fascinante mundo dos Pokémons! Este aplicativo utiliza uma API de Pokémon para fornecer informações detalhadas sobre diferentes espécies de Pokémon. Você pode capturar novos Pokémon, visualizar sua coleção e descobrir fatos interessantes sobre cada um deles.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/TelaPrincipal.png',
              width: 200,
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
