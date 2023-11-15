import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';

class JavaScriptDateExample extends StatefulWidget {
  @override
  _JavaScriptDateExampleState createState() => _JavaScriptDateExampleState();
}

class _JavaScriptDateExampleState extends State<JavaScriptDateExample> {
  final javascriptRuntime =
      getJavascriptRuntime(forceJavascriptCoreOnAndroid: false);
  @override
  void initState() {
    super.initState();
    javascriptRuntime.setInspectable(true);

    _initJavaScriptRuntime();
  }

  Future<void> _initJavaScriptRuntime() async {
    // Example: Get the current date in JavaScript and print it
    String jsonString = await rootBundle.loadString('assets/mspack.js');

    await javascriptRuntime.evaluateAsync(jsonString);
    String script = '''
      var currentDate = new Date();
      currentDate;
   var msgPackData =  msgpack.encode(currentDate);
  console.log('MessagePack encoded data:', msgPackData);
  var decodedData = msgpack.decode(msgPackData);
  console.log('Decoded data:', decodedData);
    ''';

    await javascriptRuntime.evaluateAsync(script);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Js'),
      ),
      body: Center(
        child: Text('Check the console for JavaScript message pack'),
      ),
    );
  }

  @override
  void dispose() {
    javascriptRuntime.dispose();
    super.dispose();
  }


}

void main() {
  runApp(
    MaterialApp(
      home: JavaScriptDateExample(),
    ),
  );
}

