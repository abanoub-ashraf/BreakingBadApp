part of 'characters_cubit.dart';

///
/// this file will have all the states
///
@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoaded extends CharactersState {
    final List<CharacterModel> characters;

    CharactersLoaded(this.characters);
}