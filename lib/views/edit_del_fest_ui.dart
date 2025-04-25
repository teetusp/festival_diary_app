import 'dart:io';

import 'package:festival_diary_app/constants/baseurl_constant.dart';
import 'package:festival_diary_app/constants/color_constant.dart';
import 'package:festival_diary_app/models/fest.dart';
import 'package:festival_diary_app/services/fest_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditDelFestUI extends StatefulWidget {
  Fest? fest;

  EditDelFestUI({super.key, this.fest});

  @override
  State<EditDelFestUI> createState() => _EditDelFestUIState();
}

class _EditDelFestUIState extends State<EditDelFestUI> {
  TextEditingController festNameCtrl = TextEditingController();
  TextEditingController festDetailCtrl = TextEditingController();
  TextEditingController festStateCtrl = TextEditingController();
  TextEditingController festCostCtrl = TextEditingController();
  TextEditingController festNumDayCtrl = TextEditingController();

  //เมธอดแสดง SnakeBar คำเตือน
  showWraningSnakeBar(context, msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Align(
          alignment: Alignment.center,
          child: Text(
            msg,
          ),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

  //เมธอดแสดง SnakeBar คำเตือน
  showCompletegSnakeBar(context, msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Align(
          alignment: Alignment.center,
          child: Text(
            msg,
          ),
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

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
  void initState() {
    festNameCtrl.text = widget.fest!.festName!;
    festDetailCtrl.text = widget.fest!.festDetail!;
    festStateCtrl.text = widget.fest!.festState!;
    festCostCtrl.text = widget.fest!.festCost!.toString();
    festNumDayCtrl.text = widget.fest!.festCost!.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(mainColor),
        title: Text(
          'ข้อมูล Festival Diary',
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
                  'รายละเอียด Festival',
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
                        ? widget.fest!.festImage! == ''
                            ? Image.asset(
                                'assets/images/festlogo.png',
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                '${baseUrl}/images/fests/${widget.fest!.festImage!}',
                              )
                        : Image.file(
                            festFile!,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          )),
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
                  controller: festNameCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.party_mode,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'รายละเอียดงาน Festival',
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: festDetailCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.info_outline_rounded,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
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
                  controller: festStateCtrl,
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
                  controller: festCostCtrl,
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
                  controller: festNumDayCtrl,
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
                  onPressed: () async {
                    //validate UI
                    if (festNameCtrl.text.isEmpty) {
                      showWraningSnakeBar(context, 'กรุณากรอกชื่องาน Festival');
                    } else if (festDetailCtrl.text.isEmpty) {
                      showWraningSnakeBar(
                          context, 'กรุณากรอกรายละเอียดงาน Festival');
                    } else if (festStateCtrl.text.isEmpty) {
                      showWraningSnakeBar(
                          context, 'กรุณากรอกสถานที่จัดงาน Festival');
                    } else if (festCostCtrl.text.isEmpty) {
                      showWraningSnakeBar(
                          context, 'กรุณากรอกค่าใช้จ่ายงาน Festival');
                    } else if (festNumDayCtrl.text.isEmpty) {
                      showWraningSnakeBar(
                          context, 'กรุณากรอกจำนวนวันงาน Festival');
                    } else {
                      //แพ็กข้อมูล แล้วส่งผ่าน API ไปบันทึกลง DB
                      //แพ็กข้อมูล
                      Fest fest = Fest(
                        festName: festNameCtrl.text.trim(),
                        festDetail: festDetailCtrl.text.trim(),
                        festState: festStateCtrl.text.trim(),
                        festCost: double.parse(festCostCtrl.text.trim()),
                        festNumDay: int.parse(festNumDayCtrl.text.trim()),
                        userId: widget.fest!.userId,
                        festId: widget.fest!.festId,
                      );
                      //ส่งผ่าน API ไปบันทึกลง DB
                      if (await FestAPI().updateFest(fest, festFile)) {
                        showCompletegSnakeBar(
                          context,
                          'บันทึกแก้ไขงาน Festival เรียบร้อยแล้ว',
                        );
                        //แล้วก็เปิดกลับไปหน้า LoginUI()
                        Navigator.pop(context);
                      } else {
                        showCompletegSnakeBar(
                          context,
                          'บันทึกแก้ไขงาน Festival ไม่สำเร็จ',
                        );
                      }
                    }
                  },
                  child: Text(
                    'บันทึกงานแก้ไข Festival',
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
                SizedBox(
                  height: 15.0,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (await FestAPI().deleteFest(widget.fest!.festId!) == true) {
                      showCompletegSnakeBar(context, 'ลบข้อมูลสำเร็จ');
                      Navigator.pop(context);
                    } else {
                      showWraningSnakeBar(context, 'ลบข้อมูลไม่สำเร็จ');
                    }
                  },
                  child: Text(
                    'ลบงาน Festival',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
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
                SizedBox(
                  height: 25.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
