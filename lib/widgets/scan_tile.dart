import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/util.dart';

class ScanTile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: ( _ , index) => Dismissible(
        key: UniqueKey(),
        background: Container(color: Colors.red),
        onDismissed: (DismissDirection direction) {
          scanListProvider.borrarScanPorId(scans[index].id!);
        },
        child: ListTile(
          leading: Icon(
            scanListProvider.tipoSeleccionado == 'http'
              ? Icons.home_outlined
              : Icons.map_outlined,
            color: Theme.of(context).primaryColor
          ),
          title: Text(scans[index].valor),
          subtitle: Text('Id: ${scans[index].id}'),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          onTap: () => launchURL(context, scans[index]),
        ),
      ),
    );
  }
  
}