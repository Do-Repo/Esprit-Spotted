import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'message_model.dart';

class ScreenShotModel extends StatefulWidget {
  const ScreenShotModel({super.key, required this.message});
  final Message message;
  @override
  State<ScreenShotModel> createState() => _ScreenShotModelState();
}

class _ScreenShotModelState extends State<ScreenShotModel> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        constraints: const BoxConstraints(minHeight: 150),
        padding: const EdgeInsets.all(10),
        // margin: const EdgeInsets.symmetric(horizontal: 2.5),
        decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
        child: Flexible(
          fit: FlexFit.tight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.message.message,
                style: GoogleFonts.inter(fontSize: 17),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    thickness: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                  Row(
                    children: [
                      Text(DateFormat.yMMMEd().format(widget.message.createdAt)),
                      const Spacer(),
                      Text(DateFormat.jm().format(widget.message.createdAt)),
                    ],
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
