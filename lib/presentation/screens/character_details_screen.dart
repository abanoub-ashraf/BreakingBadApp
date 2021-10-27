import 'package:breaking_bad_app/data/models/character_model.dart';
import 'package:breaking_bad_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

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

    @override
    Widget build(BuildContext context) {
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