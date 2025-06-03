
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_colors.dart';

var counter = 0;

class Credit extends StatelessWidget {
  Credit({super.key});

  final _gitHubUri = Uri(scheme: 'url', path: "https://github.com/prosky5");
  final _rickRollUri = Uri(scheme: 'url', path: "https://youtu.be/EE-xtCF3T94");

  void onPressed(BuildContext context) async {
    if (counter < 2) {
      counter++;
      await canLaunch(_gitHubUri.path)
          ? await launch(_gitHubUri.path)
          : throw 'Could not call $_gitHubUri';
    } else {
      counter--;
      onLongPressed(context);
    }
  }

  void onLongPressed(BuildContext context) async {
    Clipboard.setData(ClipboardData(text: _rickRollUri.path)).then((value) =>
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Ссылка скопирована!"))));
    Future.delayed(const Duration(milliseconds: 1500), () async {
      await canLaunch(_rickRollUri.path)
          ? await launch(_rickRollUri.path)
          : throw 'Could not call $_rickRollUri';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
      child: TextButton(
          onPressed: () async => onPressed(context),
          onLongPress: () async => onLongPressed(context),
          style: ButtonStyle(
            overlayColor:
            MaterialStateProperty.all(AppColors.white.withAlpha(80)),
            foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                // if (states.contains(MaterialState.hovered)) {
                //   return Colors.white;
                // }
                return AppColors.white; // defer to the defaults
              },
            ),
          ),
          child: const Text(
            "© 2025 Stas.ProSky, by Flutter Web",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey),
            selectionColor: AppColors.white,
          )),
    );
  }
}
