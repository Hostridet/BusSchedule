import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../bloc/schedule_bloc/schedule_bloc.dart';
import '../../models/Bus.dart';
import '../../models/Road.dart';
import '../../repository/ScheduleRepository.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  TextEditingController costController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    late Bus curBus;
    late Road curRoad;
    return Scaffold(
      appBar: NewGradientAppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Icon(Icons.departure_board, color: Colors.orange,),
            SizedBox(width: 5,),
            Text("BusSchedule", style: TextStyle(color: Colors.white)),
            SizedBox(width: 15,),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, "/schedule", ModalRoute.withName('/'));
              },
              child: Text("Расписание", style: TextStyle(color: Colors.white70)),
            ),
            SizedBox(width: 10),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, "/bustype", ModalRoute.withName('/'));
              },
              child: Text("Типы автобусов", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(width: 10),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, "/bus", ModalRoute.withName('/'));
              },
              child: Text("Автобусы", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(width: 10),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, "/city", ModalRoute.withName('/'));
              },
              child: Text("Города", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(width: 10),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, "/road", ModalRoute.withName('/'));
              },
              child: Text("Дороги", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        gradient: const LinearGradient(colors: [Color(0xff141414), Color(0xff1e1e1e), Color(0xff282828)]),
      ),
      body: RepositoryProvider(
        create: (context) => ScheduleRepository(),
        child: BlocProvider<ScheduleBloc>(
          create: (context) => ScheduleBloc(
            RepositoryProvider.of<ScheduleRepository>(context),
          )..add(GetScheduleEvent()),
          child: BlocBuilder<ScheduleBloc, ScheduleState>(
              builder: (context, state) {
                if (state is ScheduleLoadedState) {
                  if (state.roadList.isEmpty || state.busList.isEmpty) {
                    return Center(child: Text("Необходимо добавить дороги и автобусы"));
                  }
                  else {
                    List<String> roadList = [];
                    List<String> busList = [];
                    for (Road items in state.roadList) {
                      roadList.add("${items.startCity} -> ${items.endCity}");
                    }
                    for (Bus items in state.busList) {
                      busList.add(items.busType);
                    }
                    curBus = state.busList[0];
                    curRoad = state.roadList[0];
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 200,
                              child: DropdownSearch(
                                dropdownSearchDecoration: InputDecoration(labelText: "Автобус"),
                                selectedItem: busList.first,
                                items: busList,
                                mode: Mode.MENU,
                                showSearchBox: false,
                                showSelectedItems: true,
                                searchFieldProps: const TextFieldProps(
                                  cursorColor: Colors.blue,
                                ),
                                onChanged: (String? value) {
                                  curBus = state.busList[busList.indexOf(value!)];
                                },
                              ),
                            ),
                            Container(
                              width: 200,
                              child: DropdownSearch(
                                dropdownSearchDecoration: InputDecoration(labelText: "Дорога"),
                                selectedItem: roadList.first,
                                items: roadList,
                                mode: Mode.MENU,
                                showSearchBox: false,
                                showSelectedItems: true,
                                searchFieldProps: const TextFieldProps(
                                  cursorColor: Colors.blue,
                                ),
                                onChanged: (String? value) {
                                  curRoad = state.roadList[roadList.indexOf(value!)];
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              width: 200,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: costController,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Стоимость проезда',
                                ),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<ScheduleBloc>(context)
                                      .add(AddScheduleEvent(curBus.busType, "${curRoad.startCity} -> ${curRoad.endCity}", int.parse(costController.text), "", ""));
                                  costController.clear();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.orange,
                                ),
                                child: Text("Добавить")
                            ),
                          ],
                        ),
                        Divider(),
                        ListView.builder(
                            itemCount: state.scheduleList.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.all(10),
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                elevation: 1,
                                child: ListTile(
                                  title: Column(
                                    children: [
                                      Align(
                                          child: Text("Направление: ${state.scheduleList[index].road}"),
                                          alignment: Alignment.topLeft,
                                      ),
                                      Align(
                                          child: Text("Номер автобуса: ${state.scheduleList[index].bus}"),
                                          alignment: Alignment.topLeft,
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                  subtitle: Column(
                                    children: [
                                      Align(
                                          child: Text("Время отправления: ${state.scheduleList[index].startTime}"),
                                          alignment:  Alignment.topLeft,
                                      ),
                                      Align(
                                          child: Text("Время прибытия: ${state.scheduleList[index].endTime}"),
                                          alignment: Alignment.topLeft,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                        ),
                      ],
                    );
                  }
                }
                if (state is ScheduleErrorState) {
                  return Center(child: Text(state.error));
                }
                return Container();
              }
          ),
        ),
      ),
    );
  }
}
