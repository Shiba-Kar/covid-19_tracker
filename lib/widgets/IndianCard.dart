import 'package:covid_19/models/CovidDataIndianModel.dart';
import 'package:covid_19/screens/DetailedCountryScreen.dart';
import 'package:covid_19/widgets/GlowFlags.dart';
import 'package:covid_19/widgets/Nm_box.dart';
import 'package:flutter/material.dart';

class IndianCard extends StatefulWidget {
  final Statewise sateWise;
  const IndianCard({@required this.sateWise, Key key}) : super(key: key);

  @override
  _IndianCardState createState() => _IndianCardState();
}

class _IndianCardState extends State<IndianCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    Widget text(String text, Color color) {
      return Text(
        text,
        style: TextStyle(color: color, fontSize: 13.0),
      );
    }

    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Container(
             //s width: width / 1.23,
              decoration: nMboxInvert,
              child: ListTile(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => null),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        text("CASES : " + widget.sateWise.active.toString(),
                            Colors.yellow),
                        text("ACTIVE : " + widget.sateWise.active.toString(),
                            Colors.blue),
                      ],
                    ),
                    Divider(
                      indent: 50.0,
                      color: Colors.white,
                      endIndent: 50.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        text(
                            "RECOVERED : " +
                                widget.sateWise.recovered.toString(),
                            Colors.green),
                        text("DEATH : " + widget.sateWise.deaths.toString(),
                            Colors.red),
                      ],
                    )
                  ],
                ),
                contentPadding: const EdgeInsets.all(10.0),
                title: Text(
                  widget.sateWise.state,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
