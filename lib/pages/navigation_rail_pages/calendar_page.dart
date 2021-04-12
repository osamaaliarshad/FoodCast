import 'package:flutter/material.dart';
import 'package:foodcast/widgets/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 48,
              ),
              Text('Calendar', style: Theme.of(context).textTheme.headline4),
              SizedBox(
                height: (height * 0.5) / 5,
              ),
              TableCalendar(
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: sidebarColor,
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ), //
                  ),
                  focusedDay: DateTime.now(),
                  firstDay: DateTime.utc(2021, 1, 28),
                  lastDay: DateTime.utc(2030, 3, 14)),
              SizedBox(
                height: 50,
              ),
              Center(child: Text('Food that was made on this day'))
            ],
          ),
        ),
      ),
    );
  }
}
