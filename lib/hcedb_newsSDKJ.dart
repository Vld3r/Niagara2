import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'news_model.dart';

class NewsDatabase {
  static final NewsDatabase instance = NewsDatabase._init();

  static Database? _database;

  NewsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('news.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE news (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      description TEXT NOT NULL,
      image TEXT NOT NULL,
      date TEXT NOT NULL
    )
    ''');
  }

  Future<News> createNews(News news) async {
    final db = await instance.database;

    final id = await db.insert('news', news.toJson());
    return news.copyWith(id: id);
  }

  Future<News?> readNews(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      'news',
      columns: ['id', 'title', 'description', 'image', 'date'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return News.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<News>> readAllNews() async {
    final db = await instance.database;

    final result = await db.query('news');

    return result.map((json) => News.fromJson(json)).toList();
  }

  Future<int> updateNews(News news) async {
    final db = await instance.database;

    return db.update(
      'news',
      news.toJson(),
      where: 'id = ?',
      whereArgs: [news.id],
    );
  }

  Future<int> deleteNews(int id) async {
    final db = await instance.database;

    return await db.delete(
      'news',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
