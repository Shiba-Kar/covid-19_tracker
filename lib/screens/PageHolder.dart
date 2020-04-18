import 'package:covid_19/screens/CountryCovidPage.dart';
import 'package:covid_19/screens/GlobalCovidPage.dart';

import 'package:covid_19/widgets/NavButtons.dart';
import 'package:covid_19/widgets/Nm_box.dart';
import 'package:flutter/material.dart';

class PageHolder extends StatefulWidget {
  const PageHolder({Key key}) : super(key: key);

  @override
  _PageHolderState createState() => _PageHolderState();
}

class _PageHolderState extends State<PageHolder> {
  int currentPageIndex = 0;

  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    Widget bottomNavigationBar() {
      return BottomNavigationBar(
      backgroundColor: mC,
        elevation: 0.0,
        iconSize: 0.0,
        onTap: (index) => setState(() {
          currentPageIndex = index;
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        }),
        currentIndex: currentPageIndex,
        items: [
          BottomNavigationBarItem(
           
            icon: Container(),
            title: NMButtons(
              down: currentPageIndex != 0 ? false : true,
              icon: Icons.language,
            ),
          ),
          BottomNavigationBarItem(
            icon: Container(),
            title: NMButtons(
              down: currentPageIndex != 0 ? true : false,
              icon: Icons.place,
            ),
          ),
         
        ],
      );
    }

    return Scaffold(
      backgroundColor: mC,
      extendBody: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: mC,
        title: Text("COVID-19"),
        centerTitle: true,
      ),
      /*  appBar: AppBar(
        actions: <Widget>[
          RaisedButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MainCard())))
        ],
      ), */
      body: PageView(
        controller: _pageController,
        physics: ScrollPhysics(),
        children: <Widget>[GlobalCovidPage(), CountryCovidPage()],
        onPageChanged: (index) => setState(() {
          currentPageIndex = index;
        }),
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }
}
