import 'dart:io';
import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking_bad_app/business_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad_app/data/models/character_model.dart';
import 'package:breaking_bad_app/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailsScreen extends StatelessWidget {
    final CharacterModel character;

    const CharacterDetailsScreen({
        Key? key, 
        required this.character
    }) : super(
        key: key
    );

    ///
    /// - this is the image of the character and their nickname as well
    /// 
    /// - the rest of the information wil go in the sliver list
    ///
    Widget _buildSliverAppBar() {
        return SliverAppBar(
            expandedHeight: 600,
            pinned: true,
            stretch: true,
            backgroundColor: AppColors.appGrey,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                    character.nickName ?? '-',
                    style: const TextStyle(
                        color: AppColors.appWhite,
                    ),
                ),
                background: Hero(
                    tag: character.charId!,
                    child: Image.network(
                        character.image!, 
                        fit: BoxFit.cover
                    ),
                ),
            ),
        );
    }

    Widget characterInfo({required String title, required String value}) {
        return RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
                children: [
                    TextSpan(
                        text: title,
                        style: const TextStyle(
                            color: AppColors.appWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                        ),
                    ),
                    TextSpan(
                        text: value,
                        style: const TextStyle(
                            color: AppColors.appWhite,
                            fontSize: 16,
                        ),
                    ),
                ]
            ),
        );
    }

    Widget buildDivider({required double value}) {
        return Divider(
            color: AppColors.appYellow,
            height: 30,
            ///
            /// - this meant how much big space of the right side of the divider
            /// 
            /// - if i wanna less divider, give this high value
            ///
            endIndent: value,
            thickness: 2,
        );
    }

    Widget checkIfQuotesAreLoaded({required CharactersState state}) {
        if (state is CharacterQuotesLoaded) {
            return displayRandomQuoteOrEmptySpace(state);
        } else {
            return showProgressIndicator();
        }
    }

    Widget displayRandomQuoteOrEmptySpace(CharacterQuotesLoaded state) {
        final quotes = state.quotes;

        if (quotes.isNotEmpty) {
            final int randomQuoteIndex = Random().nextInt(quotes.length - 1);

            return Center(
                child: DefaultTextStyle(
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20,
                        color: AppColors.appWhite,
                        shadows: [
                            Shadow(
                                blurRadius: 7,
                                color: AppColors.appYellow,
                                offset: Offset.zero,
                            ),
                        ]
                    ), 
                    child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts:  [
                            TypewriterAnimatedText(quotes[randomQuoteIndex].quote ?? '-'),
                        ],
                    ),
                )
            );
        } else {
            return Container();
        }
    }

    Widget showProgressIndicator() {
        return Center(
            child: Platform.isIOS 
                ? const CupertinoActivityIndicator(
                    radius: 15,
                ) 
                : const CircularProgressIndicator(
                    color: AppColors.appYellow,
                ),
        );
    }

    @override
    Widget build(BuildContext context) {
        ///
        /// to listen to the cubit the bloc provider provided us
        ///
        BlocProvider.of<CharactersCubit>(context).getCharacterQuotes(character.name!);

        return Scaffold(
            backgroundColor: AppColors.appGrey,
            body: CustomScrollView(
                slivers: [
                    _buildSliverAppBar(),
                    SliverList(
                        delegate: SliverChildListDelegate([
                            Container(
                                margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        characterInfo(
                                            title: 'Job: ', 
                                            value: character.jobs!.join(' / ')
                                        ),
                                        buildDivider(value: 315),
                                        characterInfo(
                                            title: 'Appeared in: ', 
                                            value: character.categoryForTwoSeries!,
                                        ),
                                        buildDivider(value: 250),
                                        characterInfo(
                                            title: 'Seasons: ', 
                                            value: character.appearanceOfSeasons!.join(' / '),
                                        ),
                                        buildDivider(value: 280),
                                        characterInfo(
                                            title: 'Status: ', 
                                            value: character.statusIfDeadOrAlive!,
                                        ),
                                        buildDivider(value: 300),
                                        character.betterCallSaulAppearance!.isEmpty 
                                            ? Container() 
                                            : characterInfo(
                                                title: 'Better Call Saul Seasons: ', 
                                                value: character.betterCallSaulAppearance!.join(' / '),
                                            ),
                                        character.betterCallSaulAppearance!.isEmpty 
                                            ? Container()
                                            : buildDivider(value: 150),
                                        characterInfo(
                                            title: 'Actor/Actress: ', 
                                            value: character.actorName!,
                                        ),
                                        buildDivider(value: 235),
                                        const SizedBox(
                                            height: 20,
                                        ),
                                        BlocBuilder<CharactersCubit, CharactersState>(
                                            builder: (context, state) {
                                                return checkIfQuotesAreLoaded(state: state);
                                            },
                                        ),
                                    ],
                                ),
                            ),
                            const SizedBox(
                                height: 600,
                            ),
                        ])
                    ),
                ],
            ),
        );
    }
}