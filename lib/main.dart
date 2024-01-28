import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/presentation/pages/number_trivia_page/number_trivia_page.dart';
import 'package:flutter_tdd_clean_architecture_course/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NumberTriviaBloc>(create: (_) => locator.get<NumberTriviaBloc>()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NumberTriviaPage(),
      ),
    );
  }
}
