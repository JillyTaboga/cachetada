
import 'package:cachetada/models/tentocenter_model.dart';
import 'package:flutter/material.dart';

class TentoDragImage extends StatelessWidget {
  TentoDragImage({@required this.tento});
  final TentoCenterModel tento;
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: tento.rotation,
      child: Container(
        alignment: Alignment.center,
        width: 40,
        height: 40,
        child: Image.asset(tento.imageAsset),
      ),
    );
  }
}