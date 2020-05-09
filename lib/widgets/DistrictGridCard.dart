import 'package:covid_19/models/StateDistrictCovidDataModel.dart';

import 'package:covid_19/widgets/Nm_box.dart';
import 'package:flutter/material.dart';

class DistrictGridCard extends StatefulWidget {
  final DistrictDatum district;
  const DistrictGridCard({@required this.district, Key key}) : super(key: key);

  @override
  _DistrictGridCardState createState() => _DistrictGridCardState();
}

class _DistrictGridCardState extends State<DistrictGridCard> {
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
                        text("CASES : " + widget.district.confirmed.toString(),
                            Colors.yellow),
                        text("ACTIVE : " + widget.district.active.toString(),
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
                                widget.district.recovered.toString(),
                            Colors.green),
                        text("DEATH : ", Colors.red),
                      ],
                    )
                  ],
                ),
                contentPadding: const EdgeInsets.all(10.0),
                title: Text(
                  widget.district.district,
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
