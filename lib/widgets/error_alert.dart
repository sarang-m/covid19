import 'package:flutter/material.dart';

class ErrorAlert extends StatelessWidget {
  final String errorMessage;
  final Function onRetryButtonPressed;

  const ErrorAlert(
      {Key key,
      @required this.errorMessage,
      @required this.onRetryButtonPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Error"),
      content: Text(errorMessage),
      actions: [
        FlatButton(onPressed: onRetryButtonPressed, child: Text("Retry"))
      ],
    );
  }
}
