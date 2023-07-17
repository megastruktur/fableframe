import 'package:fableframe/services/database.dart';
import 'package:fableframe/services/models.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

var logger = Logger();

class CharacterItem extends StatelessWidget {

  final Character character;
  const CharacterItem({super.key, required this.character});


  @override
  Widget build(BuildContext context) {

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Ink(
        decoration: BoxDecoration(
          image: character.avatar == ""
            ? const DecorationImage(
                image: AssetImage('assets/covers/avatar_placeholder.png'),
                fit: BoxFit.cover,
              )
            : DecorationImage(
                image: NetworkImage(
                  character.avatarUrl.toString(),
                ),
                fit: BoxFit.cover,
              ),
        ),
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
    );
  }
}

class CharacterScreen extends StatelessWidget {

  final Character character;

  const CharacterScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {

    // Example of Stream.
    // Provider.of<PocketbaseProvider>(context, listen: true).getCharacterStream(character.id);

    // Provider.of<PocketbaseProvider>(context, listen: true).getCharacterSheet('99k4mfbhqfme3oy');

    return FutureBuilder<CharacterSheet>(
      future: Provider.of<PocketbaseProvider>(context, listen: true).getCharacterSheet('99k4mfbhqfme3oy'),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {

        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        }
        else if (snapshot.hasData) {

          CharacterSheet characterSheet = snapshot.data!;

          var (tabIcons, tabs) = characterSheet.getCharacterTabsAndTabBar(character);

          return DefaultTabController(
            length: tabs.length,
            child: Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    ClipOval(
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                        placeholder: 'assets/covers/avatar_placeholder.png',
                        image: character.avatarUrl.toString(),
                      ),
                    ),
                    Text(character.name)
                  ],
                ),
                bottom: TabBar(
                  tabs: tabIcons,
                ),
              ),
              body: TabBarView(
                children: tabs,
              ),
            ),
          );
          
        }

        return Container();
      }
    );
  }
}
