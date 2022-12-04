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
