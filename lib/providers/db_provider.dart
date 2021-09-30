import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:qr_reader/models/scan_model.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = new DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {

    // Path de donde se almacena la base de datos en el dispositivo
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'ScansDB.db');
    print(path);

    // Crear base de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
      }
    );

  }

  // Insertar un registro de scan
  Future<int> nuevoScan(ScanModel scanModel) async {
    final db = await database;
    final res = await db.insert('scans', scanModel.toJson());

    return res;
  }

  // Obtener un registro de scan por id
  Future<ScanModel> getScanById(int id) async {
    final db = await database;
    final resp = await db.query('scans', where: 'id = ?', whereArgs: [id]);

    return resp.isNotEmpty ? ScanModel.fromJson(resp.first) : new ScanModel(valor: '');
  }

  // Obtener todos los registros de scan
  Future<List<ScanModel>> getScans() async {
    final db = await database;
    final resp = await db.query('scans');

    return resp.isNotEmpty ? resp.map((scan) => ScanModel.fromJson(scan)).toList() : [];
  }

  // Obtener el listado de scans por tipo
  Future<List<ScanModel>> getScansByTipo(String tipo) async {
    final db = await database;
    final resp = await db.query('scans', where: 'tipo = ?', whereArgs: [tipo]);

    return resp.isNotEmpty ? resp.map((scan) => ScanModel.fromJson(scan)).toList() : [];
  }

  // Actualizar un registro de scan
  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final resp = await db.update('scans', nuevoScan.toJson(), where: 'id = ?', whereArgs: [nuevoScan.id]);

    return resp;
  }

  // Eliminar un registro de scan
  Future<int> deleteScan(int idScan) async {
    final db  = await database;
    final resp = await db.delete('scans', where: 'id = ?', whereArgs: [idScan]);

    return resp;
  }

  // Eliminar todos los registros de scans
  Future<int> deleteAllScans() async {
    final db = await database;
    final resp = await db.delete('scans');

    return resp;
  }

}