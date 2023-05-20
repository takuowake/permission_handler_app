import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: const Text('Permission Handler Example'),
          ),
          body: Center(
            child: ElevatedButton(
              child: const Text('Request Camera Permission'),
              onPressed: () async {
                var status = await Permission.camera.status;

                if (status.isDenied || status.isPermanentlyDenied) {
                  status = await Permission.camera.request();
                  _showRequestStatus(context, status);
                  if (status.isDenied || status.isPermanentlyDenied) {
                    openAppSettings();
                  }
                } else {
                  _showRequestStatus(context, status);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showRequestStatus(BuildContext context, PermissionStatus status) {
    final SnackBar snackBar = SnackBar(
      content: Text('Camera permission is ' + (status.isGranted ? 'granted.' : 'denied.')),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

