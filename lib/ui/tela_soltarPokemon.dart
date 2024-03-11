import 'package:flutter/material.dart';
import 'package:poke_app/database/database.dart';
import 'package:poke_app/entity/Poke.dart';
import 'package:poke_app/ui/tela_pokemonCapturado.dart';
import 'package:poke_app/widgets/pokeCard-widget.dart';

class TelaSoltarPokemon extends StatelessWidget {
  final int pokemonId;
  final AppDatabase database;

  TelaSoltarPokemon({required this.pokemonId, required this.database});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
        title: const Text('Soltar Pokémon'),
      ),
      body: StreamBuilder<Poke?>(
        stream: database.pokeDao.findPokeById(pokemonId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Text('Pokémon não encontrado');
          } else {
            Poke poke = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: PokeCard(poke: poke),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: Colors.black),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TelaPokemonCapturado(database: database),
                            ));
                      },
                      child: Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: Colors.black),
                        ),
                      ),
                      onPressed: () {
                        database.pokeDao.deletePokeById(pokemonId);
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TelaPokemonCapturado(database: database),
                            ));
                      },
                      child: Text(
                        'Soltar Pokémon',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
