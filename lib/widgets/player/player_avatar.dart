import 'dart:io';

import 'package:Wellness/model/player.dart';
import 'package:flutter/material.dart';

import '../diagonally_cut_image.dart';

class PlayerAvatar extends StatelessWidget{

  final File file;
  PlayerAvatar(this.file);

  @override
  Widget build(BuildContext context) {
    return  DiagonallyCutImage(
      Image.asset(
        file == null ? Player.defaultAvatar : file.path,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
        height: 300,
      ),
      color: Colors.black.withOpacity(0.3),
    );
  }
}