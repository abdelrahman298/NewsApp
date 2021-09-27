import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/modules/cubit/cubit.dart';
import 'package:newsapp/modules/cubit/state.dart';
import 'package:newsapp/network/local/cache_helper.dart';
import 'package:newsapp/network/remote/dio_helper.dart';
import 'modules/constant/constant.dart';
import 'modules/newsScreen/newsLayout.dart';
import 'modules/scienceScreen/scienceScreen.dart';
import 'network/remote/dio_helper.dart';
import 'network/remote/dio_helper.dart';
import 'package:hexcolor/hexcolor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final bool? isDark;

  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()
        ..getBusinessData()
        ..getSportsData()
        ..getScienceData()
        ..changeThemeColor(fromShared: isDark),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, states) {},
        builder: (context, states) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                elevation: 0.0,
                backgroundColor: Colors.white,
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                showUnselectedLabels: true,
                unselectedItemColor: Colors.black,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: HexColor("333739"),
              appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                elevation: 0.0,
                backgroundColor: HexColor("333739"),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                backgroundColor: HexColor("333739"),
                selectedItemColor: Colors.deepOrange,
                elevation: 20.0,
                showUnselectedLabels: true,
                unselectedItemColor: Colors.grey,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // themeMode: ThemeMode.light,
            themeMode: NewsCubit.get(context).isDark
                ? ThemeMode.light
                : ThemeMode.dark,
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}
