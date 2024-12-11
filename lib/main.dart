import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);

  void decrement() => emit(state - 1);

  void setToZero() => emit(0);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cubit Vs Bloc',
      home: BlocProvider(
        create: (context) => CounterCubit(),
        child: const CounterHomePage(),
      ),
    );
  }
}

class CounterHomePage extends StatelessWidget {
  const CounterHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final mainCub = BlocProvider.of<CounterCubit>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("This Aint What You Want"), centerTitle: true,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Counter Value"),
            BlocBuilder<CounterCubit, int>(
              builder: (context, state) {
                return Text(state.toString());
              },
            )
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.add),
              onPressed: ()async {
              mainCub.increment();
          }),
          const SizedBox(height: 10,),
          FloatingActionButton(
            child: const Icon(Icons.remove),
              onPressed: ()async {
              mainCub.decrement();
          }),
          const SizedBox(height: 10,),
          FloatingActionButton(
              child: const Icon(Icons.exposure_zero),
              onPressed: ()async {
                mainCub.setToZero();
              }),
        ],
      ),
    );
  }
}


