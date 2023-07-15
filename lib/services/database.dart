import "dart:async";

import "package:fableframe/services/models.dart";
import "package:fableframe/services/pref_keys.dart";
import "package:flutter/foundation.dart";
import "package:logger/logger.dart";
import "package:pocketbase/pocketbase.dart";
import "package:shared_preferences/shared_preferences.dart";

class PocketbaseProvider extends ChangeNotifier {

  var logger = Logger();

  final _pb = PocketBase(
    const String.fromEnvironment('POCKETBASE_HOST', defaultValue: 'http://localhost:8090'),
  );

  bool get isAuth {
    return _pb.authStore.isValid && _pb.authStore.token.isNotEmpty;
  }

  get user {
    if (isAuth) {
      return _pb.authStore.model;
    }
  }
  
  Timer? _healthCheckTimer;
  bool _healthy = true;
  bool _lastHealthy = true;
  String _userName = '';

  // Log in
  Future<void> login({String username = 'astro', String password = '12345678'}) async {
    try {
      ensureKeepAlive();
      final authData = await _pb.collection('users').authWithPassword(username, password);
      _healthy = true;
      _userName = authData.record?.data['name'].toString() ?? "";

      // Set the Token to Prefs to autologin.
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(PrefKeys.accessTokenPrefsKey, _pb.authStore.token);
      prefs.setString(PrefKeys.accessModelPrefsKey, _pb.authStore.model.id ?? '');
      prefs.setString(PrefKeys.accessNamePrefsKey, _userName);

      notifyListeners();
    }
    catch (e) {
      logger.e(e);
    }
  }

  // Log out
  Future<void> logout() async {
    try {
      _pb.authStore.clear();
    }
    catch(e) {
      logger.e(e);
    }
  }

    Future<void> doHealthCheck() async {
    _pb.health.check().then((value) {
      _healthy = true;
    }).onError((error, stackTrace) {
      _healthy = false;
    }).whenComplete(() {
      if (_healthy != _lastHealthy) {
        notifyListeners();
      }
      _lastHealthy = _healthy;
    });
  }

  Future<void> ensureKeepAlive() async {
    _healthCheckTimer?.cancel();
    _healthCheckTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      doHealthCheck();
    });
  }

  Future<bool> tryAutoLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _userName = prefs.getString(PrefKeys.accessNamePrefsKey) ?? '';
    _pb.authStore
        .save(prefs.getString(PrefKeys.accessTokenPrefsKey) ?? '', prefs.getString(PrefKeys.accessModelPrefsKey) ?? '');
    if (!_pb.authStore.isValid) {
      logger.e('Invalid Token');
      return false;
    }
    ensureKeepAlive();
    notifyListeners();
    return _pb.authStore.isValid;
  }

  // Get characters from pocketbase async
  Future<List<Character>> getCharacters() async {

    var characters = List<Character>.empty(growable: true);

    try {
      var ref = await _pb.collection('characters').getFullList();

      ref.forEach((record) {

        var char = Character.fromRecord(record);
        
        char.avatarUrl = _pb.files.getUrl(record, char.avatar);
        characters.add(char);
      });

      // characters = ref.map((element) => Character.fromRecord(element)..avatar = _pb.files.getUrl(element, element.avatar)).toList();

    } on ClientException catch (e) {
      // Pocketbase exception
      logger.e(e);
    } catch (e, stacktrace) {
      logger.e(e);
      logger.e(stacktrace);
    }
    return characters;
  }


  /// Retrieve Character
  Future<Character> getCharacter(String id) async {

    var character = Character();
    try {
      var ref = await _pb.collection('characters').getOne(id);
      character = Character.fromRecord(ref);
    }
    on ClientException catch (e) {
      logger.e(e);
    }
    catch (e) {
      logger.e(e);
    }

    return character;
  }

  Future<void> getCharacterStream(String id) async {
    await _pb.collection('characters').subscribe(id, (e) async {
      logger.d(e);
    });
  }

  Future<CharacterSheet> getCharacterSheet(String id) async {
    var characterSheet = CharacterSheet();
    try {
      var ref = await _pb.collection('character_sheets').getOne(id);
      characterSheet = CharacterSheet.fromRecord(ref);
    }
    on ClientException catch (e) {
      logger.e(e);
    }
    catch (e, stacktrace) {
      logger.e(e);
      logger.e(stacktrace);
    }
    return characterSheet;
  }

}
