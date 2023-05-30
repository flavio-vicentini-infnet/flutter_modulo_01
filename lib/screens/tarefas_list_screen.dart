import 'package:agendador_tarefas_app/components/tarefa_tile.dart';
import 'package:agendador_tarefas_app/provider/tarefas_provider.dart';
import 'package:agendador_tarefas_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TarefasListScreen extends StatelessWidget {
  const TarefasListScreen({super.key});

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
      body: tarefasProvider.count > 0
          ? ListView.builder(
              itemCount: tarefasProvider.count,
              itemBuilder: (context, index) =>
                  TarefaTile(tarefasProvider.tarefaById(index)),
            )
          : const Center(
              child: Card(
                borderOnForeground: true,
                elevation: 32,
                color: Colors.blueGrey,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "NÃO HÁ TAREFAS CADASTRADAS",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
