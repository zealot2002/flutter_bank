import 'package:flutter/material.dart';
import 'package:flutter_bank/utils/logger.dart';

void main() {
  SimpleLogger.d('1', '=== Flutter Bank App Starting ===');
  SimpleLogger.d('2', 'main() function called');
  
  try {
    SimpleLogger.d('3', 'About to call runApp()');
    runApp(const MyApp());
    SimpleLogger.d('4', 'runApp() called successfully');
  } catch (e) {
    SimpleLogger.e('5', 'Error in main(): $e');
    rethrow;
  }
  
  SimpleLogger.d('6', '=== main() function completed ===');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SimpleLogger.d('7', 'MyApp.build() called');
    SimpleLogger.d('8', 'Creating MaterialApp widget');
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      onGenerateRoute: (settings) {
        SimpleLogger.d('9', 'onGenerateRoute called: ${settings.name}');
        return null;
      },
      builder: (context, child) {
        SimpleLogger.d('10', 'MaterialApp builder called');
        return child!;
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  _MyHomePageState() {
    SimpleLogger.d('11', '_MyHomePageState constructor called');
  }

  @override
  void initState() {
    SimpleLogger.d('12', '_MyHomePageState.initState() called');
    super.initState();
    SimpleLogger.d('13', 'MyHomePage state initialized with counter: $_counter');
  }

  @override
  void didChangeDependencies() {
    SimpleLogger.d('14', '_MyHomePageState.didChangeDependencies() called');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    SimpleLogger.d('15', '_MyHomePageState.didUpdateWidget() called');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    SimpleLogger.d('16', '_MyHomePageState.deactivate() called');
    super.deactivate();
  }

  @override
  void dispose() {
    SimpleLogger.d('17', '_MyHomePageState.dispose() called');
    super.dispose();
  }

  void _incrementCounter() {
    SimpleLogger.d('18', '_incrementCounter() called, current counter: $_counter');
    
    setState(() {
      _counter++;
      SimpleLogger.d('19', 'Counter incremented to $_counter');
      
      if (_counter % 5 == 0) {
        SimpleLogger.d('20', 'Counter reached multiple of 5: $_counter');
      }
      
      if (_counter > 10) {
        SimpleLogger.e('21', 'Counter exceeded normal range: $_counter');
      }
    });
    
    SimpleLogger.d('22', 'setState() completed, counter is now: $_counter');
  }

  @override
  Widget build(BuildContext context) {
    SimpleLogger.d('23', '_MyHomePageState.build() called with counter: $_counter');
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
