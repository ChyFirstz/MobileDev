import 'package:flutter/material.dart';
import 'package:flutter_application_4/data_model.dart';
import 'package:flutter_application_4/transaction_provider.dart';
import 'package:provider/provider.dart';

class EditForm extends StatefulWidget {
  @override
  State<EditForm> createState() => _EditForm();
}

class _EditForm extends State<EditForm> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final bookDetail = ModalRoute.of(context)!.settings.arguments as BookModel;
    
  final ISBNContraller = TextEditingController(text: bookDetail.ISBN);
  final bookNameContraller = TextEditingController(text: bookDetail.bookName);
  final priceContraller = TextEditingController(text: bookDetail.price.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text('ฟอร์มบันทึกข้อมูล'),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                const SizedBox(height: 50),
                //ส่วนรับข้อมูล ISBN
                Row(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Icon(Icons.auto_stories),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text('ISBN'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: ISBNContraller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'ISBN',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if(value!.isEmpty) {
                      return 'กรุณากรอก ISBN';
                    }
                  },
                ),
                //-----------------End ISBN -----------------
                const SizedBox(height: 20),
                //ส่วนรับข้อมูล bookName
                Row(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Icon(Icons.library_books),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text('ชื่อหนังสือ'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: bookNameContraller,
                  decoration: InputDecoration(
                    hintText: 'Book Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if(value!.isEmpty) {
                      return 'กรุณากรอกชื่อหนังสือ';
                    }
                  },
                ),
                //-----------------End bookName -----------------
                const SizedBox(height: 20),
                //ส่วนรับข้อมูล ราคาหนังสือ
                Row(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Icon(Icons.auto_stories),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text('ราคาหนังสือ'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: priceContraller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Price',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if(value!.isEmpty) {
                      return 'กรุณากรอกราคาหนังสือ';
                    }
                    if(double.parse(value) <= 0) {
                      return 'กรุณากรอกตัวเลขมากกว่า 0';
                    }
                  },
                ),
                //-----------------End ราคาหนังสือ -----------------
                
                const SizedBox(height: 20),
                //ปุ่ม Cancle และ Submit
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancle'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        if(formKey.currentState!.validate()) {
                          var ISBN = ISBNContraller.text;
                          var bookName = bookNameContraller.text;
                          var price = priceContraller.text;
        
                          var statement = BookModel(ISBN: ISBN, bookName: bookName, price: double.parse(price));
                          var provider = Provider.of<TransactionProvider>(context,listen: false);
                          provider.editBook(statement);
                          // print(ISBN);
                          // print(bookName;
                          // print(price);
        
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Submit'),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                //-----------------End Cancle & Submit -----------------
                const SizedBox(height: 20),
                GestureDetector(
                  child: Container(
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                      ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    var provider = Provider.of(context, 
                    listen: false);

                    provider.deleteBook(bookDetail);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}