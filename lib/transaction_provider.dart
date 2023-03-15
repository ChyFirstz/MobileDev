import 'package:flutter/foundation.dart';
import 'package:flutter_application_4/transactiondb.dart';

import './data_model.dart';

class TransactionProvider extends ChangeNotifier{
  List<BookModel> bookDetail = [
    // BookModel(ISBN: '9503895032134', bookName: 'Mobile Dev.', price: 250),
    // BookModel(ISBN: '6578543298797', bookName: 'Flutter', price: 350),
    // BookModel(ISBN: '4484848484889', bookName: 'Number1', price: 450),
  ];

  List<BookModel> getData() {
    return bookDetail;
  }

  addBook(BookModel bookData) async {
    var db = await transactionDB(dbName: 'transaction.db');//.openDatabase();
    //print(db);
    await db.insertData(bookData);

    bookDetail = await db.selectData();

    //bookDetail.insert(0, bookData);
    //bookDetail.add(bookData);
    notifyListeners();
  }

  editBook(BookModel bookData) async {
    var db = await transactionDB(dbName: 'transaction.db');
    await db.updateData(bookData);
    bookDetail = await db.selectData();
    notifyListeners();
  }

    deleteBook(BookModel bookData) async {
    var db = await transactionDB(dbName: 'transaction.db');
    await db.deleteData(bookData);
    bookDetail = await db.selectData();
    notifyListeners();
  }

  intialBook() async {
    var db = await transactionDB(dbName: 'transections.db');
    bookDetail = await db.selectData();
    notifyListeners();
  }
}