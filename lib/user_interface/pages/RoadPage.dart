import 'package:front/user_interface/components/ErrorDialog.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../bloc/road_bloc/road_bloc.dart';
import '../../models/City.dart';
import '../../repository/RoadRepository.dart';

class RoadPage extends StatefulWidget {
  const RoadPage({Key? key}) : super(key: key);

  @override
  State<RoadPage> createState() => _RoadPageState();
}

class _RoadPageState extends State<RoadPage> {
  @override
  Widget build(BuildContext context) {
    late City curStartCity;
    late City curEndCity;
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
              child: Text("Расписание", style: TextStyle(color: Colors.white)),
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
              child: Text("Дороги", style: TextStyle(color: Colors.white70)),
            ),
          ],
        ),
        gradient: const LinearGradient(colors: [Color(0xff141414), Color(0xff1e1e1e), Color(0xff282828)]),
      ),
      body: RepositoryProvider(
        create: (context) => RoadRepository(),
        child: BlocProvider<RoadBloc>(
          create: (context) => RoadBloc(
            RepositoryProvider.of<RoadRepository>(context),
          )..add(GetRoadEvent()),
          child: BlocBuilder<RoadBloc, RoadState>(
            builder: (context, state) {
              if (state is RoadLoadedState) {
                List<String> cityList = [];
                if (state.cityList.isNotEmpty) {
                  curStartCity = state.cityList[0];
                  curEndCity = state.cityList[0];
                }
                for (City items in state.cityList) {
                  cityList.add(items.name);
                }
                return Column(
                  children: [
                    cityList.isNotEmpty
                      ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 200,
                          child: DropdownSearch(
                            dropdownSearchDecoration: InputDecoration(labelText: "Пункт отправления"),
                            selectedItem: cityList.first,
                            items: cityList,
                            mode: Mode.MENU,
                            showSearchBox: false,
                            showSelectedItems: true,
                            searchFieldProps: const TextFieldProps(
                              cursorColor: Colors.blue,
                            ),
                            onChanged: (String? value) {
                              curStartCity = state.cityList[cityList.indexOf(value!)];
                            },
                          ),
                        ),
                        Container(
                          width: 200,
                          child: DropdownSearch(
                            dropdownSearchDecoration: InputDecoration(labelText: "Пункт прибытия"),
                            selectedItem: cityList.first,
                            items: cityList,
                            mode: Mode.MENU,
                            showSearchBox: false,
                            showSelectedItems: true,
                            searchFieldProps: const TextFieldProps(
                              cursorColor: Colors.blue,
                            ),
                            onChanged: (String? value) {
                              curEndCity = state.cityList[cityList.indexOf(value!)];
                            },
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (curStartCity.name != curEndCity.name) {
                                BlocProvider.of<RoadBloc>(context)
                                    .add(AddRoadEvent(curStartCity.name, curEndCity.name));
                              }
                              else {
                                ErrorDialog.showAlertDialog(context, "Пункт отправления должен отличаться от пункта прибытия");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orange,
                            ),
                            child: Text("Добавить")
                        ),
                      ],
                    )
                        : Text("Необходимо добавить города"),
                    Divider(),
                    ListView.builder(
                        itemCount: state.roadList.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.all(10),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 1,
                            child: ListTile(
                              title: Row(
                                children: [
                                  Text(state.roadList[index].startCity),
                                  SizedBox(width: 10),
                                  Text("->"),
                                  SizedBox(width: 10),
                                  Text(state.roadList[index].endCity),
                                ],
                              ),
                              leading: Icon(Icons.add_road),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  BlocProvider.of<RoadBloc>(context)
                                      .add(DeleteRoadEvent(state.roadList[index]));
                                },
                              ),
                            ),
                          );
                        }
                    ),
                  ],
                );
              }
              if (state is RoadErrorState) {
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
