import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:playx_home_launcher/playx_home_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _defaultLauncher = 'Unknown';
  bool _isDefault = false;
  String _isLauncher = 'no';


  @override
  void initState() {
    super.initState();
    getDefaultPackageName();
    checkIfLauncherIsDefault();
    checkIfAppIsLauncher();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> getDefaultPackageName() async {
    String name;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      name =
          await PlayxHomeLauncher.getDefaultLauncherPackageName() ?? 'Unknown package';
    } catch(e) {
      name = 'Failed to get package name.\n $e';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _defaultLauncher = name;
    });
  }

  Future<void> checkIfLauncherIsDefault() async {
    bool isDefault;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      isDefault =
          await PlayxHomeLauncher.checkIfLauncherIsDefault() ?? false;
    } on PlatformException {
      isDefault = false;
    }

    if (!mounted) return;

    setState(() {
      _isDefault = isDefault;
    });
  }


  Future<void> checkIfAppIsLauncher() async {
    try{
      final isLauncher = await PlayxHomeLauncher.checkIfAppIsLauncher() ??false;
      setState(() {
        _isLauncher = isLauncher ? 'yes' : 'no';
      });
    }catch(e){
      setState(() {
        _isLauncher = 'Error : ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Is Launcher : $_isLauncher\n'),
              Text('Is Default : $_isDefault\n'),
              Text('Default is : $_defaultLauncher\n'),

              ElevatedButton(
                onPressed: () async {
                  checkIfAppIsLauncher();
                },
                child: const Text('Check if App is Launcher'),
              ),
              ElevatedButton(
                onPressed: () {
                  checkIfLauncherIsDefault();
                },
                child: const Text('Is the app the Default Launcher'),
              ),
              // default
              ElevatedButton(
                onPressed: () {
                  getDefaultPackageName();
                },
                child: const Text('Get Default Launcher Name'),
              ),

              ElevatedButton(
                onPressed: (){
                  PlayxHomeLauncher.showLauncherSelectionDialog();
                },
                child: const Text('Show Launcher Selection'),
              ),
              ElevatedButton(
                onPressed: () {
                  PlayxHomeLauncher.openLauncherSettings();
                },
                child: const Text('Open Launcher Settings'),
              ),
            ],
          ),
        ),

      ),
    );
  }

}
