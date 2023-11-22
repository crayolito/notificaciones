import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification/bloc/notificacions/notificacions_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificacionsBloc =
        BlocProvider.of<NotificacionsBloc>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('${notificacionsBloc.state.status.toString()}'),
        actions: [
          IconButton(
            onPressed: () {
              print('Solicitar Permisos');
              notificacionsBloc.requestPermission();
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 0, itemBuilder: (context, index) => const ListTile());
  }
}
