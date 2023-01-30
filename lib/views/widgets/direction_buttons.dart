import 'package:flutter/material.dart';

class ForwardButton extends StatelessWidget {
  const ForwardButton({Key? key, required this.onClick, required this.isEnabled}) : super(key: key);
  final VoidCallback onClick;
  final bool isEnabled;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (isEnabled) ? onClick : () {},
      child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: (isEnabled) ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.transparent,
              border: Border.all(
                style: BorderStyle.solid,
                color: (isEnabled) ? Theme.of(context).primaryColor : Theme.of(context).backgroundColor,
              )),
          child: Icon(
            Icons.arrow_forward_ios,
            color: (isEnabled) ? Theme.of(context).primaryColor : Theme.of(context).backgroundColor,
          )),
    );
  }
}

class BackwardButton extends StatelessWidget {
  const BackwardButton({Key? key, required this.onClick, required this.isEnabled}) : super(key: key);
  final VoidCallback onClick;
  final bool isEnabled;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (isEnabled) ? onClick : () {},
      child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: (isEnabled) ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.transparent,
              border: Border.all(
                style: BorderStyle.solid,
                color: (isEnabled) ? Theme.of(context).primaryColor : Theme.of(context).backgroundColor,
              )),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: (isEnabled) ? Theme.of(context).primaryColor : Theme.of(context).backgroundColor,
          )),
    );
  }
}
