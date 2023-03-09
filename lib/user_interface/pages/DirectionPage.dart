import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/models/ReceivedStudent.dart';
import 'package:front/repository/DirectionRepository.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../bloc/direction_bloc/direction_bloc.dart';

class DirectionPage extends StatefulWidget {
  const DirectionPage({Key? key}) : super(key: key);

  @override
  State<DirectionPage> createState() => _DirectionPageState();
}

class _DirectionPageState extends State<DirectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Row(
          children: [
            Icon(Icons.departure_board, color: Colors.orange,),
            SizedBox(width: 5,),
            Text("BusSchedule", style: TextStyle(color: Colors.white)),
            SizedBox(width: 15,),
            Card(
              color: Colors.orange,
              elevation: 1,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, "/students", ModalRoute.withName('/'));
                },
                child: Text("Студенты", style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(width: 10),
            Card(
              color: Colors.orange,
              elevation: 1,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, "/direction", ModalRoute.withName('/'));
                },
                child: Text("Направления", style: TextStyle(color: Colors.white70)),
              ),
            ),
            SizedBox(width: 10),
            Card(
              color: Colors.orange,
              elevation: 1,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, "/subject", ModalRoute.withName('/'));
                },
                child: Text("Предметы", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
        gradient: const LinearGradient(colors: [Color(0xff141414), Color(0xff1e1e1e), Color(0xff282828)]),
      ),
      body: RepositoryProvider(
          create: (context) => DirectionRepository(),
          child: BlocProvider<DirectionBloc>(
              create: (context) => DirectionBloc(
                RepositoryProvider.of<DirectionRepository>(context),
              )..add(DirectionGetEvent()),
              child: BlocBuilder<DirectionBloc, DirectionState>(
                  builder: (context, state) {
                    if (state is DirectionErrorState) {
                      return Container(
                        child: Text("Ошибка"),
                      );
                    }
                    if (state is DirectionLoadedState) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.only(bottom: 10, top: 10, left: 40, right: 40),
                              itemCount: state.directionList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  child: ListTile(
                                    title: Column(
                                      children: [
                                        Align(child: Text("${state.directionList[index].name}",style: TextStyle(fontWeight: FontWeight.bold)), alignment: Alignment.centerLeft,),
                                        Align(child: Text("Количество мест: ${state.directionList[index].studentCount}"), alignment: Alignment.centerLeft,),
                                        Divider(),
                                        Align(child: Text("Необходимо баллов:"), alignment: Alignment.centerLeft,),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: state.directionList[index].requireList.length,
                                            itemBuilder: (BuildContext context, int index1) {
                                              return Column(
                                                children: [
                                                  Align(child: Text("${state.directionList[index].requireList[index1].subject.name}: ${state.directionList[index].requireList[index1].minPoint}"), alignment: Alignment.centerLeft,)
                                                ],
                                              );
                                            }
                                        ),
                                        Divider(),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: state.directionList[index].receivedStudents.length,
                                          itemBuilder: (BuildContext context, int index2) {
                                            return ListTile(
                                              leading: Icon(Icons.person),
                                              title: Text(state.directionList[index].receivedStudents[index2].fio),
                                            );
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.person_add),
                                          title: Text("Добавить студента"),
                                          onTap: () {
                                            addAlertDialog(context, state.receivedStudent, state.directionList[index].id);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),

                          ],
                        ),
                      );
                    }
                    return Container();
                  },
              )
          ),
      ),
    );
  }
}
addAlertDialog(BuildContext context, List<ReceivedStudent> studentList, int directionId) {
  List<String> valueList = [];
  for (ReceivedStudent item in  studentList) {
    valueList.add(item.fio);
  }
  String currentValue = valueList.first;
  int getId(String value) {
    int result = 1;
    for (ReceivedStudent item in studentList) {
      if (value == item.fio) {
        result = item.id;
      }
    }
    return result;
  }
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      BlocProvider.of<DirectionBloc>(context)
          .add(DirectionAddEvent(getId(currentValue), directionId));
      Navigator.pop(context);
    },
  );
  Widget closeButton = TextButton(
    child: Text("Отмена"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Добавить студента"),
    content: DropdownSearch(
      dropdownSearchDecoration: InputDecoration(
        labelText: "Студент",
      ),
      mode: Mode.MENU,
      selectedItem: currentValue,
      showSelectedItems: false,
      onChanged: (value) {
        currentValue = value!;
      },
      items: valueList,
      searchFieldProps: const TextFieldProps(
        cursorColor: Colors.blue,
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            closeButton,
            okButton,
          ],
        ),
      ),
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
