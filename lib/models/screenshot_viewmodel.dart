import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'message_model.dart';

class MessagePreview extends StatefulWidget {
  const MessagePreview({super.key, required this.message});
  final Message message;
  @override
  State<MessagePreview> createState() => _MessagePreviewState();
}

class _MessagePreviewState extends State<MessagePreview> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        constraints: const BoxConstraints(minHeight: 150),
        padding: const EdgeInsets.all(10),
        // margin: const EdgeInsets.symmetric(horizontal: 2.5),
        decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(style: BorderStyle.solid, width: 3, color: Theme.of(context).primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
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
