// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:js' as js;
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import 'package:esprit_spotted/models/message_model.dart';
import 'package:esprit_spotted/services/app_settings.dart';
import 'package:esprit_spotted/views/widgets/close_dialog_button.dart';
import 'package:esprit_spotted/views/widgets/direction_buttons.dart';
import 'package:esprit_spotted/views/widgets/share_all_button.dart';

import 'package:universal_html/html.dart' as html;

import '../models/screenshot_viewmodel.dart';

void selectionHandlingDialog(BuildContext context) {
  NAlertDialog(
    dismissable: true,
    dialogStyle: DialogStyle(borderRadius: BorderRadius.zero, contentPadding: const EdgeInsets.all(15)),
    content: const SelectionDialog(),
    blur: 4,
  ).show(context, transitionType: DialogTransitionType.Bubble);
}

class SelectionDialog extends StatefulWidget {
  const SelectionDialog({super.key});

  @override
  State<SelectionDialog> createState() => _SelectionDialogState();
}

class _SelectionDialogState extends State<SelectionDialog> {
  var pageController = PageController();
  int _currentPage = 0;

  Widget titleWidget(int count) {
    return Text(
      (count > 1) ? "$count Messages" : "$count Message",
      style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }

  void handleMessageSharing(List<Message> selectedMessages) async {
    EasyLoading.show();
    ScreenshotController controller = ScreenshotController();
    List<Uint8List> messageImages = [];
    for (var element in selectedMessages) {
      await controller
          .captureFromWidget(MessagePreview(message: element), context: context, targetSize: const Size(450, 250))
          .then((capturedImage) async {
        messageImages.add(capturedImage);
      });
    }

    int index = 1;
    for (var element in messageImages) {
      js.context.callMethod("webSaveAs", [
        html.Blob([element]),
        "test_$index.jpg"
      ]);

      index++;
    }
    EasyLoading.dismiss();
  }

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPage = pageController.page!.toInt();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var app = Provider.of<AppProvider>(context, listen: false);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              titleWidget(app.selectedMessages!.length),
              CloseDialogButton(
                onClick: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Flexible(
              child: SingleChildScrollView(
                  child: Column(children: [
            SizedBox(
                width: double.maxFinite,
                child: ExpandablePageView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: pageController,
                    itemCount: app.selectedMessages!.length,
                    itemBuilder: (context, index) {
                      return MessagePreview(message: app.selectedMessages![index]);
                    }))
          ]))),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              BackwardButton(
                onClick: () {
                  pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                },
                isEnabled: (_currentPage > 0),
              ),
              Flexible(
                  fit: FlexFit.tight,
                  child: ShareAllButton(onClick: () {
                    handleMessageSharing(app.selectedMessages!);
                  })),
              ForwardButton(
                onClick: () {
                  pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                },
                isEnabled: (_currentPage < app.selectedMessages!.length - 1),
              )
            ],
          )
        ],
      ),
    );
  }
}
