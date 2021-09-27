import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/modules/constant/constant.dart';
import 'package:newsapp/modules/cubit/cubit.dart';
import 'package:newsapp/modules/cubit/state.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var searchList = NewsCubit.get(context).search;

        return Scaffold(
          appBar: AppBar(
            title: Center(
                child: Text(
              'Search Screen',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            )),
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: TextFormDefault(
                  controller: searchController,
                  type: TextInputType.text,
                  label: 'Search',
                  // onChanged: (value) {
                  //   NewsCubit.get(context).getSearchData(value);
                  //   print(value.toString());
                  // },
                  onField: (value) {
                    NewsCubit.get(context).getSearchData(value);
                    print(value.toString());
                  },
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Text Should be written';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Expanded(
                child: articleBuilder(searchList, context, isSearch: true),
              ),
            ],
          ),
        );
      },
    );
  }
}
