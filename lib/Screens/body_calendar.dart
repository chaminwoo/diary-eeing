import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

class bodyCalendar extends StatefulWidget {
  bodyCalendar({Key? key}) : super(key: key);
  @override
  _bodyCalendarState createState() => _bodyCalendarState();
}

class _bodyCalendarState extends State<bodyCalendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        selectionDecoration: BoxDecoration(
            border:
                Border.all(color: Color.fromRGBO(200, 179, 132, 1), width: 3)),
        cellBorderColor: Color.fromRGBO(94, 69, 75, 1),
        //오늘 날짜 색
        todayHighlightColor: Color.fromRGBO(216, 179, 132, 1),
        //첫화면에서 월별로 보기
        view: CalendarView.month,
        //날짜 클릭 가능
        allowViewNavigation: true,
        //배경색
        backgroundColor: Color.fromRGBO(253, 252, 229, 1),
        //오늘 날짜 스타일 바꾸기
        todayTextStyle: TextStyle(fontStyle: FontStyle.italic, fontSize: 10),
        //일요일부터 시작
        firstDayOfWeek: 7,
        monthViewSettings: const MonthViewSettings(
          //날짜 클릭하면 해당 날짜에 대한 내용 달력 아래에 표시  -> 이거 안쓰면 날짜 내부로 들어가짐
          showAgenda: true,
          agendaViewHeight: 0,
          showTrailingAndLeadingDates: false,
          //앞뒤 날짜 안보이게
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        ),
      ),
    );
  }
}
