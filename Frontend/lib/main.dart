import 'package:dbms_project/Events/Cerebro/register_cerebro.dart';
import 'package:dbms_project/Events/Kreiva/artistico.dart';
import 'package:dbms_project/Events/Kreiva/euphoria.dart';
import 'package:dbms_project/Events/Kreiva/kahanikar.dart';
import 'package:dbms_project/Events/Kreiva/kreiva.dart';
import 'package:dbms_project/Events/Kreiva/register_kreiva.dart';
import 'package:dbms_project/Events/Kreiva/retroDen.dart';
import 'package:dbms_project/Events/Kreiva/scavengeTheTreasure.dart';
import 'package:dbms_project/Events/Kreiva/syncTheSnaps.dart';
import 'package:dbms_project/Events/Ventura/badminton.dart';
import 'package:dbms_project/Events/Ventura/cricketLeague.dart';
import 'package:dbms_project/Events/Ventura/football.dart';
import 'package:dbms_project/Events/Ventura/register_ventura.dart';
import 'package:dbms_project/Events/Ventura/tableTennis.dart';
import 'package:dbms_project/Events/Ventura/ventura.dart';
import 'package:dbms_project/Events/Ventura/volleyball.dart';
import 'package:dbms_project/Widgets/upcoming_events.dart';
import 'package:dbms_project/utils/routes.dart';
import 'package:flutter/material.dart';
import 'Events/Cerebro/cerebro.dart';
import 'Events/Cerebro/cookACode.dart';
import 'Events/Cerebro/csGo.dart';
import 'Events/Cerebro/prudentia.dart';
import 'Events/Cerebro/roboRace.dart';
import 'Events/Cerebro/valorant.dart';
import 'Widgets/accounts.dart';
import 'Widgets/home_page.dart';
import 'Widgets/login_page.dart';
import 'Widgets/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      home: LoginPage(),
      routes: {
        MyRoutes.homeRoute: (context) => HomePage(),
        MyRoutes.loginRoute: (context) => LoginPage(),
        MyRoutes.accountRoute: (context) => Accounts(),
        MyRoutes.registerRoute: (context) => RegisterPage(),

        //Cerebro
        MyRoutes.cerebroRoute : (context) => Cerebro(),
        MyRoutes.csGoRoute : (context) => CsGo(),
        MyRoutes.valorantRoute : (context) => Valorant(),
        MyRoutes.roboraceRoute : (context) => RoboRace(),
        MyRoutes.cookAcodeRoute: (context) => CookACode(),
        MyRoutes.prudentiaRoute: (context) => Prudentia(),

        //Kreiva
        MyRoutes.kreivaRoute : (context) => Kreiva(),
        MyRoutes.artisticoRoute : (context) => Artistico(),
        MyRoutes.euphoriaRoute : (context) => Euphoria(),
        MyRoutes.kahanikarRoute : (context) => Kahanikar(),
        MyRoutes.retroDenRoute : (context) => RetroDen(),
        MyRoutes.scavengeTheTreasureRoute : (context) =>ScavengeTheTreasure(),
        MyRoutes.syncTheSnapsRoute : (context) => SyncTheSnaps(),

        //Ventura
        MyRoutes.venturaRoute : (context) => Ventura(),
        MyRoutes.badmintonRoute : (context) => Badminton(),
        MyRoutes.cricketLeagueRoute : (context) => CricketLeague(),
        MyRoutes.tableTennisRoute : (context) => TableTennis(),
        MyRoutes.volleyballRoute : (context) => Volleyball(),
        MyRoutes.footballRoute : (context) => Football(),

        //Upcoming Events
        MyRoutes.upcomingeventsRoute: (context) => UpcomingEvents(),
        MyRoutes.registercerebroRoute: (context) => Register_Cerebro(),
        MyRoutes.registerkreivaRoute: (context) => Register_Kreiva(),
        MyRoutes.registerventuraRoute: (context) => Register_Ventura()
      },
    );
  }
}