import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/bloc/bustype_bloc/bus_type_bloc.dart';
import 'package:front/repository/BusTypeRepository.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusTypePage extends StatefulWidget {
  const BusTypePage({Key? key}) : super(key: key);

  @override
  State<BusTypePage> createState() => _BusTypePageState();
}

class _BusTypePageState extends State<BusTypePage> {
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
                child: Text("Типы автобусов", style: TextStyle(color: Colors.white70)),
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
                  Navigator.pushNamedAndRemoveUntil(context, "/cities", ModalRoute.withName('/'));
                },
                child: Text("Города", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
        gradient: const LinearGradient(colors: [Color(0xff141414), Color(0xff1e1e1e), Color(0xff282828)]),
      ),
      body: RepositoryProvider(
        create: (context) => BusTypeRepository(),
        child: BlocProvider<BusTypeBloc>(
          create: (context) => BusTypeBloc(
            RepositoryProvider.of<BusTypeRepository>(context),
          )..add(BusTypeGetEvent()),
          child: BlocBuilder<BusTypeBloc, BusTypeState>(
            builder: (context, state) {
              if (state is BusTypeLoadedState) {
                if (state.listBusType.isNotEmpty)
                  {
                    return ListView.builder(
                        itemCount: state.listBusType.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.all(10),
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(state.listBusType[index].type),
                          );
                        }
                    );
                  }
                else {
                  return Text("Типы автобусов отсутствуют");
                }

              }
              if (state is BusTypeErrorState) {
                return Center(child: Text(state.error));
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
