import 'package:flutter/material.dart';
import 'package:job_admin_app/Presentation/EmailPage/email_page.dart';
import 'package:job_admin_app/models/admin.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Admin()),
      ],
      builder: (context,_){
        final Admin userProvider = Provider.of<Admin>(context, listen: false);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Job Admin App',
          home: EmailPage(),
        );
      },
    );
  }
}