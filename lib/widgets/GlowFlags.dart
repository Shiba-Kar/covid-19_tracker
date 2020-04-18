import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class GlowFlags extends StatelessWidget {
  final String flagUrl;
  const GlowFlags({@required this.flagUrl,Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
    startDelay: Duration(milliseconds: 1000),
    glowColor: Colors.white,
    endRadius: 50.0,
    duration: Duration(milliseconds: 2000),
    repeat: true,
    showTwoGlows: true,
    repeatPauseDuration: Duration(milliseconds: 100),
    child: Material(
      elevation: 8.0,
      shape: CircleBorder(),
      child: CircleAvatar(
        backgroundColor:Colors.grey[100] ,
        backgroundImage: NetworkImage(flagUrl),
        radius: 25.0,
        
      ),
    ),
    shape: BoxShape.circle,
    animate: true,
    curve: Curves.fastOutSlowIn,
  );
  }
}