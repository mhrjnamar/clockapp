import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'clock_view.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({Key? key}) : super(key: key);

  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEE, d MMM').format(now);
    var timezoneString = now.timeZoneOffset.toString().split(".").first;
    var offsetSign = '';
    if (!timezoneString.startsWith("-")) offsetSign = '+';

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
                      fontFamily: 'avenir', color: Colors.white, fontSize: 64),
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
  }
}
