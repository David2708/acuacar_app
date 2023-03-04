
import 'package:flutter/material.dart';

apbbar(BuildContext context) {
    return AppBar(
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushReplacementNamed(context, 'login');
            }, 
            icon: const Icon(Icons.logout)
          )
        ],
      );
  }