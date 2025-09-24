import 'package:path/path.dart';
import 'package:sa_odontoconsultorio/models/atendimento_model.dart';
import 'package:sa_odontoconsultorio/models/paciente_model.dart';
import 'package:sqflite/sqflite.dart';
import '../models/paciente_model.dart';
import '../models/atendimento_model.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  factory DbHelper() => _instance;
  DbHelper._internal();

  Database? _db;

  Future<Database> get db async {
    _db ??= await _initDB();
    return _db!;
  }
  
  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), "clinica.db");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async{
    await db.execute('''
      CREATE TABLE pacientes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT,
      cpf TEXT,
      dataNascimento TEXT,
      telefone TEXT,
      email TEXT,
      historicoMedico TEXT
      )
    ''');

    await db.execute('''
      CEATE TABLE atendimentos (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      pacienteId INTEGER,
      dataHora TEXT,
      descricao TEXT,
      dentesEnvolvidos TEXT,
      observacoes TEXT,
      valor REAL,
      FOREIGN KEY(pacienteId) REFERENCES pacientes(id) ON DELETE CASCADE
      )
    ''');
  }

  //Paciente CRUD
  Future<int> inserirPaciente(Paciente p) async{
    final dbClient = await db;
    return await dbClient.insert("pacientes", p.toMap());
  }

  Future<List<Paciente>> listarPacientes() async {
    final dbClient = await db;
    final result = await dbClient.query("pacientes");
    return result.map((e) => Paciente.fromMap(e)).toList();
  }

  Future<int> atualizarPaciente(Paciente p) async{
    final dbClient = await db;
    return await dbClient.delete("pacientes", where: "id=?", whereArgs: [p.id]);
  }

  Future<int> excluirPaciente(int id) async {
    final dbClient = await db;
    return await dbClient.delete("pacientes", where: "id = ?", whereArgs: [id]);
  }

  // Atendimento CRUD
  Future<int> inserirAtendimento(Atendimento a) async {
    final dbClient = await db;
    return await dbClient.insert('atendimentos', a.toMap());
  }

  Future<List<Atendimento>> listarAtendimentosPorPaciente(int pacienteId) async {
    final dbClient = await db;
    final result = await dbClient.query('atendimentos', where: 'pacienteId = ?', whereArgs: [pacienteId]);
    return result.map((e) => Atendimento.fromMap(e)).toList();
  }

  }