import 'package:clockapp/constants/theme_data.dart';
import 'package:clockapp/data.dart';
import 'package:clockapp/enums.dart';
import 'package:clockapp/menu_info.dart';
import 'package:clockapp/views/clock_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEE, d MMM').format(now);
    var timezoneString = now.timeZoneOffset.toString().split(".").first;
    print(timezoneString);
    var offsetSign = '';
    if (!timezoneString.startsWith("-")) offsetSign = '+';
    print(timezoneString);
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
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Text(
                            "Clock",
                            style: TextStyle(
                                fontFamily: 'avenir',
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 24),
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                formattedTime,
                                style: TextStyle(
                                    fontFamily: 'avenir',
                                    color: Colors.white,
                                    fontSize: 64),
                              ),
                              Text(
                                formattedDate,
                                style: TextStyle(
                                    fontFamily: 'avenir',
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                            flex: 4,
                            fit: FlexFit.tight,
                            child: Align(
                                alignment: Alignment.center,
                                child: ClockView(
                                  size: MediaQuery.of(context).size.height / 4,
                                ))),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Timezone',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'avenir',
                                    color: Colors.white,
                                    fontSize: 24),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.language,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    'UTC' + offsetSign + timezoneString,
                                    style: TextStyle(
                                        fontFamily: 'avenir',
                                        color: Colors.white,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
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
