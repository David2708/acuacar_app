import 'package:acuacar_app/models/usuario_models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/login_form_provider.dart';
import '../widgets/widgets.dart';

class MainScreen extends StatelessWidget {
   
  const MainScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    final loginForm = Provider.of<LoginFormProvider>(context);
    Usuario usuario = loginForm.user;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        drawer: const SideMenu(),
        body: Center(
           child: Text( "Bienvenido, ${usuario.nombre}",
            style: const TextStyle(fontSize: 40, color: Colors.blueGrey),
           ),
        ),
      ),
    );
  }
}