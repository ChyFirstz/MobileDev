import 'package:flutter_application_4/data_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class transactionDB {
  String dbName;
  transactionDB({required this.dbName});

  Future<Database> openDatabase() async {
    var appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);

    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);

    return db; 
  }

  Future insertData(BookModel statement) async {
    var db = await this.openDatabase();

    //สร้างที่เก็บข้อมูล
    var store = intMapStoreFactory.store('bookStore');
    //สร้างเอกสาร JSON
    var keyID = store.add(db, {
      'IBSN': statement.ISBN,
      'bookName': statement.bookName,
      'price': statement.price,
    });
    db.close();
    return keyID;
  }

  Future updateData(BookModel statement) async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('bookStore');
    final finderData = Finder(filter: Filter.equals('ISBN', statement.ISBN));
    await store.update(
      db, 
      {
      'bookName': statement.bookName,
      'price': statement.price,
    },
    finder: finderData);
    db.close();
  }

  Future deleteData(BookModel statement) async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('bookStore');
    final finderData = Finder(filter: Filter.equals('ISBN', statement.ISBN));
    await store.delete(db, finder: finderData);
    db.close();
  }

  Future selectData() async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('bookStore');
    var snapshot = await store.find(db);
    print(snapshot);
    var bookList = <BookModel>[];
    for (var record in snapshot) {
      bookList.add(BookModel(
        ISBN: record.value['ISBN'].toString(),
        bookName: record.value['bookName'].toString(),
        price: double.parse(record.value['price'].toString())
      ));
    }
    return bookList;
  }
}