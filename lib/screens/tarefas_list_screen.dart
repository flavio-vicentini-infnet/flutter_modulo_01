import 'package:agendador_tarefas_app/components/tarefa_tile.dart';
import 'package:agendador_tarefas_app/provider/tarefas_provider.dart';
import 'package:agendador_tarefas_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TarefasListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TarefasProvider tarefasProvider = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Tarefas"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.TAREFA_FORM);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: tarefasProvider.count,
        itemBuilder: (context, index) => TarefaTile(tarefasProvider.tarefaById(index)),
      ),
    );
  }
}
