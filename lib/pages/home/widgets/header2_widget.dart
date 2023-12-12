import 'package:flutter/material.dart';
import 'package:flutter_dashboard/const.dart';
import 'package:flutter_dashboard/responsive.dart';

class Header2 extends StatelessWidget {
  const Header2({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!Responsive.isDesktop(context))
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: () => scaffoldKey.currentState!.openDrawer(),
                child: const Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.menu,
                    color: Colors.grey,
                    size: 25,
                  ),
                ),
              ),
            ),
          if (!Responsive.isMobile(context))
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: cardBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButton<String>(
                  value: 'Sort Asc', // You can set the initial value
                  items: <String>['Sort Asc', 'Sort Desc'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    // Handle sorting change
                  },
                ),
              ),
            ),
          if (Responsive.isMobile(context))
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 25,
                  ),
                  onPressed: () {},
                ),
                InkWell(
                  onTap: () => scaffoldKey.currentState!.openEndDrawer(),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset(
                      "assets/images/avatar.png",
                      width: 32,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
