import 'package:flutter_application_4/add_form.dart';
import 'package:flutter_application_4/edit_form.dart';
import 'package:flutter_application_4/transaction_provider.dart';
import 'package:provider/provider.dart';

import './data_model.dart';
import 'package:flutter/material.dart';

void main() {
  var app = MultiProvider(
    providers: [
       ChangeNotifierProvider(
        create: ((_){
        return TransactionProvider();
       }),
       ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
    home: MyApp(),
    ),
  );
  runApp(app);
}

//class MyApp extends StatelessWidget {
//สร้างข้อมูลรายการหนังสือ
  // List<BookModel> bookDetail = [
  //   BookModel(ISBN: '9503895032134', bookName: 'Mobile Dev.', price: 250),
  //   BookModel(ISBN: '6578543298797', bookName: 'Flutter', price: 350),
  //];

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
  }

class _MyAppState extends State<MyApp> {
  @override
  void initstate() {
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).intialBook();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายการหนังสือ'),
      ),
//แสดงรายการหนังสือทั้งหมดในหน้าแอพพลิเคชัน
      body: Consumer(
        builder: (context, TransactionProvider provider, Widget? child) {
          if(provider.bookDetail.length <=0){
            return Center(child: Text('ไม่มีรายการสั่งซื้อ', style: TextStyle(fontSize: 20),),);
          } else{
          return ListView.builder(
          itemCount: provider.bookDetail.length,
          itemBuilder: (context, index) {
            var bookList = provider.bookDetail[index];
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(bookList.bookName),
                  Text(bookList.price.toString()),
                ],
              ),
              subtitle: Text(bookList.ISBN),
              onTap: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: ((context) {
                  return EditForm();
                }),
                settings: RouteSettings(
                  arguments: provider.bookDetail[index]),
                ));
              },
            );
          },
          );
          }
        } 
      ),
//ปุ่มบวกมุมล่างขวา
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddForm(),));
        },
      ),
    );
  }
}