import 'dart:io';

import 'package:cachetada/models/player_model.dart';
import 'package:flutter/material.dart';

class PlayerCicle extends StatelessWidget {
  PlayerCicle({@required this.player, @required this.size});
  final double size;
  final PlayerModel player;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          clipBehavior: Clip.antiAlias,
          height: size - 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black, offset: Offset(0, 2), blurRadius: 3)],
              border: Border.all(color: Colors.black38, width: 2),
              color: Colors.white.withRed(240)),
          child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    player.abv,
                    style: TextStyle(
                        fontSize: 25 * (MediaQuery.of(context).size.height / 900),
                        fontWeight: FontWeight.bold),
                  ),
                ),
        ),
        player.imageUri==null? Container() : Container(
                    width: size - 40,
          child: AspectRatio(
            aspectRatio: 1,
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(999999),
                    clipBehavior: Clip.antiAlias,
                              child: Image.file(
                        File.fromUri(Uri.parse(player.imageUri)),
                        fit: BoxFit.cover,
                      ),
                  ),
          ),
        ),
      ],
    );
  }
}