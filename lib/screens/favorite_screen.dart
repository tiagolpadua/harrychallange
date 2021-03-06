import 'package:flutter/material.dart';
import 'package:harrychallange/database/character_dao.dart';
import 'package:harrychallange/models/character.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CharacterDAO _dao = CharacterDAO();

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Personagens Favoritos',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Image.asset(
          "assets/images/harry_bg.jpg",
          fit: BoxFit.fitWidth,
          width: double.infinity,
          height: 200,
        ),
        Expanded(
          child: FutureBuilder<List<Character>>(
            future: _dao.findAll(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;
                case ConnectionState.waiting:
                  return  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Text('Carregando')
                      ],
                    ),
                  );
                  break;
                case ConnectionState.active:
                  break;
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    final List<Character> items = snapshot.data!;
                    if (items.isNotEmpty) {
                      return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Character character = items[index];
                            return CharacterItem(character);
                          });
                    }
                  }
                  return Text('Erro ao carregar personagens');
              }

              return Text('Erro');
            },
          ),
        ),
      ]),
    );
  }
}
class CharacterItem extends StatelessWidget {
  final Character character;

  CharacterItem(this.character);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        child: ListTile(
          title: Text(character.name, style: TextStyle(fontSize: 20),),
        ),
      ),
    );
  }
}
