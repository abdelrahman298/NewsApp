import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:newsapp/modules/web_View/web_view_screen.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}

Widget buildArticleItem(article, context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebViewScreen(article['url'])));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(
                  '${article['urlToImage']}',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      // style: TextStyle(fontSize: 25.0),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget articleBuilder(list, context, {isSearch = false}) => Conditional.single(
      context: context,
      conditionBuilder: (BuildContext context) => list.length > 0,
      widgetBuilder: (BuildContext context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return buildArticleItem(list[index], context);
        },
        separatorBuilder: (BuildContext context, int index) => Container(
          height: .5,
          color: Colors.grey[100],
        ),
        itemCount: list.length,
      ),
      fallbackBuilder: (BuildContext context) => isSearch
          ? Container()
          : Center(
              child: CircularProgressIndicator(),
            ),
    );

class TextFormDefault extends StatelessWidget {
  TextFormDefault(
      {this.controller,
      this.onChanged,
      this.validate,
      required this.type,
      required String label,
      this.onField});

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function? onField;

  final String? Function(String?)? validate;
  final TextInputType type;
  // var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // key: formKey,
      keyboardType: type,
      controller: controller,

      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search_outlined),
        labelText: 'search',
        border: OutlineInputBorder(),
        hintText: 'Enter a search term',
      ),
      // onChanged: (value) {
      //   onChanged!(value);
      // },
      onFieldSubmitted: (value) {
        onField!(value);
      },
      validator: validate,
    );
  }
}

// https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=124403eb963742608ac9cbe096e109f3

//baseUrl:  https://newsapi.org/
// method(url) :v2/top-headlines?
// queries: country=eg&category=business&apiKey=124403eb963742608ac9cbe096e109f3

// https://newsapi.org/v2/everything?q=bitcoin&apiKey=124403eb963742608ac9cbe096e109f3
