// ignore_for_file: sort_child_properties_last

import 'package:festival_diary_app/constants/color_constant.dart';
import 'package:festival_diary_app/models/user.dart';
import 'package:festival_diary_app/services/user_api.dart';
import 'package:festival_diary_app/views/home_ui.dart';
import 'package:festival_diary_app/views/register_ui.dart';
import 'package:flutter/material.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController userPasswordCtrl = TextEditingController();

  bool isShowUserPassword = true;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(mainColor),
        title: Text(
          'Festival Diary',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          //แตะตรงตำแหน่งใดๆ เพื่อให้ keyboard มันซ่อนลง
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
                    height: 35.0,
                  ),
                  Image.asset(
                    'assets/images/festlogo.png',
                    width: 250.0,
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
                    height: 10.0,
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
                    obscureText: isShowUserPassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.lock,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isShowUserPassword = !isShowUserPassword;
                          });
                        },
                        icon: isShowUserPassword == true
                            ? Icon(
                                Icons.visibility_off,
                              )
                            : Icon(
                                Icons.visibility,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      //Validate
                      if (userNameCtrl.text.length == 0) {
                        showWraningSnakeBar(context, 'กรุณากรอกชื่อผู้ใช้');
                      } else if (userPasswordCtrl.text.length == 0) {
                        showWraningSnakeBar(context, 'กรุณากรอกรหัสผ่าน');
                      } else {
                        //ส่งชื่อผู้ใช้และรหัสผ่าน ไปยัง API เพื่อตรวจสอบ
                        //แพ็กข้อมูลที่ต้องส่งไปให้กับ checkLogin()
                        User user = User(
                          userName: userNameCtrl.text,
                          userPassword: userPasswordCtrl.text,
                        );
                        //เรียกใช้ checkLogin()
                        user = await UserAPI().checkLogin(user);
                        if (user.userId != null) {
                          //ชื่อผู้ใช้ถูกต้อง เปืดหน้าจอ HomeUI()
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeUI(user: user),
                            ),
                          );
                        } else {
                          //ชื่อผู้ใช้ไม่ถูกต้อง แสดง SnackeBar แจ้งเตือน
                          showWraningSnakeBar(
                              context, 'ชื่อผู้ใช้รหัสผ่านไม่ถูกต้อง');
                        }
                      }
                    },
                    child: Text(
                      'LOGIN',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ยังไม่มีบัญชี?',
                      ),
                      TextButton(
                        onPressed: () {
                          //เปิดไปหน้าจอ RegisterUI() แบบย้อนกลับได้ ใช้ .push()
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterUI(),
                            ),
                          );
                        },
                        child: Text(
                          'ลงทะเบียน',
                          style: TextStyle(
                            color: Color(mainColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    'Copyright © 2025',
                  ),
                  Text(
                    'Created by Teetus DTI-SAU',
                  ),
                  SizedBox(
                    height: 20.0,
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
