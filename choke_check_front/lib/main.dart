import 'package:choke_check_front/data/auth/services/auth_service.dart';
import 'package:choke_check_front/data/post/services/post_service.dart';
import 'package:choke_check_front/ui/pages/initial_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChokeCheck',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.light(),
      home: MultiProvider(
        providers: [
          Provider<AuthService>(
              create: (_) => AuthService.create(),
              dispose: (_, AuthService service) => service.client.dispose()),
          Provider<PostService>(
            create: (_) => PostService.create(),
            dispose: (_, PostService service) => service.client.dispose(),
          ),
        ],
        child: const InitialPage(),
      ),
    );
  }
}
