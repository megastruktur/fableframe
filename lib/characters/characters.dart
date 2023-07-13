import 'package:fableframe/characters/character_item.dart';
import 'package:fableframe/services/models.dart';
import 'package:fableframe/services/database.dart';
import 'package:fableframe/shared/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder<List<Character>>(
      future: Provider.of<PocketbaseProvider>(context, listen: false).getCharacters(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {

        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        }
        else if (snapshot.hasData) {

          List<Character> characters = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              title: const Text('Characters'),
            ),
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: characters.map((character) => CharacterItem(character: character)).toList(),
            ),
            // Floating navigation button to create new character
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),

            bottomNavigationBar: const BottomNavBar(activePage: 2,),
          );
        }
        else {
          return const Center(child: CircularProgressIndicator());
        }
        return Container();
      }
    );
  }
}
