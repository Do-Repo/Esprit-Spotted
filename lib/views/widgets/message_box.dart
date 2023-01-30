import 'package:esprit_spotted/services/app_settings.dart';
import 'package:esprit_spotted/views/widgets/vertical_divider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

import '../../models/message_model.dart';

class MessageBox extends StatefulWidget {
  const MessageBox({super.key, required this.message});
  final Message message;

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  bool hover = false;
  bool showBadge = true;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: (() => setState(() => hover = !hover)),
      onHover: (value) => setState(() => hover = value),
      child: badges.Badge(
        showBadge: visibilityDecider(widget.message) ? true : hover,
        onTap: () => actionDecider(widget.message),
        badgeContent: iconDecider(widget.message),
        position: badges.BadgePosition.topEnd(top: 20, end: 20),
        badgeStyle: badges.BadgeStyle(
            badgeColor: Theme.of(context).backgroundColor, borderSide: BorderSide(style: BorderStyle.solid, color: Theme.of(context).primaryColor)),
        child: Container(
          margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
          width: double.infinity,
          decoration: BoxDecoration(color: Theme.of(context).backgroundColor, borderRadius: const BorderRadius.all(Radius.circular(10))),
          constraints: const BoxConstraints(minHeight: 150),
          child: Stack(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.message.message,
                    style: GoogleFonts.inter(fontSize: 16, letterSpacing: 0.7),
                  )),
              if (hover)
                Positioned.fill(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.3), borderRadius: const BorderRadius.all(Radius.circular(10))),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration:
                                  BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)), color: Theme.of(context).backgroundColor),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: const Icon(Icons.share_outlined),
                                  ),
                                  const Spacer(),
                                  Text(DateFormat.yMMMEd().format(widget.message.createdAt)),
                                  const VerticalDiv(height: 30),
                                  Text(DateFormat.jm().format(widget.message.createdAt)),
                                ],
                              ),
                            ),
                          ),
                        ))),
            ],
          ),
        ),
      ),
    );
  }

  void actionDecider(Message msg) {
    var app = Provider.of<AppProvider>(context, listen: false);
    if (app.selectedMessages != null && app.selectedMessages!.contains(msg)) {
      return app.unselectMessage(msg);
    } else {
      return app.selectMessage(msg);
    }
  }

  Icon iconDecider(Message msg) {
    var app = Provider.of<AppProvider>(context);
    if (app.selectedMessages != null && app.selectedMessages!.contains(msg)) {
      return const Icon(Icons.check);
    } else {
      return const Icon(Icons.add);
    }
  }

  bool visibilityDecider(Message msg) {
    var app = Provider.of<AppProvider>(context);
    if (app.selectedMessages != null && app.selectedMessages!.contains(msg)) {
      return true;
    } else {
      return false;
    }
  }
}
