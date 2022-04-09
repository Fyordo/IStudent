import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../bloc/header_lectures/header_lectures_bloc.dart';

class LessonsTableList extends StatelessWidget {
  const LessonsTableList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String token = Hive.box('tokenbox').get('token');
    print("Token в header_lectures: " + token);

    return BlocProvider<HeaderLecturesBloc>(
      create: (context) {
        return HeaderLecturesBloc(HeaderLecturesStateWithoutData())
          ..add(HeaderLecturesEventWithData(token: token));
      },
      child: BlocConsumer<HeaderLecturesBloc, HeaderLecturesState>(
        listener: (context, state) {
          if (state is HeaderLecturesStateWithData) {
            print(state.lessons);
          }
        },
        builder: (context, state) {
          if (state is HeaderLecturesStateWithData) {
            return Container(
              margin: EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 0,
              ),
              height: 170.0,
              child: Container(
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.lessons.length,
                  itemBuilder: (BuildContext context, int index) => Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 5,
                      right: 5,
                    ),
                    width: 300,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 5, bottom: 10),
                                height: 23,
                                child: Text(
                                  state.lessons[index].title,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                )),
                            Card(
                              color: Theme.of(context).secondaryHeaderColor,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Container(
                                  height: 20,
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    "Ведёт: ${state.lessons[index].teacher.name}",
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Theme.of(context).cardColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 5, top: 10),
                                child: Text(
                                  'Проходит в: ${(state.lessons[index].location == "" ? "<не указано>" : state.lessons[index].location)}',
                                  style: TextStyle(
                                      color: Theme.of(context).highlightColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                )),
                            Container(
                                margin: EdgeInsets.only(left: 5, top: 5),
                                child: Text(
                                  'Время: ${state.lessons[index].start()} - ${state.lessons[index].end()}',
                                  style: TextStyle(
                                      color: Theme.of(context).highlightColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else if (state is HeaderLecturesStateWithoutData) {
            return Container(
              margin: EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 0,
              ),
              height: 170.0,
              child: Container(
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) => Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 5,
                      right: 5,
                    ),
                    width: 300,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 5, bottom: 10),
                                child: Text(
                                  'Загрузка...',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                )),
                            Card(
                              color: Theme.of(context).secondaryHeaderColor,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'Загрузка...',
                                    style: TextStyle(
                                        color: Theme.of(context).cardColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 5, top: 10),
                                child: Text(
                                  'Загрузка...',
                                  style: TextStyle(
                                      color: Theme.of(context).highlightColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                )),
                            Container(
                                margin: EdgeInsets.only(left: 5, top: 5),
                                child: Text(
                                  'Загрузка...',
                                  style: TextStyle(
                                      color: Theme.of(context).highlightColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else
            return Text("Error");
        },
      ),
    );
  }
}
