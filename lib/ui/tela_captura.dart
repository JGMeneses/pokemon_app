import 'dart:math';
import 'package:flutter/material.dart';
import 'package:poke_app/database/database.dart';
import 'package:poke_app/widgets/pokemonCard-widget.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:pokeapi/pokeapi.dart';
import 'package:poke_app/service/connectivityService.dart';

class TelaCaptura extends StatefulWidget {
  const TelaCaptura({super.key, required this.db});
  final AppDatabase db;
  @override
  _TelaCapturaState createState() => _TelaCapturaState();

}

class _TelaCapturaState extends State<TelaCaptura> {
  final ConnectivityService _connectivityService = ConnectivityService();
  List<int> numerosSorteados = [];
  List<Pokemon> pokemons = [];
  late bool isLoading; // Adicione esta linha

  @override
  void initState() {
    super.initState();
    isLoading = true;
    sortearNumeros();
    buscarPokemons();
  }
  
  void sortearNumeros() {
    while (numerosSorteados.length < 6) {
      int numeroSorteado = Random().nextInt(1017) + 1;

      if (!numerosSorteados.contains(numeroSorteado)) {
        numerosSorteados.add(numeroSorteado);
      }
    }

    print('Números sorteados: $numerosSorteados');
  }

  Future<void> buscarPokemons() async {
    try {
      for (int numeroSorteado in numerosSorteados) {
        Pokemon? pokemon = await PokeAPI.getObject<Pokemon>(numeroSorteado);
        pokemons.add(pokemon!);
        
      }
    } catch (e) {
      print('Erro ao buscar Pokémon: $e');
    } finally {
      isLoading = false;
        setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
        title: const Text('Vamos pegar todos eles!'),
      ),
      body: FutureBuilder<bool>(
        future: _connectivityService.checkConnection(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao verificar a conexão'),
            );
          } else {
            final hasConnection = snapshot.data ?? false;

            if (hasConnection) {
              return ListView(
                children: [
                  if (isLoading)
                    const Center(child: CircularProgressIndicator()),
                  if (!isLoading && pokemons.isNotEmpty)
                    for (Pokemon pokemon in pokemons)
                      PokemonCard(pokemon: pokemon, db:widget.db),
                ],
              );
            } else {
              return const Center(
                child: Text('Sem conexão de rede'),
              );
            }
          }
        },
      ),
    );
  }
}
