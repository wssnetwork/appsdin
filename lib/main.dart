import 'package:appsdin/controller/controller_form.dart';
import 'package:appsdin/model/form.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController namaController = TextEditingController();
  TextEditingController masaController = TextEditingController();
  TextEditingController beratController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState.validate()) {
      FormUpdate formUpdate = FormUpdate(
          namaController.text, masaController.text, beratController.text);

      FormController formController = FormController();

      _showSnackbar("Menyimpan laporan.");

      formController.submitForm(formUpdate, (String response) {
        print("Response: $response");
        if (response == FormController.STATUS_SUCCESS) {
          _showSnackbar("Laporan berjaya disimpan.");
        } else {
          _showSnackbar("Error! Laporan tidak berjaya disimpan.");
        }
      });
    }
  }

  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: namaController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Tiada Butiran Nama';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Nama",
                  ),
                ),
                TextFormField(
                  controller: masaController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Tiada Butiran Masa';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Masa",
                  ),
                ),
                TextFormField(
                  controller: beratController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Tiada Butiran Berat';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Berat",
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                RaisedButton(
                  onPressed: _submitForm,
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
