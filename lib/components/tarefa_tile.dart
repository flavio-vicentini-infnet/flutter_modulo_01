import 'package:agendador_tarefas_app/models/tarefa.dart';
import 'package:agendador_tarefas_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/tarefas_provider.dart';

class TarefaTile extends StatelessWidget {
  const TarefaTile(this.tarefa);

  final Tarefa tarefa;

  @override
  Widget build(BuildContext context) {
    final TarefasProvider tarefasProvider = Provider.of(context, listen: false);

    return Padding(
      padding: const EdgeInsets.fromLTRB(10,0,10,0),
      child: Card(
        child: ListTile(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.EDITA_TAREFA_FORM,
                arguments: tarefa,
              );
            },
            color: Colors.teal,
            icon: Icon(Icons.edit),
          ),
          title: Text('${tarefa.nome}'),
          subtitle: Text("${tarefa.dia} ${tarefa.hora} - ${tarefa.local}"),
          trailing: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Excluir Tarefa'),
                  content: Text('Tem certeza?'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Sim'),
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                    TextButton(
                      child: Text('Não'),
                      onPressed: () => Navigator.of(context).pop(false),
                    )
                  ],
                ),
              ).then((value) {
                if (value) {
                  tarefasProvider.remove(tarefa);
                }
              });
            },
            color: Colors.red,
            icon: Icon(Icons.delete),
          ),
        ),
      ),
    );
  }
}
