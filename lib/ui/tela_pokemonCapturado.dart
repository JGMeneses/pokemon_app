import 'package:flutter/material.dart';
import 'package:poke_app/database/database.dart';
import 'package:poke_app/entity/Poke.dart';
import 'package:poke_app/ui/tela_detalhesPokemon.dart';
import 'package:poke_app/ui/tela_soltarPokemon.dart';
import 'package:poke_app/widgets/pokeCard-widget.dart';

class TelaPokemonCapturado extends StatefulWidget {
  final AppDatabase database;

  TelaPokemonCapturado({required this.database});

  @override
  _ListaPokeScreenState createState() => _ListaPokeScreenState();
}

class _ListaPokeScreenState extends State<TelaPokemonCapturado> {
  late Future<List<Poke>> _pokeList;

  @override
  void initState() {
    super.initState();
    _refreshPokeList();
  }

  Future<void> _refreshPokeList() async {
    setState(() {
      _pokeList = widget.database.pokeDao.findAllPoke();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
        title: const Text('Pokémons Capturados'),
      ),
      body: FutureBuilder<List<Poke>>(
        future: _pokeList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar dados do banco de dados'),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return _buildPokeListView(snapshot.data!);
          } else {
            return const Center(
              child: Text('Nenhum Pokémon foi capturado'),
            );
          }
        },
      ),
    );
  }

  Widget _buildPokeListView(List<Poke> pokeList) {
    return ListView.builder(
      itemCount: pokeList.length,
      itemBuilder: (context, index) {
        final poke = pokeList[index];
        return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaDetalhePokemon(
                        pokemonId: poke.id, database: widget.database),
                  ));
            },
            onLongPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaSoltarPokemon(
                      pokemonId: poke.id,
                      database: widget.database,
                    ),
                  ));
            },
            child: ListTile(
              title: PokeCard(poke: poke),
            ));
      },
    );
  }
}
