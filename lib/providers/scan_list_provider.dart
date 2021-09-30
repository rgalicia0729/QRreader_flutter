import 'package:flutter/material.dart';

import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  // Registra un nuevo registro de scan
  Future<ScanModel> addScan(valor) async {
    final scan = new ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(scan);

    // Se agrega el id al scan
    scan.id = id;

    if (this.tipoSeleccionado == scan.tipo) {
      // Se agrega el scan a la lista de scans
      this.scans.add(scan);
      notifyListeners();
    }

    return scan;
  }

  // Cargar todos los cans de la base de datos
  cargarScans() async {
    final scans = await DBProvider.db.getScans();
    this.scans = [...scans];
    notifyListeners();
  }

  // Cargar scan por tipo seleccionado
  cargarScanPorTipo(String tipo) async {
    final scans = await DBProvider.db.getScansByTipo(tipo);
    this.scans = [...scans];
    this.tipoSeleccionado = tipo;
    notifyListeners();
  }

  // Borrar todos los cans
  borrarScans() async {
    await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  // Borrar scan por id
  borrarScanPorId(int id) async {
    await DBProvider.db.deleteScan(id);
  }
}