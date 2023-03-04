
import 'package:acuacar_app/providers/login_form_provider.dart';
import 'package:acuacar_app/utils/alertDialog.dart';
import 'package:acuacar_app/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ui/input_decorations.dart';

class LoginScreen extends StatelessWidget {
   
  const LoginScreen({Key? key}) : super(key: key);
  
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
                    Text('Inicie Sesión', style: Theme.of(context).textTheme.headlineMedium,),
                    const SizedBox(height: 30),

                    const _LoginForm()
                  ],
                )
              ),
              const SizedBox(height: 50,),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'register'),
                child: const Text(
                  'Registrate', 
                  style: TextStyle( 
                    fontSize: 18 , 
                    fontWeight: FontWeight.bold, 
                    color: Color.fromRGBO(36, 70, 181, 1)
                    ),
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


class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);
    

    return Form(
      key: loginForm.formLoginKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'exmple@gmail.com',
              labelText: 'Correo Electrónico',
              prefixIcon: Icons.alternate_email_rounded
            ),
            onChanged: ( value ) => loginForm.email = value,
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
             onChanged: ( value ) => loginForm.password = value,
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
                'Ingresar',
                style: TextStyle(color: Colors.white),
              ),
            ),
            onPressed: () async {
              FocusScope.of(context).unfocus();
              if( !loginForm.isValidForm() ) return;
                print('Credenciales validas');
              if(await loginForm.validarCredenciales(loginForm.email, loginForm.password)){
                Navigator.pushNamed(context, 'main');
              }else{
                showAlertDialog(context, 'Credenciales Invalidas');
              }

              loginForm.email = '';
              loginForm.password = '';

            } ,
          )
        ],
      ),
    );
  }


}