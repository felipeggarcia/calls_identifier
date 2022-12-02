import 'package:calls_identifier/model/call.dart';
import 'package:calls_identifier/models/call_model.dart';
import 'package:calls_identifier/view/components/call_history_grid.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  MainPage({required this.callHistory});
  List<CallModel> callHistory;

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
