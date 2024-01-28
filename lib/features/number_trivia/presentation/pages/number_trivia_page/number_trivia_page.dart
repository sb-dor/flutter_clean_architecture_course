import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/presentation/pages/number_trivia_page/widgets/el_button_widget.dart';

class NumberTriviaPage extends StatefulWidget {
  const NumberTriviaPage({super.key});

  @override
  State<NumberTriviaPage> createState() => _NumberTriviaPageState();
}

class _NumberTriviaPageState extends State<NumberTriviaPage> {
  String forNumberTrivia = '1';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumberTriviaBloc, NumberTriviaState>(builder: (context, state) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.green.shade800,
          title: const Text(
            "Number trivia",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  height: MediaQuery.of(context).size.height / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (state is EmptyNumberTriviaState)
                        const Text(
                          "Start Searching!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )
                      else if (state is ErrorNumberTriviaState)
                        Text(
                          state.message,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )
                      else if (state is LoadingNumberTriviaState)
                        CircularProgressIndicator(
                          color: Colors.green.shade800,
                        )
                      else if (state is LoadedNumberTriviaState)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${state.trivia.number}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${state.trivia.text}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 70,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Center(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (v) => forNumberTrivia = v.trim(),
                              onTapOutside: (v) => FocusManager.instance.primaryFocus?.unfocus(),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10),
                                hintText: "Input a number",
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ElButtonWidget(
                                onTap: () => context
                                    .read<NumberTriviaBloc>()
                                    .add(GetTriviaForConcreteNumber(forNumberTrivia)),
                                backgroundColor: Colors.green.shade800,
                                textColor: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElButtonWidget(
                                onTap: () => context
                                    .read<NumberTriviaBloc>()
                                    .add(GetTriviaForRandomNumber()),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
