import 'dart:io';

import 'package:festival_diary_app/constants/baseurl_constant.dart';
import 'package:festival_diary_app/constants/color_constant.dart';
import 'package:festival_diary_app/models/user.dart';
import 'package:festival_diary_app/services/user_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserUI extends StatefulWidget {
  User? user;

  UserUI({super.key, this.user});

  @override
  State<UserUI> createState() => _UserUIState();
}

class _UserUIState extends State<UserUI> {
  //สรัางตัวควบุคม TextFile
  TextEditingController userFullnameCtrl = TextEditingController();
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController userPasswordCtrl = TextEditingController();

  //สร้างตัวแปรควบคุมการเปิดปิดตากับช่องป้อนรหัสผ่าน
  bool isVisible = true;

  //ตัวแปรเก็บรูปที่ถ่าย
  File? userFile;

  //เมธอดเปิดกล้องเพื่อถ่ายรูป
  Future<void> openCamera() async {
    //เปิดกล้องเพื่อถ่าย
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    //ตรวจสอบว่าได้ถ่ายไหม
    if (image == null) return;

    //หากถ่ายให้เอารูปที่ถ่ายไปเก็บในตัวแปรที่สร้างไว้
    //โดยการแปลงรูปที่ถ่ายให้เป็น File
    setState(() {
      userFile = File(image.path);
    });
  }

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

  showUserInfo() async {
    setState(() {
      userFullnameCtrl.text = widget.user!.userFullname!;
      userNameCtrl.text = widget.user!.userName!;
      userPasswordCtrl.text = widget.user!.userPassword!;
    });
  }

  @override
  void initState() {
    showUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(mainColor),
        title: Text(
          'ข้อมูลส่วนตัว',
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
          //แตะตรงตำแหน่่งใดๆ เพื่อให้ keyboard มันซ่อนลง
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 40.0,
              right: 40.0,
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    'ลงทะเบียน',
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
                    child: userFile == null
                        ? widget.user!.userImage! == ''
                            ? Image.network(
                                '${baseUrl}/images/users/${widget.user!.userImage!}',
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              )
                            : Icon(
                                Icons.person_add_alt_1,
                                size: 150,
                                color: Color(mainColor),
                              )
                        : Image.file(
                            userFile!,
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
                      'ชื่อ-นามสกุล',
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: userFullnameCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.featured_play_list_rounded,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ชื่อผู้ใช้',
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: userNameCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.person,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'รหัสผ่าน',
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: userPasswordCtrl,
                    obscureText: isVisible,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.lock,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: Icon(
                          isVisible == true
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      //ส่งข้อมูลไปแก้ไขที่ DB ผ่าน API ส่วน Backend ที่สร้างไว้
                      //Validate UI
                      if (userFullnameCtrl.text.trim().isEmpty) {
                        showWraningSnakeBar(context, 'ป้อนชื่อ-นามสกุลด้วย...');
                      } else if (userNameCtrl.text.trim().isEmpty) {
                        showWraningSnakeBar(context, 'ป้อนชื่อผู้ใช้ด้วย...');
                      } else if (userPasswordCtrl.text.trim().isEmpty) {
                        showWraningSnakeBar(context, 'ป้อนรหัสผ่านด้วย...');
                      } else {
                        //แพ็กข้อมูล แล้วส่งผ่าน API ไปแก้ไขบันทึกลง DB
                        //แพ็กข้อมูล
                        User user = User(
                          userId: widget.user!.userId,
                          userFullname: userFullnameCtrl.text.trim(),
                          userName: userNameCtrl.text.trim(),
                          userPassword: userPasswordCtrl.text.trim(),
                        );
                        //ส่งข้อมูลผ่าน API ไปบันทึกลง DB
                        user = await UserAPI().updateUser(user, userFile);

                        if (user.userId != null) {
                          showCompletegSnakeBar(
                            context,
                            'แก้ไขเรียบร้อยแล้ว',
                          );
                          //แล้วก็เปิดกลับไปหน้า HomeUI
                          Navigator.pop(context, user);
                        } else {
                          showCompletegSnakeBar(
                            context,
                            'แก้ไขไม่สำเร็จ',
                          );
                        }
                      }
                    },
                    child: Text(
                      'บันทึกแก้ไขข้อมูลส่วนตัว',
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
                    height: 25.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
