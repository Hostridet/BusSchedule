import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/repository/StudentRepository.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../bloc/student_bloc/student_bloc.dart';
import '../../models/Result.dart';
import '../../models/Subject.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({Key? key}) : super(key: key);

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  TextEditingController fioController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController subjectController = TextEditingController();

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
                child: Text("Студенты", style: TextStyle(color: Colors.white70)),
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
                child: Text("Предметы", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
        gradient: const LinearGradient(colors: [Color(0xff141414), Color(0xff1e1e1e), Color(0xff282828)]),
      ),
      body: Container(
        child: RepositoryProvider(
            create: (context) => StudentRepository(),
            child: BlocProvider<StudentBloc>(
                create: (context) => StudentBloc(
                  RepositoryProvider.of<StudentRepository>(context),
                )..add(StudentGetEvent()),
                child: BlocBuilder<StudentBloc, StudentState>(
                    builder: (context, state) {
                      if (state is StudentLoadedState) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 10, top: 10, left: 40, right: 40),
                                child: Card(
                                  child: ListTile(
                                    leading: Icon(Icons.add),
                                    title: Text("Добавить нового студента"),
                                    onTap: () {
                                      showAlertDialog(context, fioController, ageController);
                                    },
                                  ),
                                ),
                              ),
                              Divider(indent: 40, endIndent: 40),
                              ListView.builder(
                                padding: EdgeInsets.only(bottom: 10, top: 10, left: 40, right: 40),
                                shrinkWrap: true,
                                itemCount: state.studentList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    child: ListTile(
                                      leading: Icon(Icons.person),
                                      title: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: Align(child: Text('${state.studentList[index].fio} ${state.studentList[index].age.toString()} лет'), alignment: Alignment.centerLeft,),
                                          ),
                                          Divider(),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: TextButton(
                                              onPressed: () {
                                                addAlertDialog(context, state.subjectList, subjectController, state.studentList[index].id);
                                              },
                                              child: Text("Добавить результат"),
                                            ),
                                          ),
                                          ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: state.studentList[index].resultList.length,
                                            itemBuilder: (BuildContext context, int index2) {
                                              return Padding(
                                                padding: const EdgeInsets.only(left: 8.0),
                                                child: Row(
                                                  children: [
                                                    Text("${state.studentList[index].resultList[index2].subject.name}:"),
                                                    SizedBox(width: 5,),
                                                    Text("${state.studentList[index].resultList[index2].result.toString()} б."),
                                                  ],
                                                ),
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                      
                                    ),
                                  );
                                }
                              ),
                            ],
                          ),
                        );
                      }
                      return Container();
                    },
                ),
            ),
        ),
      ),
    );
  }
}

addAlertDialog(BuildContext context, List<Subject> subjectList, TextEditingController subjectController, int studentId) {
  List<String> valueList = [];
  for (Subject item in  subjectList) {
    valueList.add(item.name);
  }
  String currentValue = valueList.first;
  int getId(String value) {
    int result = 1;
    for (Subject item in subjectList) {
      if (value == item.name) {
        result = item.id;
      }
    }
    return result;
  }
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      BlocProvider.of<StudentBloc>(context)
          .add(StudentAddSubjectEvent(studentId, getId(currentValue), int.parse(subjectController.text)));
      subjectController.clear();
      Navigator.pop(context);
    },
  );
  Widget closeButton = TextButton(
    child: Text("Отмена"),
    onPressed: () {
      subjectController.clear();
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Добавить результат"),
    content: Column(
      children: [
        DropdownSearch(
          dropdownSearchDecoration: InputDecoration(
            labelText: "Предмет",
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
        TextField(
          onChanged: (_) {},
          controller: subjectController,
          decoration: InputDecoration(hintText: "Количество баллов"),
        ),
      ],
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

showAlertDialog(BuildContext context, TextEditingController fioController, TextEditingController ageController) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      BlocProvider.of<StudentBloc>(context)
          .add(StudentAddEvent(fioController.text, int.parse(ageController.text)));
      fioController.clear();
      ageController.clear();
      Navigator.pop(context);
    },
  );
  Widget closeButton = TextButton(
    onPressed: () {
      fioController.clear();
      ageController.clear();
      Navigator.pop(context);
    },
    child: Text("Закрыть"),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Добавить студента"),
    content: Column(
      children: [
        TextField(
          onChanged: (_) {},
          controller: fioController,
          decoration: InputDecoration(hintText: "ФИО"),
        ),
        TextField(
          onChanged: (_) {},
          controller: ageController,
          decoration: InputDecoration(hintText: "Возраст"),
        ),
      ],
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