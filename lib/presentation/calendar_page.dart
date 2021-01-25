import 'package:flutter/material.dart';
import 'package:foodcast/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarController _calendarController;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
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
                calendarController: _calendarController,
                calendarStyle: CalendarStyle(
                  weekendStyle: TextStyle(color: Colors.black),
                  outsideDaysVisible: false,
                  todayColor: activeColor,
                  selectedColor: sidebarColor,
                  selectedStyle: TextStyle(color: Colors.black),
                  outsideWeekendStyle: TextStyle(color: Colors.black),
                ),
              ),
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
