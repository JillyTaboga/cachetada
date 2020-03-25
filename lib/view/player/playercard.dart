import 'package:cachetada/controllers/actualtable_provider.dart';
import 'package:cachetada/models/player_model.dart';
import 'package:cachetada/models/tentocenter_model.dart';
import 'package:cachetada/view/dialogs/playerselect.dart';
import 'package:cachetada/view/player/playerCircle.dart';
import 'package:cachetada/view/player/scoremark.dart';
import 'package:cachetada/view/tentos/tentoimage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerCard extends StatefulWidget {
  PlayerCard({@required this.player});
  final PlayerModel player;

  @override
  _PlayerCardState createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  PlayerModel player;
  List<int> tentos = [];

@override
  initState() {
    player = widget.player;
    super.initState();
  }

  @override
  void didUpdateWidget(PlayerCard oldWidget) {
    setState(() {
    player = widget.player;
    });
    super.didUpdateWidget(oldWidget);
  }

  List<Widget> _scoreMarks(double size) {
    List<Widget> scores = [];
    for (TentoCenterModel tento in player.scores) {
      scores.add(
        ScoreMark(
          tento: tento,
          size: size,
        ),
      );
    }
    scores.add(
      player.scores.length < 1
          ? PlayerCicle(size: size, player: player,)
          : Draggable<TentoCenterModel>(
              onDragCompleted: () {
                Provider.of<ActualTableProvider>(context, listen: false)
                    .removeTentoToPlayer(player, player.scores.last);
              },
              data: player.scores.last,
              feedback: TentoDragImage(tento: player.scores.last),
              child: PlayerCicle(size: size, player: player,),
            ),
    );
    return scores;
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<TentoCenterModel>(onAccept: (data) {
      Provider.of<ActualTableProvider>(context, listen: false)
          .addTentoToPlayer(player, data);
    }, builder: (context, id, types) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: LayoutBuilder(builder: (context, constraints) {
          double size = MediaQuery.of(context).size.width >
                  MediaQuery.of(context).size.height
              ? constraints.maxHeight
              : constraints.maxWidth;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: _scoreMarks(size),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: (){
                  showDialog(context: context, builder: (context){
                    return PlayerSelect(player: player);
                  });
                },
                              child: Text(
                  widget.player.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          );
        }),
      );
    });
  }
}
