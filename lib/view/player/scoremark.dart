import 'dart:math';

import 'package:cachetada/models/tentocenter_model.dart';
import 'package:flutter/material.dart';

class ScoreMark extends StatelessWidget {
  ScoreMark({
    this.tento,
    @required this.size,
  });
  final TentoCenterModel tento;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi / 180 * (tento.id + 1) * 33,
      child: Container(
        width: size,
        height: 20,
        alignment: Alignment.centerLeft,
        child: Image.asset(tento.imageAsset),
      ),
    );
  }
}
