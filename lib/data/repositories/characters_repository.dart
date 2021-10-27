import 'package:breaking_bad_app/data/models/character_model.dart';
import 'package:breaking_bad_app/data/models/character_quotes_model.dart';
import 'package:breaking_bad_app/data/web_services/characters_web_services.dart';

///
/// - this repository will take the data as json response from the web services
///   then map it into a list of our model
///
class CharactersRepository {
    final CharactersWebServices charactersWebServices;

    CharactersRepository(this.charactersWebServices);

    ///
    /// map the json data we got from the web services and turn them into
    /// list of character model
    ///
    Future<List<CharacterModel>> getAllCharacters() async {
        final characters = await charactersWebServices.getAllCharacters();

        return characters
            .map(
                (character) => CharacterModel.fromJson(character as Map<String, dynamic>)
            )
            .toList();
    }

    Future<List<CharacterQuotesModel>> getCharacterQuotes(String characterName) async {
        final quotes = await charactersWebServices.getCharacterQuotes(characterName);

        return quotes
            .map(
                (quote) => CharacterQuotesModel.fromJson(quote as Map<String, dynamic>)
            )
            .toList();
    }
}