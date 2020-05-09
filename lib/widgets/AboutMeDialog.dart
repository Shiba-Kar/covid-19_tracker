import 'package:covid_19/widgets/GlowFlags.dart';
import 'package:covid_19/widgets/NavButtons.dart';
import 'package:covid_19/widgets/Nm_box.dart';
import 'package:flutter/material.dart';

class AboutMeDialog extends StatefulWidget {
  AboutMeDialog({
    Key key,
  }) : super(key: key);

  _AboutMeDialogState createState() => _AboutMeDialogState();
}

class _AboutMeDialogState extends State<AboutMeDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            height: height / 1.6,
            width: width / 1.6,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: mC,
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    /* GlowFlags(
                      flagUrl:
                          'https://lh3.googleusercontent.com/a-/AOh14GjvCHaj8RtwsiAGDhNznjohQEMTxDMLm1F-r5Hi9vw=s96-c',
                    ), */
                    Text(
                      "Show Some Love",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  "Rate App In Playstore",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                NMButtons(
                  down: false,
                  icon: Icons.shop,
                ),
                Text(
                  "Find Me in",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    NMButtons(
                      down: false,
                      icon: Icons.shop,
                    ),
                    NMButtons(
                      down: false,
                      icon: Icons.shop,
                    ),
                    NMButtons(
                      down: false,
                      icon: Icons.shop,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
