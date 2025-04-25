//user_api.dart
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:festival_diary_app/models/user.dart'; //แพ็กเกจที่รวมรวมคำสั่งที่เราใช้ติดต่อ API ที่ Backend Server
import 'package:festival_diary_app/constants/baseurl_constant.dart';

class UserAPI {
  //สร้างออปเจ็กต์ dio เพื่อใช้เป็นตัวที่ติดต่อ API ที่ Backend Server
  final Dio dio = Dio();

  //สร้างเมธอดเรียกใช้ API ลงทะเบียน (เพิ่มข้อมูล user)
  Future<bool> registerUser(User user, File? userFile) async {
    try {
      //เอาข้อมูลใส่ FormData
      final formData = FormData.fromMap({
        'userFullname': user.userFullname,
        'userName': user.userName,
        'userPassword': user.userPassword,
        if (userFile != null)
          'userImage': await MultipartFile.fromFile(
            userFile.path,
            filename: userFile.path.split('/').last,
            contentType: DioMediaType('image', userFile.path.split('.').last),
          ),
      });

      //เอาข้อมูลใน FormData ส่งไปผ่าน API ตาม Endpoint ที่ได้กำหนดไว้
      final responseData = await dio.post(
        '${baseUrl}/user/',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      //หลักจากทำงานเสร็จ ณ ที่นี้ตรวจสอบผลการทำงานจาก responseData
      if (responseData.statusCode == 201) {
        //แปลว่าเพิ่มสำเร็จ
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print('Exception: ${err}');
      return false;
    }
  }

  //สร้่าง Medthod เรียกใช้ API ให้เอาชื่อผู้ใช้และรหัสผ่านไปตรวจสอบ
  Future<User> checkLogin(User user) async {
    try{
      final responseData = await dio.get(
        '${baseUrl}/user/${user.userName}/${user.userPassword}',
      );
      //หลักจากทำงานเสร็จ ณ ที่นี้ตรวจสอบผลการทำงานจาก responseData
      if (responseData.statusCode == 200) {
        return User.fromJson(responseData.data['info']);
      } else {
        return User();
      }
    } catch (err) {
      print('Exception: ${err}');
      return User();
    }
  }

  //สร้างเมธอดเรียกใช้ API (แก้ไขข้อมูล user)
 Future<User> updateUser(User user, File? userFile) async {
    try {
      //เอาข้อมูลใส่ FormData
      final formData = FormData.fromMap({
        'userFullname': user.userFullname,
        'userName': user.userName,
        'userPassword': user.userPassword,
        if (userFile != null)
          'userImage': await MultipartFile.fromFile(
            userFile.path,
            filename: userFile.path.split('/').last,
            contentType: DioMediaType('image', userFile.path.split('.').last),
          ),
      });

      //เอาข้อมูลใน FormData ส่งไปผ่าน API ตาม Endpoint ที่ได้กำหนดไว้
      final responseData = await dio.put(
        '${baseUrl}/user/${user.userId}',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      //หลักจากทำงานเสร็จ ณ ที่นี้ตรวจสอบผลการทำงานจาก responseData
      if (responseData.statusCode == 200) {
        //แปลว่าแก้ไขสำเร็จ
        return User.fromJson(responseData.data["info"]);
      } else {
        return User();
      }
    } catch (err) {
      print('Exception: ${err}');
      return User();
    }
  }
}
