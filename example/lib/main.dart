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
  String _packageName = 'Unknown';


  @override
  void initState() {
    super.initState();
    getDefaultPackageName();
    checkIfLauncherIsDefault();
    checkIfAppIsLauncher();
    getCurrentPackageName();
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
          await PlayxHomeLauncher.isThisAppTheDefaultLauncher();
    } catch (e) {
      isDefault = false;
      debugPrint('Failed to check if launcher is default.\n $e');
    }

    setState(() {
      _isDefault = isDefault;
    });
  }


  Future<void> checkIfAppIsLauncher() async {
    try{
      final isLauncher = await PlayxHomeLauncher.isThisAppALauncher();
      setState(() {
        _isLauncher = isLauncher ? 'yes' : 'no';
      });
    }catch(e){
      setState(() {
        _isLauncher = 'Error : ${e.toString()}';
      });
    }
  }

  Future<void> getCurrentPackageName() async {
    try{
     final name= await  PlayxHomeLauncher.getCurrentPackageName();
      setState(() {
        _packageName = name;
      });
    }catch(e){
      setState(() {
        _packageName = 'Error : ${e.toString()}';
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
              Text('This app Package Name : $_packageName\n'),

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
                onPressed: () async {
                final res = await   PlayxHomeLauncher.showLauncherSelectionDialog(openSettingsOnError: true);
                debugPrint('Launcher Selection Dialog Result: $res');
                },
                child: const Text('Show Launcher Selection'),
              ),
              ElevatedButton(
                onPressed: () {
                  PlayxHomeLauncher.openLauncherSettings();
                },
                child: const Text('Open Launcher Settings'),
              ),
              ElevatedButton(
                onPressed: () {
                  getCurrentPackageName();
                },
                child: const Text('Get app Package Name'),
              ),
            ],
          ),
        ),

      ),
    );
  }

}
