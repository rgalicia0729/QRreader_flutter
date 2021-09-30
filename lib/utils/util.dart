import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:qr_reader/models/scan_model.dart';

void launchURL(BuildContext context, ScanModel scan) async {
  if (scan.tipo!.contains('http')) {
    await canLaunch(scan.valor) ? await launch(scan.valor) : throw 'Could not launch ${scan.valor}';
  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}