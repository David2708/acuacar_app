import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade100,
      child: Column(
        children: [
          _DrawerHeader(),
          ListTile(
            leading: const Icon(Icons.task),
            title: const Text('Crear Tarea'),
            onTap: (){
              Navigator.pushReplacementNamed(context, 'task');
            },
          ),
          ListTile(
            leading: const Icon(Icons.running_with_errors),
            title: const Text('Realizar Ejecucion'),
            onTap: (){
              Navigator.pushReplacementNamed(context, 'excution');
            },
          )
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image:  AssetImage('assets/acuacar.jpg'),
          fit: BoxFit.cover
        )
      ),
      child: Container(),
    );
  }
}