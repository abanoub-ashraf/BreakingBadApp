import '../../utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/characters_cubit.dart';
import '../../data/models/character_model.dart';
import '../widgets/character_item.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_colors.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
    const CharactersScreen({ Key? key }) : super(key: key);

    @override
    State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
    late List<CharacterModel> allCharacters;
    late List<CharacterModel> searchedForCharacters;
    bool _isSearching = false;
    final _searchTextController = TextEditingController();

    @override
    void initState() {
        super.initState();
        
        ///
        /// now the ui is calling the the lazy bloc/cubit that the bloc provider created
        ///
        BlocProvider.of<CharactersCubit>(context).getAllCharacters();
    }

    Widget _buildSearchField() {
        return TextField(
            controller: _searchTextController,
            cursorColor: AppColors.appWhite,
            decoration: const InputDecoration(
                hintText: 'Find a Character...',
                border: InputBorder.none,
                hintStyle: TextStyle(
                    color: AppColors.appWhite,
                    fontSize: 18
                ),
            ),
            style: const TextStyle(
                color: AppColors.appWhite,
                fontSize: 18
            ),
            onChanged: (searchedCharacter) {
                _addSearchedForItemsToSearchList(searchedCharacter);
            },
        );
    }

    void _addSearchedForItemsToSearchList(String searchedCharacter) {
        searchedForCharacters = allCharacters
            .where(
                (character) => character.name!.toLowerCase().startsWith(searchedCharacter)
            )
            .toList();

        setState(() {

        });
    }

    List<Widget> _buildAppBarActions() {
        if (_isSearching) {
            return [
                IconButton(
                    icon: const Icon(
                        Icons.clear, 
                        color: AppColors.appWhite
                    ),
                    onPressed: () {
                        _clearSearch();

                        ///
                        /// clear the new route that i pretended to flutter that i was going to
                        ///
                        Navigator.pop(context);
                    }, 
                )
            ];
        } else {
            return [
                IconButton(
                    icon: const Icon(
                        Icons.search,
                        color: AppColors.appWhite,
                    ),
                    onPressed: _startSearch, 
                )
            ];
        }
    }

    void _startSearch() {
        ///
        /// this will make flutter think we going to a new route so a back button
        /// will automatically created by flutter for us
        ///
        ModalRoute.of(context)!.addLocalHistoryEntry(
            LocalHistoryEntry(
                onRemove: _stopSearching
            )
        );

        setState(() {
            _isSearching = true;
        });
    }

    void _stopSearching() {
        _clearSearch();

        setState(() {
            _isSearching = false;
        });
    }

    void _clearSearch() {
        setState(() {
            _searchTextController.clear();
        });
    }

    Widget buildBlocBuilderWidget() {
        ///
        /// - BlocBuilder takes the cubit the bloc provider created and also its state
        /// 
        /// - its state could be many but in our case we only have one state which is 
        ///   CharactersLoaded, we could have more
        /// 
        /// - check if the state is the one we want and build your ui according to
        ///   that state however you want
        ///
        return BlocBuilder<CharactersCubit, CharactersState>(
            builder: (context, state) {
                if (state is CharactersLoaded) {
                    allCharacters = state.characters;
                    return buildLoadedListWidget();
                } else {
                    ///
                    /// this loading spinner will show until the data's got from the server
                    /// and got sent to the cubit
                    ///
                    return showLoadingIndicator();
                }
            },
        );
    }

    Widget showLoadingIndicator() {
        return Center(
            child: Image.asset(AppAssets.loadingImage),
        );
    }

    Widget buildLoadedListWidget() {
        return SingleChildScrollView(
            child: Column(
                children: [
                    buildCharactersList(),
                ],
            ),
        );
    }

    Widget buildCharactersList() {
        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2/3,
                crossAxisSpacing: 3,
                mainAxisSpacing: 2,
            ), 
            itemCount: _searchTextController.text.isEmpty 
                ? allCharacters.length 
                : searchedForCharacters.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(5),
            itemBuilder: (ctx, index) {
                return CharacterItem(
                    character: _searchTextController.text.isEmpty 
                        ? allCharacters[index] 
                        : searchedForCharacters[index]
                );
            }
        );
    }

    Widget _buildAppBarTitle() {
        return const Text(
            AppStrings.charactersScreenName,
            style: TextStyle(
                color: AppColors.appWhite,
            ),
        );
    }

    Widget buildNoInternetWidget() {
        return Center(
            child: Container(
                color: Colors.white,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        const Text(
                            "No Internet Connection\n Please check Your Internet", 
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22, 
                                color: AppColors.appGrey,
                            ),
                        ),
                        Image.asset(
                            AppAssets.offlineImage,
                        ),
                    ],
                ),
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                backgroundColor: AppColors.appGrey,
                leading: _isSearching 
                    ? const BackButton(
                        color: AppColors.appWhite,
                    ) 
                    : Container(),
                title: _isSearching 
                    ? _buildSearchField() 
                    : _buildAppBarTitle(),
                actions: _buildAppBarActions(),
            ),
            body: OfflineBuilder(
                connectivityBuilder: (context, connectivity, child) {
                    final bool connected = connectivity != ConnectivityResult.none;
                    if (connected) {
                        return buildBlocBuilderWidget();
                    } else {
                        return buildNoInternetWidget();
                    }
                },
                child: showLoadingIndicator(),
            ),
        );
    }
}