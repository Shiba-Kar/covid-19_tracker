import 'package:covid_19/widgets/Nm_box.dart';
import 'package:flutter/material.dart';

class NMButtons extends StatelessWidget {
  final bool down;
  final IconData icon;
  const NMButtons({this.down, this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: down ? nMboxInvert : nMbox,
      child: Icon(
        icon,
        color: down ? fCD : fCL,
      ),
    );
  }
}
