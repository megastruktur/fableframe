import 'package:fableframe/characters/characters.dart';
import 'package:fableframe/services/models.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {

  final Character character;
  const CharacterItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {

    return Hero(
      tag: character,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => CharacterScreen(character: character),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                child: SizedBox(
                  child: character.avatar != ""
                    ? Image.network(character.avatarUrl.toString(), fit: BoxFit.contain)
                    : Image.asset('assets/covers/avatar_placeholder.png',
                      fit: BoxFit.contain)
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    character.name,
                    style: const TextStyle(
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CharacterScreen extends StatelessWidget {

  final Character character;

  const CharacterScreen({super.key, required Character this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView(children: [
        Hero(
          tag: character,
          child: character.avatar != ""
            ? Image.network(character.avatarUrl.toString())
            : Image.asset('assets/covers/avatar_placeholder.png',
              width: MediaQuery.of(context).size.width)
            ),
        Text(
          character.name,
          style: const TextStyle(
              height: 2, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ]),
    );
  }
}
