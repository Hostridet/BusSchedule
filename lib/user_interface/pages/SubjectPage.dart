import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/repository/SubjectRepository.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../bloc/subject_bloc/subject_bloc.dart';

class SubjectPage extends StatefulWidget {
  const SubjectPage({Key? key}) : super(key: key);

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  TextEditingController _textEditingController = TextEditingController();
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
                child: Text("Направления", style: TextStyle(color: Colors.white)),
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
                child: Text("Предметы", style: TextStyle(color: Colors.white70)),
              ),
            ),
          ],
        ),
        gradient: const LinearGradient(colors: [Color(0xff141414), Color(0xff1e1e1e), Color(0xff282828)]),
      ),
      body: RepositoryProvider(
          create: (context) => SubjectRepository(),
          child: BlocProvider<SubjectBloc>(
              create: (context) => SubjectBloc(
                RepositoryProvider.of<SubjectRepository>(context),
              )..add(SubjectGetEvent()),
              child: BlocBuilder<SubjectBloc, SubjectState>(
                  builder: (context, state) {
                    if (state is SubjectErrorState) {
                      return Container(
                        child: Text(state.error),
                      );
                    }
                    if (state is SubjectLoadedState) {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 10, top: 10, left: 40, right: 40),
                            child: Card(
                              elevation: 2,
                              child: ListTile(
                                leading: Icon(Icons.add),
                                title: Text("Добавить новый предмет"),
                                onTap: () {
                                  showAlertDialog(context, _textEditingController);
                                  // BlocProvider.of<SubjectBloc>(context)
                                  //     .add(SubjectAddEvent("Физика"));
                                },
                              ),
                            ),
                          ),
                          Divider(indent: 40, endIndent: 40),
                          ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.only(bottom: 10, top: 10, left: 40, right: 40),
                              itemCount: state.subjectList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  elevation: 1,
                                  child: ListTile(
                                    leading: Icon(Icons.subject_sharp),
                                    title: Text(state.subjectList[index].name),
                                    onTap: () {
                                      showAlertDialogDelete(context, state.subjectList[index].id);
                                    },
                                  ),
                                );
                              }
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
              ),
          ),
      ),
    );
  }
}
showAlertDialog(BuildContext context, TextEditingController textEditingController) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      BlocProvider.of<SubjectBloc>(context)
          .add(SubjectAddEvent(textEditingController.text));
      textEditingController.clear();
      Navigator.pop(context);
    },
  );
  Widget closeButton = TextButton(
    onPressed: () {
      textEditingController.clear();
      Navigator.pop(context);
    },
    child: Text("Закрыть"),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Добавить предмет"),
    content: TextField(
      onChanged: (_) {},
      controller: textEditingController,
      decoration: InputDecoration(hintText: "Название предмета"),
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

showAlertDialogDelete(BuildContext context, int id) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("Да"),
    onPressed: () {
      BlocProvider.of<SubjectBloc>(context)
          .add(SubjectDeleteEvent(id));
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
    title: Text("Удаление предмета"),
    content: Text("Вы уверены, что хотите удалить?"),
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
