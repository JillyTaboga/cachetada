
import 'dart:math';

import 'package:cachetada/databases/playernames.dart';
import 'package:flutter/material.dart';

extension pad on SizedBox {

SizedBox h5 ()=> SizedBox(height: 5,);
SizedBox h8 ()=> SizedBox(height: 8,);
SizedBox h10 ()=> SizedBox(height: 10,);
SizedBox h15 ()=> SizedBox(height: 15,);
SizedBox h20 ()=> SizedBox(height: 20,);
 SizedBox w5 ()=> SizedBox(width: 5,);
SizedBox w8 ()=> SizedBox(width: 8,);
SizedBox w10 ()=> SizedBox(width: 10,);
SizedBox w15 ()=> SizedBox(width: 15,);
SizedBox w20 ()=> SizedBox(width: 20,);

}

extension randons on List<int>{
    List<int> getUnicIndexes(int size) {
    List<int> indexesUsed = [];
    int index = Random().nextInt(randomNames.length);
    indexesUsed.add(index);
    while (indexesUsed.contains(index) && indexesUsed.length<size) {
      index = Random().nextInt(randomNames.length);
      if(!indexesUsed.contains(index)){
    indexesUsed.add(index);
      }
    }
    return indexesUsed;
  }
}