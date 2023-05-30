import 'package:agendador_tarefas_app/components/edita_tarefa_form.dart';
import 'package:agendador_tarefas_app/components/tarefa_form.dart';
import 'package:agendador_tarefas_app/provider/tarefas_provider.dart';
import 'package:agendador_tarefas_app/routes/app_routes.dart';
import 'package:agendador_tarefas_app/screens/tarefas_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TarefasProvider(),)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        routes: {
          AppRoutes.HOME: (_) => const TarefasListScreen(),
          AppRoutes.TAREFA_FORM: (_) => const TarefaForm(),
          AppRoutes.EDITA_TAREFA_FORM: (_) => const EditaTarefaForm(),
        },
      ),
    );
  }
}

