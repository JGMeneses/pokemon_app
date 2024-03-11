// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:poke_app/database/database.dart';
import 'package:poke_app/entity/Poke.dart';
import 'package:poke_app/widgets/pokeCard-widget.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:pokeapi/pokeapi.dart';

class TelaDetalhePokemon extends StatefulWidget {
  final int pokemonId;
  final AppDatabase database;

  TelaDetalhePokemon({required this.pokemonId, required this.database});

  @override
  _TelaDetalhePokemonState createState() => _TelaDetalhePokemonState();
}

class _TelaDetalhePokemonState extends State<TelaDetalhePokemon> {
  late Stream<Poke?> _pokeStream;
  late Future<Pokemon> _pokemonFuture;

  @override
  void initState() {
    super.initState();
    _pokeStream = widget.database.pokeDao.findPokeById(widget.pokemonId);
    _pokemonFuture = _loadPokemon();
  }

  Future<Pokemon> _loadPokemon() async {
    try {
      return await PokeAPI.getObject<Pokemon>(widget.pokemonId) as Pokemon;
    } catch (e) {
      // Trate erros, se necessário
      throw Exception("Erro ao carregar Pokémon: $e");
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Color.fromARGB(255, 255, 0, 0),
      title: const Text('Detalhes Pokémon'),
    ),
    body: FutureBuilder(
      future: _pokemonFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else {
          Pokemon pokemon = snapshot.data as Pokemon;

          return StreamBuilder<Poke?>(
            stream: _pokeStream,
            builder: (context, pokeSnapshot) {
              if (pokeSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (pokeSnapshot.hasError) {
                return Center(child: Text('Erro: ${pokeSnapshot.error}'));
              } else {
                Poke? poke = pokeSnapshot.data;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: PokeCard(poke: poke!),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 38),
                      child: Card(
                        elevation: 5,
                        color: Color.fromARGB(255, 102, 163, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.black, width: 0.5)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Detalhes',
                                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                                  ),
                                  // Adicione um ícone ou imagem aqui, se necessário
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Experiência: ${pokemon.baseExperience}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Altura: ${poke.height}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Peso: ${poke.weight}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'isDefault: ${pokemon.isDefault}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Espécie:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                ' ${pokemon.species?.name}'.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Habilidades:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                ' ${pokemon.abilities?.map((ability) => ability.ability?.name).join('\n ') ?? 'N/A'}'.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Estatíticas:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                ' ${pokemon.stats?.map((stat) => '${stat.stat?.name} ${stat.baseStat}').join('\n ') ?? 'N/A'}'.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          );
        }
      },
    ),
  );
}

}
