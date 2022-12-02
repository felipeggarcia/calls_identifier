import 'package:calls_identifier/models/call_model.dart';
import 'package:calls_identifier/view/components/call_history_grid.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../services/platform_channel.dart';
import '../../utils/formatPhoneNumber.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  String phoneNumber = '';
  int? state;
  late Animation<Color?> animation;
  late AnimationController controller;
  List<CallModel> callHistory = [];

  @override
  void initState() {
    super.initState();

    getPermission().then((value) {
      if (value) {
        PlatformChannel().callStream().listen((event) {
          var arr = event.split("-");
          phoneNumber = arr[0];
          if (phoneNumber.isNotEmpty && phoneNumber != 'null') {
            callHistory.add(CallModel(
                date: DateTime.now(),
                phoneNumber: formatPhoneNumber(phoneNumber)));
            state = int.tryParse(arr[1]);
          }
          setState(() {});
        });
      }
    });

    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.linear);
    animation =
        ColorTween(begin: Colors.white, end: Colors.blue).animate(curve);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
      setState(() {});
    });
    controller.forward();
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<bool> getPermission() async {
    if (await Permission.phone.status == PermissionStatus.granted) {
      return true;
    } else {
      if (await Permission.phone.request() == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Call ID'),
      ),
      body: CallHistoryGrid(
        callHistory: callHistory,
      ),
    );
  }
}
