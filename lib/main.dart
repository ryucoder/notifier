import 'package:flutter/material.dart';
import 'package:notifier/notifier_block.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: Text("Love"),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: BlocProvider(
          create: (_) => NotifierBloc(),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Parent",
                  style: TextStyle(fontSize: 21),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Child(
                      title: "Child 1",
                    )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Child(
                      title: "Child 2",
                    )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Child(
                      title: "Child 3",
                    )),
                  ],
                ),
                BlocBuilder<NotifierBloc, NotifierBlocData>(
                  builder: (context, data) {
                    return Text(
                      '${data.event.runtimeType} - ${data.state}',
                      style: Theme.of(context).textTheme.titleMedium,
                    );
                  },
                ),
              ],
            ),
          )),
    );
  }
}

class Child extends StatelessWidget {
  String title;
  bool selected = false;
  Child({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.purple,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<NotifierBloc, NotifierBlocData>(
            builder: (context, data) {
              return GestureDetector(
                onTap: () {
                  print("TAPPED ${this.title}");
                  context.read<NotifierBloc>().add(ChildItemClicked(
                      title: this.title, selected: this.selected));
                },
                child: Container(
                  color: Colors.yellow,
                  child: Row(
                    children: [
                      Text(
                        " ${this.title}",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 10),
          GrandChild(title: " GC1", parentTitle: this.title),
          SizedBox(height: 10),
          GrandChild(title: " GC2", parentTitle: this.title),
          SizedBox(height: 10),
          GrandChild(title: " GC3", parentTitle: this.title),
          SizedBox(height: 10),
          BlocBuilder<NotifierBloc, NotifierBlocData>(
            builder: (context, data) {
              return Center(
                child: Text(
                  '${data.event.runtimeType} - ${data.state}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class GrandChild extends StatelessWidget {
  String title;
  String parentTitle;
  bool selected = false;

  GrandChild({super.key, required this.title, required this.parentTitle});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotifierBloc, NotifierBlocData>(
      builder: (context, data) {
        return GestureDetector(
          onTap: () {
            print("TAPPED ${this.title}");
            context.read<NotifierBloc>().add(GrandChildItemClicked(
                parentTitle: this.parentTitle,
                title: this.title,
                selected: this.selected));
          },
          child: Container(
            color: Colors.red,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      this.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      " - ",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Center(
                      child: Text(
                        '${data.event.runtimeType} - ${data.state}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
