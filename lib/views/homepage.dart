import 'package:clockapp/constants/theme_data.dart';
import 'package:clockapp/data.dart';
import 'package:clockapp/enums.dart';
import 'package:clockapp/models/menu_info.dart';
import 'package:clockapp/views/alarm_page.dart';
import 'package:clockapp/views/clock_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems
                .map((currentMenuInfo) => buildMenuButton(currentMenuInfo))
                .toList(),
          ),
          VerticalDivider(
            color: Colors.white54,
            width: 1,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (context, value, child) {
                if (value.menuType == MenuType.clock)
                  return ClockPage();
                else if (value.menuType == MenuType.alarm) return AlarmPage();
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (context, value, child) {
        return TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(32)))),
              backgroundColor: MaterialStateColor.resolveWith((states) =>
                  currentMenuInfo.menuType == value.menuType
                      ? CustomColors.menuBackgroundColor
                      : Colors.transparent),
              padding:
                  MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 16)),
            ),
            onPressed: () {
              var menuInfo = Provider.of<MenuInfo>(context, listen: false);
              menuInfo.updateMenu(currentMenuInfo);
            },
            child: Column(children: [
              Image.asset(
                currentMenuInfo.imageSource!,
                scale: 1.5,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                currentMenuInfo.title ?? '',
                style: TextStyle(
                    fontFamily: 'avenir', color: Colors.white, fontSize: 14),
              ),
            ]));
      },
    );
  }
}
