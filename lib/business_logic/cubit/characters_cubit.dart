import 'package:bloc/bloc.dart';
import '../../data/models/character_quotes_model.dart';
import '../../data/repositories/characters_repository.dart';
import 'package:meta/meta.dart';
import '../../data/models/character_model.dart';

part 'characters_state.dart';

///
/// - this cubit will take the data from the repository of the data layer
///   and send/emit it to the ui
///
class CharactersCubit extends Cubit<CharactersState> {
    final CharactersRepository charactersRepository;

    List<CharacterModel> characters = [];

    CharactersCubit(this.charactersRepository) : super(CharactersInitial());

    ///
    /// - bring the data from the repository and have it here in this cubit
    /// 
    /// - this function will send the data to the ui
    ///
    List<CharacterModel> getAllCharacters() {
        charactersRepository
            .getAllCharacters()
            .then((characters) {
                emit(CharactersLoaded(characters));

                this.characters = characters;
            });

        return characters;
    }

    void getCharacterQuotes(String characterName) {
        charactersRepository
        .getCharacterQuotes(characterName)
            .then((quotes) {
                emit(CharacterQuotesLoaded(quotes));
            });
    }
}