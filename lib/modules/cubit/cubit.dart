import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/modules/cubit/state.dart';
import 'package:newsapp/modules/newsScreen/newsLayout.dart';
import 'package:newsapp/modules/settingScreen/settingScreen.dart';
import 'package:newsapp/modules/sportsScreen/sportsScreen.dart';
import 'package:newsapp/modules/scienceScreen/scienceScreen.dart';
import 'package:newsapp/modules/businessScreen/businessScreen.dart';
import 'package:newsapp/network/local/cache_helper.dart';
import 'package:newsapp/network/remote/dio_helper.dart';
import 'package:newsapp/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'setting',
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingScreen()
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarStates());
  }

  List<dynamic> business = [];

  void getBusinessData() {
    emit(NewsGetBusinessLoadingStates());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      "country": "eg",
      "category": "business",
      "apiKey": "124403eb963742608ac9cbe096e109f3",
    })!
        .then((value) {
      business = value.data["articles"];
      emit(NewsGetBusinessSuccessStates());
    }).catchError((error) {
      emit(NewsGetBusinessErrorStates(error));
    });
  }

  List<dynamic> sports = [];

  void getSportsData() {
    emit(NewsGetSportsLoadingStates());

    DioHelper.getData(url: 'v2/top-headlines', query: {
      "country": "eg",
      "category": "Sports",
      "apiKey": "124403eb963742608ac9cbe096e109f3",
    })!
        .then((value) {
      sports = value.data["articles"];
      emit(NewsGetSportsSuccessStates());
    }).catchError((error) {
      emit(NewsGetSportsErrorStates(error));
    });
  }

  List<dynamic> science = [];

  void getScienceData() {
    emit(NewsGetScienceLoadingStates());

    DioHelper.getData(url: 'v2/top-headlines', query: {
      "country": "eg",
      "category": "science",
      "apiKey": "124403eb963742608ac9cbe096e109f3",
    })!
        .then((value) {
      science = value.data["articles"];
      emit(NewsGetScienceSuccessStates());
    }).catchError((error) {
      emit(NewsGetScienceErrorStates(error));
    });
  }

  bool isDark = false;

  void changeThemeColor({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(NewsChangeThemeColorStates());
    } else {
      isDark = !isDark;
      CacheHelper.setBoolean(key: 'isDark', value: isDark).then((value) {
        emit(NewsChangeThemeColorStates());
      }).catchError((onError) {
        print(onError.toString());
      });
    }
  }

  // https://newsapi.org/
  // v2/everything?
  // q=bitcoin&
  // apiKey=124403eb963742608ac9cbe096e109f3

  // DioHelper.getData(url: 'v2/top-headlines', query: {
  // "country": "eg",
  // "category": "business",
  // "apiKey": "124403eb963742608ac9cbe096e109f3",
  // })

  List<dynamic> search = [];

  void getSearchData(String searchText) {
    emit(NewsGetSearchLoadingStates());
    DioHelper.getData(url: 'v2/everything', query: {
      "q": "$searchText",
      "apiKey": "124403eb963742608ac9cbe096e109f3",
    })!
        .then((value) {
      // List search = value.data["articles"];
      search = value.data["articles"];

      print(search[0]['title']);
      emit(NewsGetSearchSuccessStates());
    }).catchError((onError) {
      emit(NewsGetSearchErrorStates(onError));
    });
  }
}
