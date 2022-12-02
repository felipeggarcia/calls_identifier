import 'package:flutter/material.dart';

import '../models/call_model.dart';

class CallItem extends StatelessWidget {
  CallModel callModel;

  CallItem({required this.callModel});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 2,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: ListTile(
            title: Text(callModel.phoneNumber),
            subtitle: Text(callModel.dateToString()),
          ),
        ));
  }
}
