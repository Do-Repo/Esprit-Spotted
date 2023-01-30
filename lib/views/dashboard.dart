import 'package:esprit_spotted/models/message_model.dart';
import 'package:esprit_spotted/services/app_settings.dart';
import 'package:esprit_spotted/services/auth_service.dart';
import 'package:esprit_spotted/services/message_service.dart';
import 'package:esprit_spotted/views/selection_handling_dialog.dart';
import 'package:esprit_spotted/views/widgets/message_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../src/theme_provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<List<Message>> future = MessageService().getMessages();

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<DarkThemeProvider>(context);
    var app = Provider.of<AppProvider>(context);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          actions: [
            IconButton(
                hoverColor: Colors.transparent,
                onPressed: () {
                  theme.darkTheme = !theme.darkTheme;
                },
                icon: Icon(
                  !theme.darkTheme ? Icons.dark_mode : Icons.light_mode,
                  color: Theme.of(context).iconTheme.color,
                ))
          ],
          leading: IconButton(
              onPressed: () => AuthService().signOut(),
              hoverColor: Colors.transparent,
              icon: Icon(
                Icons.logout_outlined,
                color: Theme.of(context).iconTheme.color,
              )),
          title: Text(
            "Esprit Spotted",
            style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Theme.of(context).hintColor, letterSpacing: 0.7),
          ),
        ),
        floatingActionButton: (app.selectedMessages != null && app.selectedMessages!.isNotEmpty)
            ? FloatingActionButton.extended(
                backgroundColor: Theme.of(context).primaryColor,
                hoverColor: Theme.of(context).primaryColor,
                isExtended: true,
                onPressed: () => selectionHandlingDialog(context),
                label: Text(
                  "${app.selectedMessages!.length} Selected",
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ))
            : null,
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: FutureBuilder(
              future: future,
              builder: (context, AsyncSnapshot<List<Message>> snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                } else if (snapshot.hasError) {
                  EasyLoading.showToast(snapshot.error.toString());
                  return IconButton(
                    icon: Icon(Icons.replay, color: Theme.of(context).primaryColor),
                    onPressed: () => setState(() {
                      future = MessageService().getMessages();
                    }),
                  );
                } else {
                  return ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            setDivider(index, snapshot.data!)
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10, top: 30),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            DailyToolkit(index: index, messages: snapshot.data!),
                                            dateGroup(snapshot.data![index].createdAt),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Theme.of(context).primaryColor,
                                        thickness: 4,
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            MessageBox(message: snapshot.data![index]),
                            if (index == snapshot.data!.length - 1) const SizedBox(height: 40)
                          ],
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ));
  }

  bool setDivider(int index, List<Message> msg) {
    if (index == 0) {
      return true;
    } else {
      var thisMessageDate = DateTime.parse(DateFormat("yyyy-MM-dd").format(msg[index].createdAt));
      var pastMessageDate = DateTime.parse(DateFormat("yyyy-MM-dd").format(msg[index - 1].createdAt));

      return !thisMessageDate.isAtSameMomentAs(pastMessageDate);
    }
  }

  Text dateGroup(DateTime messageDate) {
    var formattedMessageDate = DateTime.parse(DateFormat("yyyy-MM-dd").format(messageDate));
    var formattedToday = DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.now()));
    var textStyle = GoogleFonts.inter(color: Theme.of(context).primaryColor, fontSize: 25, fontWeight: FontWeight.bold);
    var textAlignment = TextAlign.right;

    if (formattedToday.isAtSameMomentAs(formattedMessageDate)) {
      return Text(
        "Today ",
        style: textStyle,
        textAlign: textAlignment,
      );
    } else {
      var difference = formattedToday.difference(formattedMessageDate).inDays;
      if (difference > 30) {
        return Text(
          DateFormat("yyyy-MM-dd").format(formattedMessageDate).toString(),
          style: textStyle,
          textAlign: textAlignment,
        );
      }
      return difference == 1
          ? Text("Yesterday ", style: textStyle)
          : Text(
              "$difference Days ago ",
              style: textStyle,
              textAlign: textAlignment,
            );
    }
  }
}

class DailyToolkit extends StatefulWidget {
  const DailyToolkit({super.key, required this.index, required this.messages});
  final List<Message> messages;
  final int index;
  @override
  State<DailyToolkit> createState() => _DailyToolkitState();
}

class _DailyToolkitState extends State<DailyToolkit> {
  bool checkBoxValue = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            side: BorderSide(style: BorderStyle.solid, color: Theme.of(context).primaryColor, width: 2),
            checkColor: Theme.of(context).primaryColor,
            activeColor: Colors.transparent,
            hoverColor: Colors.transparent,
            value: checkSelectedMessages(widget.messages, widget.messages[widget.index].createdAt),
            onChanged: (v) {
              handleEveryMessage(widget.messages[widget.index].createdAt, widget.messages, v!);
            })
      ],
    );
  }

  void handleEveryMessage(DateTime messageDate, List<Message> messages, bool isSelecting) {
    var st = DateTime.parse(DateFormat("yyyy-MM-dd").format(messageDate));
    var app = Provider.of<AppProvider>(context, listen: false);
    for (var element in messages) {
      var sd = DateTime.parse(DateFormat("yyyy-MM-dd").format(element.createdAt));
      if (sd.isAtSameMomentAs(st)) {
        (isSelecting) ? app.selectMessage(element) : app.unselectMessage(element);
      }
    }
  }

  bool checkSelectedMessages(List<Message> messages, DateTime messageDate) {
    var st = DateTime.parse(DateFormat("yyyy-MM-dd").format(messageDate));
    var app = Provider.of<AppProvider>(context);
    List<Message> reasonList = [], compareList = [];

    for (var element in messages) {
      var sd = DateTime.parse(DateFormat('yyyy-MM-dd').format(element.createdAt));
      if (sd.isAtSameMomentAs(st)) {
        reasonList.add(element);
      }
    }
    if (app.selectedMessages != null) {
      for (var element in app.selectedMessages!) {
        var sd = DateTime.parse(DateFormat('yyyy-MM-dd').format(element.createdAt));
        if (sd.isAtSameMomentAs(st)) {
          compareList.add(element);
        }
      }

      return reasonList.toSet().difference(compareList.toSet()).isEmpty;
    } else {
      return false;
    }
  }
}
