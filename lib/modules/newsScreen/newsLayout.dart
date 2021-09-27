import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/main.dart';
import 'package:newsapp/modules/cubit/cubit.dart';
import 'package:newsapp/modules/cubit/state.dart';
import 'package:newsapp/network/remote/dio_helper.dart';
import 'package:newsapp/modules/searchScreen/searchScreen.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, states) => {},
        builder: (context, states) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'News App',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 20.0,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchScreen()));
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.brightness_4_outlined,
                    size: 20.0,
                  ),
                  onPressed: () {
                    cubit.changeThemeColor();
                  },
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              items: cubit.bottomItems,
              onTap: (int index) {
                cubit.changeBottomNavBar(index);
              },
              elevation: 20.0,
            ),
          );
        });
  }
}
