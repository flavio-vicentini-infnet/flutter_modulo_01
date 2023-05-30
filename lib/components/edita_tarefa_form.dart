import 'package:agendador_tarefas_app/provider/tarefas_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/tarefa.dart';

class EditaTarefaForm extends StatefulWidget {
  const EditaTarefaForm({super.key});

  @override
  State<EditaTarefaForm> createState() => _EditaTarefaFormState();
}

class _EditaTarefaFormState extends State<EditaTarefaForm> {
  final _form = GlobalKey<FormState>();

  var nomeController = TextEditingController();
  var diaController = TextEditingController();
  var horaController = TextEditingController();
  var localController = TextEditingController();

  void carregaValores(Tarefa tarefaCarregada) {
    nomeController.text = tarefaCarregada.nome;
    diaController.text = tarefaCarregada.dia;
    horaController.text = tarefaCarregada.hora;
    localController.text = tarefaCarregada.local;
  }

  @override
  Widget build(BuildContext context) {
    final tarefa = ModalRoute.of(context)?.settings.arguments as Tarefa;

    carregaValores(tarefa);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editando Tarefa'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              if (_form.currentState!.validate()) {
                _form.currentState!.save();

                Tarefa novaTarefa = Tarefa(
                  tarefa.id,
                  nomeController.text,
                  diaController.text,
                  horaController.text,
                  localController.text,
                );

                Provider.of<TarefasProvider>(context, listen: false)
                    .update(novaTarefa);

                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.save),
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
                controller: nomeController,
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
                    setState(() async {
                      diaController.text =
                          await DateFormat('dd/MM/yyyy').format(dataUsuario);
                    });
                  }
                },
                controller: diaController,
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
                    setState(() async {
                      horaController.text =
                          await "${horaUsuario.hour.toString().padLeft(2, '0')}:"
                              "${horaUsuario.minute.toString().padLeft(2, '0')}";
                    });
                  }
                },
                controller: horaController,
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
                controller: localController,
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
}
