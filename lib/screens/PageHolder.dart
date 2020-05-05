import 'package:covid_19/screens/CountriesCovidPage.dart';
import 'package:covid_19/screens/GlobalCovidPage.dart';
import 'package:covid_19/screens/IndianCovidPage.dart';
import 'package:covid_19/screens/IndianStatesCovidPage.dart';

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
        type : BottomNavigationBarType.fixed,
        backgroundColor: mC,
       selectedFontSize: 15.0,
        elevation: 0.0,
        iconSize: 0.0,
        onTap: (index) => setState(
          () {
            currentPageIndex = index;
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          },
        ),
        currentIndex: currentPageIndex,
       // type: BottomNavigationBarType.shifting,
        items: [
         
          BottomNavigationBarItem(
            icon: Container(),
            title: NMButtons(
              down: currentPageIndex == 0 ? true : false,
              icon: Icons.language,
            ),
          ),
          BottomNavigationBarItem(
            icon: Container(),
            title: NMButtons(
              down: currentPageIndex == 1 ? true : false,
              icon: Icons.place,
            ),
          ),
           BottomNavigationBarItem(
            icon: Container(),
            title: NMButtons(
              down: currentPageIndex == 2 ? true : false,
              icon: Icons.home,
            ),
          ),
             BottomNavigationBarItem(
            icon: Container(),
            title: NMButtons(
              down: currentPageIndex == 3 ? true : false,
              icon: Icons.play_for_work,
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: mC,
      extendBody: true,
      body: PageView(
        controller: _pageController,
        physics: ScrollPhysics(),
        children: <Widget>[
          GlobalCovidPage(),
          CountriesCovidPage(),
          IndianCovidPage(),
         IndianStatesCovidPage()
          
        ],
        onPageChanged: (index) => setState(() {
          currentPageIndex = index;
        }),
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }
}
