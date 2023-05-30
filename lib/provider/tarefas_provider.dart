import 'package:agendador_tarefas_app/data/tarefas_source.dart';
import 'package:flutter/material.dart';

import '../models/tarefa.dart';

class TarefasProvider with ChangeNotifier {
  final Map<String, Tarefa> _items = {...TAREFAS_SOURCE};

  List<Tarefa> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  Tarefa tarefaById(int i) {
    return _items.values.elementAt(i);
  }

  void insert(Tarefa novaTarefa) {
    if (novaTarefa == null) {
      return;
    }

    final id = novaTarefa.id;

    // inserindo nova tarefa caso ela não exista com ID informado
    _items.putIfAbsent(
      id,
      () => Tarefa(id, novaTarefa.nome, novaTarefa.dia, novaTarefa.hora,
          novaTarefa.local),
    );

    notifyListeners();
  }

  void update(Tarefa novaTarefa) {
    if (novaTarefa == null) {
      return;
    }

    if (novaTarefa.id != null &&
        novaTarefa.id.trim().isNotEmpty &&
        _items.containsKey(novaTarefa.id)) {
      _items.update(
          novaTarefa.id,
          (value) => Tarefa(novaTarefa.id, novaTarefa.nome, novaTarefa.dia,
              novaTarefa.hora, novaTarefa.local));
    }

    notifyListeners();
  }

  void remove(Tarefa tarefa) {
    if (tarefa != null && tarefa.id != null) {
      _items.remove(tarefa.id);
    }

    notifyListeners();
  }
}
