import 'package:clean_arch/features/number_trivia/presentation/bloc/number_trivia_event.dart';
import 'package:clean_arch/features/number_trivia/presentation/bloc/number_trivia_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart ';
import '../bloc/number_trivia_bloc.dart';
import '../widgets/widgets.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Number Trivia')),
        body: buildBody(context));
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                    if (state is Empty) {
                    return const MessageDisplay(message: 'Start Searching');
                  } else if (state is Loading) {
                    return const LoadingWidget();
                  } else if (state is Loaded) {
                    return TriviaDisplay(numberTrivia: state.trivia);
                  } else if (state is Error) {
                    return MessageDisplay(message: state.message);
                  }
                  return const MessageDisplay(message: 'Start');
                  // if (state.status == NumberTriviaStatus.intial) {
                  //   return MessageDisplay(message: 'Start Searching');
                  // } else if (state.status == NumberTriviaStatus.loading) {
                  //   return LoadingWidget();
                  // } else if (state.status == NumberTriviaStatus.success) {
                  //   return TriviaDisplay(numberTrivia: state.numberTrivia);
                  // } else if (state.status == NumberTriviaStatus.error) {
                  //   return MessageDisplay(message: state.message);
                  // }
                 
                
                },
              ),
              const TriviaControls(),
            ],
          ),
        ),
      ),
    );
  }
}

class TriviaControls extends StatefulWidget {
  const TriviaControls({super.key});

  @override
  State<TriviaControls> createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  String inputstr = '1';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) {
            inputstr = value;
            print(inputstr);
          },
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
              hintText: 'Input a Number', border: OutlineInputBorder()),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => dispatchConcrete(context),
                style: const ButtonStyle(),
                child: Container(
                    child: const Text(
                  'Search',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                )),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    dispatchRandom(context);
                  },
                  child: const Text(
                    'Get Random Trivia',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
            ),
          ],
        )
      ],
    );
  }

  void dispatchConcrete(BuildContext context) {
    context.read<NumberTriviaBloc>().add(GetTriviaForConcreteNumber(inputstr));
  }

  void dispatchRandom(BuildContext context) {
    context.read<NumberTriviaBloc>().add(GetTriviaForRandomNumber());
  }
}
