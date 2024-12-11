import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


enum CounterEvent {increment, decrement, setToZero}

class CounterState {
  final int count;
  CounterState(this.count);
}


class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0)){
    on<CounterEvent>((event, emit){
      if(event == CounterEvent.increment){
        emit(CounterState(state.count + 1));
      }
      if(event == CounterEvent.decrement){
        if(state.count < 1) return;
        emit(CounterState(state.count - 1));
      }
      if(event == CounterEvent.setToZero){
        emit(CounterState(0));
      }
    });
  }
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
        create: (context) => CounterBloc(),
        child: const CounterHomePage(),
      ),
    );
  }
}

class CounterHomePage extends StatelessWidget {
  const CounterHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final mainBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("This Aint What You Want"), centerTitle: true,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Counter Value"),
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                return Text(state.count.toString());
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
                mainBloc.add(CounterEvent.increment);
              }),
          const SizedBox(height: 10,),
          FloatingActionButton(
              child: const Icon(Icons.remove),
              onPressed: ()async {
                mainBloc.add(CounterEvent.decrement);
              }),
          const SizedBox(height: 10,),
          FloatingActionButton(
              child: const Icon(Icons.exposure_zero),
              onPressed: ()async {
                mainBloc.add(CounterEvent.setToZero);
              }),
        ],
      ),
    );
  }
}

//updates to use and check git


