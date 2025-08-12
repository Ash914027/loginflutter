import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/blocs/auth/auth_bloc.dart';
import 'package:login/ui/login_page.dart';
import 'repositories/picsum_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final picsumRepo = RepositoryProvider.of<PicsumRepository>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Picsum BLoC App',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: LoginPage(picsumRepository: picsumRepo),
      ),
    );
  }
}
