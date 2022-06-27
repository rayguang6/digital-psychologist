import 'package:digital_psychologist/responsive/responsive_layout.dart';
import 'package:digital_psychologist/responsive/web_screen_layout.dart';
import 'package:digital_psychologist/screens/home_screen.dart';
import 'package:digital_psychologist/utils/colors.dart';
import 'package:digital_psychologist/utils/global_variable.dart';
import 'package:digital_psychologist/widgets/my_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      // appBar: AppBar(
      //   backgroundColor: Colors.blueAccent,
      //   title: const Text(
      //     'Digital Psychologist',
      //   ),
      //   centerTitle: true,
      //   automaticallyImplyLeading: true,
      //   actions: [
      //     IconButton(
      //       icon: const Icon(
      //         Icons.chat,
      //         color: Colors.white,
      //       ),
      //       onPressed: () {
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (c) => const HomeScreen()));
      //       },
      //     ),
      //   ],
      // ),
      body: PageView(
        children: homeScreenItems,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: (_page == 0) ? Colors.blueAccent : secondaryColor,
            ),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.task,
                color: (_page == 1) ? Colors.blueAccent : secondaryColor,
              ),
              label: 'Plan',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.menu_book,
                color: (_page == 2) ? Colors.blueAccent : secondaryColor,
              ),
              label: 'Journal',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: (_page == 3) ? Colors.blueAccent : secondaryColor,
            ),
            label: 'Life Score',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people,
              color: (_page == 4) ? Colors.blueAccent : secondaryColor,
            ),
            label: 'Community',
            backgroundColor: primaryColor,
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}
