import 'package:acuacar_app/services/services.dart';
import 'package:acuacar_app/widgets/card_container.dart';
import 'package:acuacar_app/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/tarea_response.dart';
import '../models/usuario_models.dart';
import '../providers/login_form_provider.dart';

import '../utils/alertDialog.dart';

class ExecutionScreen extends StatelessWidget {
  const ExecutionScreen({Key? key}) : super(key: key);

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
              child: Column(
                children: [
                  _Form(
                    idUsuario: usuario.idUsuario,
                  )
                ],
              ),
            )
          ],
        ),
      ),
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
  late Tarea _tareaSeleccionada;
  final _fechaEjecucion = TextEditingController();
  final _horaInicio = TextEditingController();
  final _horaFIn = TextEditingController();
  final _duracion = TextEditingController();
  final _observaciones = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _onTareaSeleccionada(Tarea tareaSeleccionada) {
    setState(() {
      _tareaSeleccionada = tareaSeleccionada;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // DropdownButton de tareas

        MyDropdownButton(
          userId: widget.idUsuario,
          onTareaSeleccionada: _onTareaSeleccionada
        ),

        // Fecha de ejecucion

        _inputFechaEjecucion(),

        // Hora de inicio

        _inputHoraInicio(),

        //Hora fin

        _inputHoraFin(),

        //Duracion

        _inputDuracion(),

        // Observaciones

        _inputObservaciones(),
        const SizedBox(height: 50),

        _buttonSubmit()
      ],
    );
  }

  MaterialButton _buttonSubmit() {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      disabledColor: Colors.grey,
      elevation: 0,
      color: const Color.fromARGB(255, 42, 66, 146),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        child: const Text(
          'Guardar Ejecucion',
          style: TextStyle(color: Colors.white),
        ),
      ),
      onPressed: () async {
        Services.getTareas(widget.idUsuario);
        final mensaje = await Services.guardarjecucion(
          idUsuario: widget.idUsuario,
          idTarea: _tareaSeleccionada.idTarea,
          fechaEjecucion: _fechaEjecucion.text,
          horaInicio: _horaInicio.text,
          horaFin: _horaFIn.text,
          duracion: _duracion.text,
          observaciones: _observaciones.text
        );
        showAlertDialog(context,mensaje);

        _fechaEjecucion.text = '';
        _horaInicio.text = '';
        _horaFIn.text = '';
        _duracion.text = '';
        _observaciones.text = '';

      },
    );
  }

  TextField _inputObservaciones() {
    return TextField(
      controller: _observaciones,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Observaciones',
        hintText: 'Ingresa tus observaciones',
      ),
    );
  }

  TextField _inputDuracion() {
    return TextField(
      keyboardType: TextInputType.number,
      controller: _duracion,
      decoration: InputDecoration(
        labelText: 'Duracion',
        hintText: '00:00',
      ),
    );
  }

  TextField _inputHoraFin() {
    return TextField(
      controller: _horaFIn,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        labelText: 'Hora Fin',
        hintText: 'Ingrese una hora',
      ),
    );
  }

  TextField _inputHoraInicio() {
    return TextField(
      controller: _horaInicio,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        labelText: 'Hora Inicio',
        hintText: 'Ingrese una hora',
      ),
    );
  }

  TextField _inputFechaEjecucion() {
    return TextField(
        controller: _fechaEjecucion,
        keyboardType: TextInputType.datetime,
        decoration: const InputDecoration(
          labelText: 'Fecha de Ejecucion',
          hintText: 'Select a date',
        ),
        onTap: () {});
  }
}

class MyDropdownButton extends StatefulWidget {
  final int userId;
  final void Function(Tarea) onTareaSeleccionada;

  const MyDropdownButton({required this.userId, required this.onTareaSeleccionada});

  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  late Future<List<Tarea>> _tareasFuture;
  Tarea? _selectedTarea;

  @override
  void initState() {
    super.initState();
    _tareasFuture = Services.getTareas(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Tarea>>(
      future: _tareasFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final tareas = snapshot.data!;

          return DropdownButton<Tarea>(
            value: _selectedTarea,
            hint: const Text('Seleccione una tarea'),
            items: tareas
                .map(
                  (tarea) => DropdownMenuItem<Tarea>(
                    value: tarea,
                    child: Text(tarea.nombreTarea),
                  ),
                )
                .toList(),
            onChanged: (tarea) {
              setState(() {
                _selectedTarea = tarea;
              });
              widget.onTareaSeleccionada(tarea!);
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
