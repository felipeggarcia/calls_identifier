import 'package:flutter/material.dart';

import '../../models/call_model.dart';
import 'call_item.dart';

class CallHistoryGrid extends StatelessWidget {
  CallHistoryGrid({Key? key, required this.callHistory}) : super(key: key);
  List<CallModel> callHistory;

  List<CallItem> callHistoryWidget = [];

  @override
  Widget build(BuildContext context) {
    callHistory.forEach((value) {
      callHistoryWidget.add(CallItem(callModel: value));
    });
    return SingleChildScrollView(
      child: Column(
        children: callHistoryWidget,
      ),
    );
  }
}
