import 'package:front/bloc/city_bloc/city_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../repository/CityRepository.dart';

class CityPage extends StatefulWidget {
  const CityPage({Key? key}) : super(key: key);

  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  TextEditingController nameController = TextEditingController();
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
                  Navigator.pushNamedAndRemoveUntil(context, "/bustype", ModalRoute.withName('/'));
                },
                child: Text("Типы автобусов", style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(width: 10),
            Card(
              color: Colors.orange,
              elevation: 1,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, "/bus", ModalRoute.withName('/'));
                },
                child: Text("Автобусы", style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(width: 10),
            Card(
              color: Colors.orange,
              elevation: 1,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, "/city", ModalRoute.withName('/'));
                },
                child: Text("Города", style: TextStyle(color: Colors.white70)),
              ),
            ),
          ],
        ),
        gradient: const LinearGradient(colors: [Color(0xff141414), Color(0xff1e1e1e), Color(0xff282828)]),
      ),
      body: RepositoryProvider(
        create: (context) => CityRepository(),
        child: BlocProvider<CityBloc>(
          create: (context) => CityBloc(
            RepositoryProvider.of<CityRepository>(context),
          )..add(GetCityEvent()),
          child: BlocBuilder<CityBloc, CityState>(
            builder: (context, state) {
              if (state is CityLoadedState) {
                if (state.cityList.isEmpty) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 200,
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Введите название города',
                              ),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<CityBloc>(context)
                                    .add(AddCityEvent(state.cityList.length, nameController.text));
                                nameController.clear();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.orange,
                              ),
                              child: Text("Добавить")
                          ),
                        ],
                      ),
                      Divider(),
                      Center(child: Text("Список городов пуст")),
                    ],
                  );
                }
                else {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 200,
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Введите название города',
                              ),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<CityBloc>(context)
                                    .add(AddCityEvent(state.cityList.length, nameController.text));
                                nameController.clear();
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
                          itemCount: state.cityList.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.all(10),
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              elevation: 1,
                              child: ListTile(
                                leading: Icon(Icons.location_city),
                                title: Text(state.cityList[index].name),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    BlocProvider.of<CityBloc>(context)
                                        .add(DeleteCityEvent(state.cityList[index]));
                                  },
                                ),
                              ),
                            );
                          }
                      ),
                    ],
                  );
                }
              }
              if (state is CityErrorState) {
                return Center(
                  child: Text(state.error),
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
