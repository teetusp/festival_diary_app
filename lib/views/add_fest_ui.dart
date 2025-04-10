import 'dart:io';

import 'package:festival_diary_app/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddFestUI extends StatefulWidget {
  int? userId;
  AddFestUI({super.key, this.userId});

  @override
  State<AddFestUI> createState() => _AddFestUIState();
}

class _AddFestUIState extends State<AddFestUI> {
  //ตัวแปรเก็บรูปที่ถ่าย
  File? festFile;

  //เมธอดเปิดกล้องเพื่อถ่ายรูป
  Future<void> openCamera() async {
    //เปิดกล้องเพื่อถ่าย
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    //ตรวจสอบว่าได้ถ่ายไหม
    if (image == null) return;

    //หากถ่ายให้เอารูปที่ถ่ายไปเก็บในตัวแปรที่สร้างไว้
    //โดยการแปลงรูปที่ถ่ายให้เป็น File
    setState(() {
      festFile = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(mainColor),
        title: Text(
          'เพิ่ม Festival Diary',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 40.0,
              right: 40.0,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 40.0,
                ),
                Text(
                  'เพิ่มข้อมูล Festival',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                InkWell(
                  onTap: () async {
                    //เรียกใช้งานเมธอดเปิดกล้องเพื่อถ่ายรูป
                    await openCamera();
                  },
                  child: festFile == null
                      ? Icon(
                          Icons.add_a_photo,
                          size: 150,
                          color: Color(mainColor),
                        )
                      : Image.file(
                          festFile!,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ชื่องาน Festival',
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.party_mode,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'สถานที่จัด Festival',
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.pin_drop,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ค่าใช้จ่ายงาน Festival',
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.money,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'จำนวนงานวัน Festival',
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.calendar_month,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                 ElevatedButton(
                    onPressed: () async {},
                    child: Text(
                      'บันทึกงาน Festival',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(mainColor),
                      fixedSize: Size(
                        MediaQuery.of(context).size.width,
                        55.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          5.0,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
