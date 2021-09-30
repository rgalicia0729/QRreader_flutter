import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: (){
              Provider.of<ScanListProvider>(context, listen: false).borrarScans();
            }
          )
        ],
      ),
      body: _HomeBody(),
      bottomNavigationBar: CustomButtomNavigationBar(),
      floatingActionButton: CustomFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final int currentIndex = uiProvider.selectedMenuOption;

    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
    
    switch(currentIndex) {

      case 0:
        scanListProvider.cargarScanPorTipo('geo');
        return ScanTile();

      case 1:
        scanListProvider.cargarScanPorTipo('http');
        return ScanTile();

      default:
        return ScanTile();
    }
  }
}