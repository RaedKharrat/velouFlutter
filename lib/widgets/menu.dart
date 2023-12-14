// menu.dart
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/Responsive.dart';
import 'package:flutter_dashboard/model/menu_modal.dart';
import 'package:flutter_svg/svg.dart';

class Menu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const Menu({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<MenuModel> menu = [
    MenuModel(icon: 'home', title: "Dashboard"),
    MenuModel(icon: 'person', title: "Users"),
    MenuModel(icon: 'chat', title: "Chats"),
    MenuModel(icon: 'settings', title: "Velos"),
    MenuModel(icon: 'payment', title: "Reservations"),
    MenuModel(icon: 'logout', title: "Signout"),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF171821),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: Responsive.isMobile(context) ? 40 : 80,
              ),
              for (var i = 0; i < menu.length; i++)
                InkWell(
                  onTap: () {
                    widget.scaffoldKey.currentState!.openEndDrawer();
                    navigateToPage(menu[i].title);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(6.0),
                      ),
                      color: menu[i].isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 13, vertical: 7),
                          child: SvgPicture.asset(
                            'assets/svg/${menu[i].icon}.svg',
                            color: menu[i].isSelected
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                        Text(
                          menu[i].title,
                          style: TextStyle(
                            fontSize: 16,
                            color: menu[i].isSelected
                                ? Colors.black
                                : Colors.grey,
                            fontWeight: menu[i].isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              // Add a Container with the logo after the menu items
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Image.asset(
                  'assets/images/logovelouu.png', // Replace with your image path
                  width: 230, // Adjust the width to make it bigger
                  height: 230, // Adjust the height to make it bigger
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToPage(String title) {
    setState(() {
      for (var item in menu) {
        item.isSelected = (item.title == title);
      }
    });

    switch (title) {
      case "Dashboard":
        Navigator.of(context).pushReplacementNamed('/dashboard');
        break;
      case "Reservations":
        Navigator.of(context).pushReplacementNamed('/reservation');
        break;
      // Add cases for other menu items as needed
      // ...

      default:
        // Handle default case or do nothing
        break;
    }
  }
}