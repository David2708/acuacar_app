import 'package:acuacar_app/providers/register_form_provider.dart';
import 'package:acuacar_app/utils/alertDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/login_form_provider.dart';
import '../ui/input_decorations.dart';
import '../widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
   
  const RegisterScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox( height: 250 ),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    Text('Registrate', style: Theme.of(context).textTheme.headlineMedium,),
                    const SizedBox(height: 30),

                    _RegisterForm(),

                  ],
                )
              ),
              const SizedBox(height: 100,),
            ],
          ),
        ),
      )
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final registerForm = Provider.of<RegisteFromProvider>(context);
    
    return Form(
      key: registerForm.formRegistergKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [

          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'Nombre',
              labelText: 'Nombre',
              prefixIcon: Icons.emoji_people_outlined
            ),
            onChanged: ( value ) => registerForm.name = value,
            validator: (value) {
              return (value != null && value.length >= 3)
              ? null
              :'Debe de ingresar un nombre valido';
            },
          ),

          const SizedBox(height: 30,),

          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'exmple@gmail.com',
              labelText: 'Correo Electrónico',
              prefixIcon: Icons.alternate_email_rounded
            ),
            onChanged: ( value ) => registerForm.email = value,
            validator: (value) {
              String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp  =  RegExp(pattern);

              return regExp.hasMatch(value ?? '')
              ? null
              : 'El valor ingresado no es un correo';
            },
          ),
          const SizedBox(height: 30,),

          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecorations.authInputDecoration(
              hintText: '******',
              labelText: 'Contraseña',
              prefixIcon: Icons.lock_clock_outlined
            ),
             onChanged: ( value ) => registerForm.password = value,
             validator: (value) {
              return (value != null && value.length >= 3)
              ? null
              :'Debe de ingresar una contraseña';
            },
          ),

          const SizedBox(height: 30,),

          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: const Color.fromARGB(255, 42, 66, 146),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 15),
              child: const Text(
                'Registrarse',
                style: TextStyle(color: Colors.white),
              ),
            ),
            onPressed: () async {
              if( !registerForm.isValidForm() ) return;
              if( await registerForm.registrarUsuario(registerForm.name, registerForm.email, registerForm.password) ){
                  showAlertDialog(context, 'Registrado con exito');
                }
            } ,
          )
        ],
      ),
    );
  }
}