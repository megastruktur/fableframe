import 'package:fableframe/services/models.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {

  final Character character;
  const CharacterItem({super.key, required this.character});


  @override
  Widget build(BuildContext context) {

    return Hero(
      tag: character.id,
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
          child: Container(
            decoration: BoxDecoration(
              image: character.avatar == ""
                ? const DecorationImage(
                    image: AssetImage('assets/covers/avatar_placeholder.png'),
                    fit: BoxFit.cover,
                  )
                : DecorationImage(
                    image: NetworkImage(character.avatarUrl.toString()),
                    fit: BoxFit.cover,
                  ),
            ),

            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  character.name,
                  style: const TextStyle(
                    fontSize: 20,
                    height: 5.0,
                  ),
                  overflow: TextOverflow.fade,
                  softWrap: false,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CharacterScreen extends StatelessWidget {

  final Character character;

  const CharacterScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Edit',
        child: const Icon(Icons.edit),
      ),
      body: ListView(
        children: [
          Hero(
            tag: character.id,
            child: Container(
              height: 140,
              clipBehavior: Clip.antiAlias,
              
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 5,
                ),
                shape: BoxShape.circle,
                color: Colors.deepPurpleAccent,
                image: character.avatar == ""
                  ? const DecorationImage(
                      image: AssetImage('assets/covers/avatar_placeholder.png'),
                      fit: BoxFit.contain,
                    )
                  : DecorationImage(
                      image: NetworkImage(character.avatarUrl.toString()),
                      fit: BoxFit.contain,
                    ),
              ),
            )
          ),
          // Center the text in the middle
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              character.name,
              style: const TextStyle(
                fontSize: 20,
                height: 5.0,
              ),
              overflow: TextOverflow.fade,
              softWrap: false,
              textAlign: TextAlign.center,
            ),
          ),
          ...character.getFieldsWidgets()
        ]
      ),
    );
  }
}
