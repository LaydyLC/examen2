import 'package:tres_en_raya/bloc/resultado/partida_bloc.dart';
import 'package:tres_en_raya/utilities/TabItem.dart';
import 'package:tres_en_raya/repository/ResultadoRepository.dart';
import 'package:tres_en_raya/views/tic_tac_toe/tic_tac_form.dart';
import 'package:flutter/material.dart';
import 'package:tres_en_raya/models/PartidaModelo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:tres_en_raya/theme/AppTheme.dart';
import '../help_screen.dart';

class MainResultado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => PartidaBloc(partidaRepository: PartidaRepository())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: AppTheme.useLightMode ? ThemeMode.light : ThemeMode.dark,
        theme: AppTheme.themeData,
        //theme: ThemeData(primaryColor: Colors.lightBlue),
        home: ResultadoUI2(),
      ),
    );
  }
}

class ResultadoUI2 extends StatefulWidget {
  @override
  _ResultadoUIState createState() => _ResultadoUIState();
}

final tabs = ['Home', 'Profile', 'Help', 'Settings'];

class _ResultadoUIState extends State<ResultadoUI2> {
//ApiCovid apiService;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  var api;
  @override
  void initState() {
    super.initState();
//apiService = ApiCovid();
//api=Provider.of<PredictionApi>(context, listen: false).getPrediction();
    print("entro aqui");
  }

  Future onGoBack(dynamic value) {
    setState(() {
      print(value);
    });
  }

  void accion() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PartidaBloc>(context).add(ListarPartidaEvent());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: AppTheme.useLightMode ? ThemeMode.light : ThemeMode.dark,
      theme: AppTheme.themeData,
      home: Scaffold(
        appBar: new AppBar(
          title: Text(
            'Lista de Personas',
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  print("Si funciona");
                },
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  //final producto=new ModeloProductos();
                  //formDialog(context, producto);
                  print("Si funciona 2");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PartidaForm()),
                  ).then(onGoBack);
                },
                child: Icon(Icons.add_box_sharp),
              ),
            )
          ],
        ),

        //backgroundColor: AppTheme.nearlyWhite,
        body: BlocBuilder<PartidaBloc, PartidaState>(builder: (context, state) {
          if (state is PartidaLoadedState) {
            return _buildListView(state.partidaList);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
        bottomNavigationBar: _buildBottomTab(),
      ),
    );
  }

  Widget _buildListView(List<PartidaModelo> partida) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          PartidaModelo partidax = partida[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                        title: Text(partidax.nombre_partida,
                            style: Theme.of(context).textTheme.headline6),
                        subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "ganador: " + partidax.ganador,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ]),
                        trailing: Row(mainAxisSize: MainAxisSize.min,
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.delete),
                                  color: AppTheme.themeData.colorScheme.error,
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                                Text("Mensaje de confirmacion"),
                                            content: Text("Desea Eliminar?"),
                                            actions: [
                                              FloatingActionButton(
                                                child: const Text('CANCEL'),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop('Failure');
                                                },
                                              ),
                                              FloatingActionButton(
                                                  child: const Text('ACCEPT'),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop('Success');
                                                  })
                                            ],
                                          );
                                        }).then((value) {
                                      if (value.toString() == "Success") {
                                        print(partidax.id);
                                        BlocProvider.of<PartidaBloc>(context)
                                            .add(DeletePartidaEvent(
                                                partida: partidax));
                                      }
                                    });
                                  })
                            ])),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: partida.length,
      ),
    );
  }

  int selectedPosition = 0;
  _buildBottomTab() {
    return BottomAppBar(
      color: AppTheme.themeData.colorScheme.primary,
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TabItem(
            text: tabs[0],
            icon: Icons.home,
            isSelected: selectedPosition == 0,
            onTap: () {
              setState(() {
                selectedPosition = 0;
              });
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return HelpScreen();
              }));
            },
          ),
          TabItem(
            text: tabs[1],
            icon: Icons.person,
            isSelected: selectedPosition == 1,
            onTap: () {
              setState(() {
                selectedPosition = 1;
              });
            },
          ),
          SizedBox(
            width: 48,
          ),
          TabItem(
            text: tabs[2],
            icon: Icons.help,
            isSelected: selectedPosition == 2,
            onTap: () {
              setState(() {
                selectedPosition = 2;
              });
            },
          ),
          TabItem(
            text: tabs[3],
            icon: Icons.settings,
            isSelected: selectedPosition == 3,
            onTap: () {
              setState(() {
                selectedPosition = 3;
              });
            },
          ),
        ],
      ),
    );
  }
}
