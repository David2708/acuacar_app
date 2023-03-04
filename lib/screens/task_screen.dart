import 'package:acuacar_app/widgets/card_container.dart';
import 'package:acuacar_app/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/usuario_models.dart';
import '../providers/login_form_provider.dart';
import '../services/services.dart';
import '../utils/alertDialog.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);
    Usuario usuario = loginForm.user;

    return Scaffold(
      appBar: AppBar(),
      drawer: const SideMenu(),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CardContainer(
            child: _Form(idUsuario: usuario.idUsuario,),
          ),
        ],
      )),
    );
  }
}

class _Form extends StatefulWidget {

  const _Form({super.key, required this.idUsuario});

  final int idUsuario;

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {

  final tareaCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        TextField(
          autocorrect: true,
          controller: tareaCtrl,
          autofocus: true,
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
            hintText: 'Ingrese la tarea'
          ),
        ),

        const SizedBox(height: 20),

        MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          disabledColor: Colors.grey,
          elevation: 0,
          color: const Color.fromARGB(255, 42, 66, 146),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
            child: const Text(
              'Crear Tarea',
              style: TextStyle(color: Colors.white),
            ),
          ),
          onPressed: () async {
            final mensaje = await Services.crearTarea(tareaCtrl.text, widget.idUsuario);
            tareaCtrl.text = '';
            showAlertDialog(context, mensaje);
          },
        )
      ],
    );
  }
}
