import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'repositories/picsum_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final picsumRepo = PicsumRepository();
  runApp(RepositoryProvider(
    create: (_) => picsumRepo,
    child: const MyApp(),
  ));
}
