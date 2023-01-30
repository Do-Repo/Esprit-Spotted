import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShareAllButton extends StatelessWidget {
  const ShareAllButton({Key? key, required this.onClick}) : super(key: key);
  final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
          padding: const EdgeInsets.all(5),
          child: Center(
            child: Text(
              "Share All",
              style: GoogleFonts.inter(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
            ),
          )),
    );
  }
}
