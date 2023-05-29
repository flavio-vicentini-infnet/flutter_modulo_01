import 'dart:math';

class Tarefa {
  static int idController = 3;

  final String id;
  final String nome;
  final String dia;
  final String hora;
  final String local;

  const Tarefa(this.id, this.nome, this.dia, this.hora, this.local);

  Tarefa.semId({required this.nome, required this.dia, required this.hora, required this.local})
      : this.id = idController.toString();

  static void incrementId(){
    idController++;
  }

  @override
  String toString() {
    return 'Tarefa{id: $id, nome: $nome, dia: $dia, hora: $hora, local: $local}';
  }
}
