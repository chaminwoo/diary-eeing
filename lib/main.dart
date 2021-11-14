import 'package:diary/Screens/body_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Screens/body_settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //디버그 표시 제거
      debugShowCheckedModeBanner: false,
      //캘린더 한글 지원용
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      //현지화 한글로 설정
      supportedLocales: const [
        Locale('ko', ''),
        Locale('en', ''),
      ],
      locale: const Locale('ko'),
      //home 위젯에서 메인화면 구현
      home: myScreenManager(),
      //테마 설정
      theme: ThemeData(
          fontFamily: "Gosanja",
          iconTheme: const IconThemeData(color: Color.fromRGBO(94, 69, 75, 1)),
          scaffoldBackgroundColor: const Color.fromRGBO(253, 252, 229, 1),
          appBarTheme: const AppBarTheme(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10))),
            color: Color.fromRGBO(253, 252, 229, 1),
            titleTextStyle: TextStyle(
              color: Color.fromRGBO(94, 69, 75, 1),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          )),
    );
  }
}

//화면 상태용 전역변수같은것
class AppState {
  bool loading;
  String user;
  AppState(this.loading, this.user);
}

//로그인,로딩,메인화면 관리자
class myScreenManager extends StatefulWidget {
  myScreenManager({Key? key}) : super(key: key);
  @override
  _myScreenManagerState createState() => _myScreenManagerState();
}

class _myScreenManagerState extends State<myScreenManager>
    with TickerProviderStateMixin {
  //초기 로그인 상태, loading은 true로 user는 비운상태로 초기화
  final app = AppState(true, '');

  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _delay();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  _delay() {
    //로딩이 true였다가 1초후에 false로 바뀌게 함
    Future.delayed(Duration(seconds: 1), () {
      setState(() => app.loading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (app.loading) return _loading();
    if (app.user.isEmpty) return _signIn();
    return _main();
  }

  //로딩화면
  Widget _loading() {
    return const Scaffold(
      appBar: null,
      body: Center(
        child: Text(
          "선택지 일기",
          style: TextStyle(
              color: Color.fromRGBO(94, 69, 75, 1),
              fontSize: 60,
              fontFamily: 'Gosanja'),
        ),
      ),
    );
  }

  //로그인화면
  Widget _signIn() {
    return Scaffold(
        appBar: AppBar(title: Text('로그인하기')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('ID'),
              Text('PW'),
              ElevatedButton(
                  child: Text('로그인'),
                  onPressed: () {
                    //로그인버튼 누르면 app에 값을 변경하고 delay로 값을 확인
                    setState(() {
                      app.loading = true;
                      app.user = '사용자';
                      _delay();
                    });
                  })
            ],
          ),
        ));
  }

  //로그인후 메인화면
  Widget _main() {
    return Scaffold(
      appBar: null,
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: const <Widget>[
          Tab(
            icon: Icon(
              Icons.account_circle,
              color: Color.fromRGBO(94, 69, 75, 1),
            ),
          ),
          Tab(
            icon: Icon(
              Icons.calendar_today,
              color: Color.fromRGBO(94, 69, 75, 1),
            ),
          ),
          Tab(
            icon: Icon(
              Icons.add_chart,
              color: Color.fromRGBO(94, 69, 75, 1),
            ),
          ),
        ],
      ),

      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          //설정탭
          Center(
            //리스트뷰는 나중에 달력처럼 다른파일로 빼기
            child: ListView(padding: EdgeInsets.zero, children: <Widget>[
              //로그아웃
              ListTile(
                leading: const Icon(
                  Icons.logout,
                ),
                title: Text('로그아웃'),
                onTap: () {
                  setState(() {
                    app.user = '';
                    app.loading = true;
                    _delay();
                  });
                },
              ),
            ]),
          ),
          //캘린더탭
          Center(
            child: bodyCalendar(),
          ),
          //통계탭
          Center(
            child: Text("여기에 통계 만들기"),
          ),
        ],
      ),

      //bodyCalendar(),
    );
  }
}
