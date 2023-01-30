import 'package:flutter/material.dart';

class CloseDialogButton extends StatelessWidget {
  const CloseDialogButton({Key? key, required this.onClick}) : super(key: key);
  final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              border: Border.all(style: BorderStyle.solid, color: Theme.of(context).primaryColor)),
          child: Icon(
            Icons.close,
            color: Theme.of(context).primaryColor,
          )),
    );
  }
}
