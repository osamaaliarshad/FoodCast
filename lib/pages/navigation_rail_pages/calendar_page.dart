import 'package:flutter/material.dart';
import 'package:foodcast/models/food_item_model.dart';
import 'package:foodcast/widgets/constants.dart';
import 'package:foodcast/widgets/popup_menus.dart';
import 'package:table_calendar/table_calendar.dart';
import 'recipe/food_info_page.dart';
import 'recipe/recipe_page.dart';
import 'dart:ui';
import 'package:foodcast/pages/navigation_rail_pages/recipe/food_info_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:foodcast/controller/food_list_controller.dart';

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  //
  @override
  void initState() {
    _selectedDay = DateTime.now();
    // _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //   List<Event> _getEventsForDay(DateTime day) {
  //   // Implementation example
  //   return kEvents[day] ?? [];
  // }

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
                height: (height * 0.2) / 5,
              ),
              TableCalendar(
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      // Call `setState()` when updating calendar format
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay =
                          focusedDay; // update `_focusedDay` here as well
                    });
                  },
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
                  focusedDay: _focusedDay,
                  firstDay: DateTime.utc(2021, 1, 28),
                  lastDay: DateTime.utc(2030, 3, 14)),
              SizedBox(
                height: 15,
              ),
              Center(
                  child: Text(
                'Food made on this day:',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              )),
              SizedBox(
                height: 15,
              ),
              Consumer(builder: (context, watch, child) {
                var foods = watch(foodItemListControllerProvider.state);
                return foods.when(
                  loading: () => const CircularProgressIndicator(),
                  error: (err, stack) => Text('Error: $err'),
                  data: (foods) => (SizedBox(
                    height: 250,
                    child: ListView(
                      physics: AlwaysScrollableScrollPhysics(),
                      children: List.generate(
                        foods.length,
                        (index) {
                          final foodItem = foods[index];
                          return (foods[index].lastMade != null &&
                                  foods[index]
                                          .lastMade
                                          .toString()
                                          .substring(0, 10) ==
                                      _selectedDay.toString().substring(0, 10))
                              ? GestureDetector(
                                  child: Container(
                                      height: 100,
                                      child:
                                          CreateStyleCard(foodItem: foodItem)),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FoodInfoPage(
                                          food: foodItem,
                                        ),
                                      ),
                                    );
                                  },
                                  onLongPressStart:
                                      (LongPressStartDetails details) async {
                                    double left = details.globalPosition.dx;
                                    double top = details.globalPosition.dy;
                                    await showCalendarPageMenu(
                                        context, left, top, foodItem);
                                  },
                                )
                              : SizedBox.shrink();
                        },
                      ),
                    ),
                  )),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
