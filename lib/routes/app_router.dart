import 'package:breaking_bad_app/data/models/character_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breaking_bad_app/business_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad_app/data/repositories/characters_repository.dart';
import 'package:breaking_bad_app/data/web_services/characters_web_services.dart';
import 'package:breaking_bad_app/presentation/screens/character_details_screen.dart';
import 'package:breaking_bad_app/presentation/screens/characters_screen.dart';
import 'package:breaking_bad_app/utils/app_routes.dart';

///
/// this class will handle the routing in the app
///
class AppRouter {
    late CharactersRepository charactersRepository;
    late CharactersCubit charactersCubit;

    AppRouter() {
        charactersRepository    = CharactersRepository(CharactersWebServices());
        charactersCubit         = CharactersCubit(charactersRepository);
    }

    ///
    /// the generateRoute() function will configure the routes after it's passed
    /// to the onGenerateRoute property in the root app widget
    ///
    Route? generateRoute(RouteSettings settings) {
        switch (settings.name) {
            case AppRoutes.allCharactersScreen:
                return MaterialPageRoute(
                    ///
                    /// BlocProviders holds the tree from the top and it provides the
                    /// the tree of ui with a cubit it creates itself
                    ///
                    builder: (_) => BlocProvider(
                        create: (BuildContext context) => charactersCubit,
                        child: const CharactersScreen(),
                    ),
                );
            case AppRoutes.characterDetailsScreen:
                ///
                /// the character item widget will give this character as an argument 
                /// to the character details screen
                ///
                final character = settings.arguments! as CharacterModel;
                
                return MaterialPageRoute(
                    builder: (_) => CharacterDetailsScreen(character: character)
                );
        }
    }
}