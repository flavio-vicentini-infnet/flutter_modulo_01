import 'package:agendador_tarefas_app/provider/tarefas_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../models/tarefa.dart';

class TarefaForm extends StatefulWidget {
  const TarefaForm({super.key});

  @override
  State<TarefaForm> createState() => _TarefaFormState();
}

class _TarefaFormState extends State<TarefaForm> {
  final _form = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _diaController = TextEditingController();
  final _horaController = TextEditingController();
  final _localController = TextEditingController();

  @override
  initState() {
    super.initState();

    getLocation().then((location) => {
          setState(() {
            _localController.text = location;
          })
        });
  }

  void mostraInfoLocalidade() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Local da Tarefa'),
          content: const Text(
            "Será inserido de forma automática pelo App a sua latitude e longitude atual sua. Entretanto você pode apagar essa informação e inserir o dado de seu agrado. Ex: Casa, Av. Goethe.",
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Tarefa'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              if (_form.currentState!.validate()) {
                _form.currentState!.save();

                Tarefa novaTarefa = Tarefa.semId(
                  nome: _nomeController.text,
                  dia: _diaController.text,
                  hora: _horaController.text,
                  local: _localController.text,
                );

                Tarefa.incrementId();

                Provider.of<TarefasProvider>(context, listen: false)
                    .insert(novaTarefa);

                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.save),
          ),
          IconButton(
            onPressed: () {
              mostraInfoLocalidade();
            },
            icon: const Icon(Icons.help),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome da Tarefa',
                  icon: Icon(Icons.work),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor preencha o campo';
                  }
                  return null;
                },
              ),
              TextFormField(
                onTap: () async {
                  DateTime? dataUsuario = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2025),
                  );

                  if (dataUsuario != null) {
                    setState(() {
                      _diaController.text =
                          DateFormat('dd/MM/yyyy').format(dataUsuario);
                    });
                  }
                },
                controller: _diaController,
                decoration: const InputDecoration(
                  labelText: 'Dia',
                  icon: Icon(Icons.calendar_month_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor preencha o campo';
                  }
                  return null;
                },
              ),
              TextFormField(
                onTap: () async {
                  TimeOfDay? horaUsuario = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  if (horaUsuario != null) {
                    setState(() {
                      _horaController.text =
                          "${horaUsuario.hour.toString().padLeft(2, '0')}:"
                          "${horaUsuario.minute.toString().padLeft(2, '0')}";
                    });
                  }
                },
                controller: _horaController,
                decoration: const InputDecoration(
                  labelText: 'Horário',
                  icon: Icon(Icons.alarm),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor preencha o campo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _localController,
                decoration: const InputDecoration(
                  labelText: 'Local',
                  icon: Icon(Icons.location_on),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor preencha o campo';
                  }
                  return null;
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        Future.value("");
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        Future.value("");
      }
    }

    _locationData = await location.getLocation();

    return "${_locationData.latitude} : ${_locationData.longitude}";
  }
}
