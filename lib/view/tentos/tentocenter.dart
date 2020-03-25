import 'package:cachetada/controllers/actualtable_provider.dart';
import 'package:cachetada/models/tentocenter_model.dart';
import 'package:cachetada/view/tentos/tentoimage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TentoCenter extends StatelessWidget {
  TentoCenter({@required this.tentoCento});
  final TentoCenterModel tentoCento;
  @override
  Widget build(BuildContext context) {
    return Draggable<TentoCenterModel>(
      data: tentoCento,
      onDragCompleted: (){
              Provider.of<ActualTableProvider>(context, listen: false)
        .removeTableTanto(tentoCento);
      },
        child: TentoDragImage(tento: tentoCento,),
        childWhenDragging: Container(),
        feedback: TentoDragImage(tento: tentoCento,),
    );
  }
}