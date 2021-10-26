import 'package:breaking_bad_app/data/models/character_model.dart';
import 'package:breaking_bad_app/utils/app_assets.dart';
import 'package:breaking_bad_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
    final CharacterModel character;

    const CharacterItem({ 
        Key? key, 
        required this.character 
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Container(
            width: double.infinity,
            margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
            padding: const EdgeInsetsDirectional.all(4),
            decoration: BoxDecoration(
                color: AppColors.appWhite,
                borderRadius: BorderRadius.circular(8),
            ),
            child: GridTile(
                child: Container(
                    child: character.image != null
                        ///
                        /// FadeInImage creates a widget that uses a placeholder image stored in 
                        /// an asset bundle while loading the final image from the network
                        ///
                        ? FadeInImage.assetNetwork(
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: AppAssets.loadingImage, 
                            image: character.image!,
                        ) 
                        : Image.asset(
                            AppAssets.placeholderImage,
                            fit: BoxFit.cover,
                        )
                ),
                footer: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, 
                        vertical: 10
                    ),
                    color: Colors.black54,
                    alignment: Alignment.bottomCenter,
                    child: Text(
                        '${character.name}',
                        style: const TextStyle(
                            height: 1.3,
                            fontSize: 16,
                            color: AppColors.appWhite,
                            fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center
                    ),
                ),
            ),
        );
    }
}