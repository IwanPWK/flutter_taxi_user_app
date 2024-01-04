import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_handler/app_info.dart';
import '../app_handler/map_handler.dart';
import '../widgets/progress_dialog.dart';
import '../main_screens/main_screen.dart';

class RestartScreen extends StatefulWidget {
  const RestartScreen({super.key});

  @override
  State<RestartScreen> createState() => _RestartScreenState();
}

class _RestartScreenState extends State<RestartScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
    });
    Provider.of<AppInfo>(context, listen: false).clearDropOffLocation();
    Provider.of<MapHandler>(context, listen: false).clearMarkersSet();
    Provider.of<MapHandler>(context, listen: false).clearPolyLineSet();
    Provider.of<MapHandler>(context, listen: false).clearCirclesSet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Dialog.fullscreen(
        child: ProgressDialog(
          message: 'Please wait',
        ),
      ),
    );
  }
}
