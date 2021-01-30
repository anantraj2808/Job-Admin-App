import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/admin.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Admin userProvider = Provider.of<Admin>(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(userProvider.email),
              Text(userProvider.name),
              Text(userProvider.companyName),
              Text(userProvider.phoneNumber),
              Text(userProvider.uid)
            ],
          ),
        ),
      ),
    );
  }
}
