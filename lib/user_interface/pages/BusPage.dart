import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bus_bloc/bus_bloc.dart';
import '../../models/BusType.dart';
import '../../repository/BusRepository.dart';
import 'package:dropdown_search/dropdown_search.dart';

class BusPage extends StatefulWidget {
  const BusPage({Key? key}) : super(key: key);

  @override
  State<BusPage> createState() => _BusPageState();
}

class _BusPageState extends State<BusPage> {
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    BusType curBusType;
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
                child: Text("Автобусы", style: TextStyle(color: Colors.white70)),
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
                child: Text("Города", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
        gradient: const LinearGradient(colors: [Color(0xff141414), Color(0xff1e1e1e), Color(0xff282828)]),
      ),
      body: RepositoryProvider(
        create: (context) => BusRepository(),
        child: BlocProvider<BusBloc>(
          create: (context) => BusBloc(
            RepositoryProvider.of<BusRepository>(context),
          )..add(GetBusEvent()),
          child: BlocBuilder<BusBloc, BusState>(
            builder: (context, state) {
              if (state is BusLoadedState) {
                List<String> typeList = [];
                curBusType = state.busTypeList[0];
                for (BusType items in state.busTypeList) {
                  typeList.add(items.type);
                }
                return Column(
                  children: [
                    typeList.isNotEmpty
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 200,
                          child: DropdownSearch(
                            dropdownSearchDecoration: InputDecoration(labelText: "Тип автобуса"),
                            selectedItem: typeList.first,
                            items: typeList,
                            mode: Mode.MENU,
                            showSearchBox: false,
                            showSelectedItems: true,
                            searchFieldProps: const TextFieldProps(
                              cursorColor: Colors.blue,
                            ),
                            onChanged: (String? value) {
                              curBusType = state.busTypeList[typeList.indexOf(value!)];
                            },
                          ),
                        ),
                        Container(
                          width: 200,
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Введите номер автобуса',
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<BusBloc>(context)
                                  .add(AddBusEvent(curBusType.type, nameController.text));
                              nameController.clear();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orange,
                            ),
                            child: Text("Добавить")
                        ),
                      ],
                    )
                    : Text("Необходимо добавить типы автобусов"),
                    Divider(),
                    ListView.builder(
                        itemCount: state.busList.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.all(10),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 1,
                            child: ListTile(
                              leading: Icon(Icons.bus_alert),
                              title: Text(state.busList[index].number),
                              subtitle: Text(state.busList[index].busType),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  BlocProvider.of<BusBloc>(context)
                                      .add(DeleteBusEvent(state.busList[index]));
                                },
                              ),
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
