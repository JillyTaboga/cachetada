import 'dart:io';
import 'dart:math';

import 'package:cachetada/controllers/actualtable_provider.dart';
import 'package:cachetada/models/player_model.dart';
import 'package:cachetada/services/hiveDB.dart';
import 'package:cachetada/view/player/playerCircle.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PlayerSelect extends StatefulWidget {
  PlayerSelect({@required this.player});
  final PlayerModel player;
  @override
  _PlayerSelectState createState() => _PlayerSelectState();
}

class _PlayerSelectState extends State<PlayerSelect> {
  PlayerModel player;
  TextEditingController nameController;

  @override
  void initState() {
    player = widget.player;
    nameController = TextEditingController(text: player.name);
    super.initState();
  }

  @override
  void didUpdateWidget(PlayerSelect oldWidget) {
    setState(() {
      player = widget.player;
      nameController = TextEditingController(text: player.name);
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  putImageInPlayer() async {
    PlayerModel playerNew = player.copyWith(id: Random().nextInt(99999), name: nameController.text??'O sem nome');
    File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    playerNew.imageUri = imageFile.uri.toString();
    if (player.isInBox) {
      player.delete();
    }
      HiveDB.savePlayer(playerNew);
    Provider.of<ActualTableProvider>(context, listen: false)
        .changePlayer(player, playerNew);
        Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(hintText: 'Nome'),
                    ),
                  ),
                  IconButton(icon: Icon(Icons.camera_alt), onPressed: () {
                    putImageInPlayer();
                  }),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    PlayerModel playerNew = player.copyWith(
                      name: nameController.text,
                    );
                    HiveDB.savePlayer(playerNew);
                    Provider.of<ActualTableProvider>(context, listen: false)
                        .changePlayer(player, playerNew);
                    Navigator.pop(context);
                  }),
              IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: () {
                    Provider.of<ActualTableProvider>(context, listen: false)
                        .changePlayer(player, PlayerModel.none());
                    Navigator.pop(context);
                  }),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Divider(),
          Text(
            'Jogadores salvos',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: ValueListenableBuilder<Box<PlayerModel>>(
              valueListenable: HiveDB.boxPlayers.listenable(),
              builder: (context, box, especialChild) {
                List<PlayerModel> players = box.values.toList();
                players.sort((a, b) => a.name.compareTo(b.name));
                return players.length < 1
                    ? Center(
                        child: Text('Nenhum jogador salvo'),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                            ),
                            itemCount: players.length,
                            itemBuilder: (context, index) {
                              PlayerModel playerSaved = players[index];
                              return LayoutBuilder(
                                builder: (context, constrainst) {
                                  return Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          Provider.of<ActualTableProvider>(
                                                  context,
                                                  listen: false)
                                              .changePlayer(
                                                  player, playerSaved);
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Theme.of(context)
                                                  .accentColor),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Expanded(
                                                  child: PlayerCicle(
                                                      player: playerSaved,
                                                      size: constrainst
                                                          .maxWidth)),
                                              Text(
                                                playerSaved.name,
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: -8,
                                        right: -8,
                                        child: IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () {
                                              playerSaved.delete();
                                            }),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }),
                      );
              },
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
