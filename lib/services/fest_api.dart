import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:festival_diary_app/models/fest.dart';
import 'package:festival_diary_app/constants/baseurl_constant.dart';

class FestAPI {
  final dio = Dio();

  Future<bool> insertFest(Fest fest, File? festFile) async {
    try {
      //เอาข้อมูลใส่ FormData
      final formData = FormData.fromMap({
        'festName': fest.festName,
        'festDetail': fest.festDetail,
        'festState': fest.festState,
        'festNumDay': fest.festNumDay,
        'festCost': fest.festCost,
        'userId': fest.userId,
        if (festFile != null)
          'festImage': await MultipartFile.fromFile(
            festFile.path,
            filename: festFile.path.split('/').last,
            contentType: DioMediaType('image', festFile.path.split('.').last),
          ),
      });
      //เอาข้อมูลใน FormData ส่งไปผ่าน API ตาม Endpoint ที่ได้กำหนดไว้
      final responseData = await dio.post(
        '${baseUrl}/fest/',
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

  //สร้าง method เรียกใช้ API ดึงข้อมูล Fest ของผู้ใช้งานหนึ่งๆ ที่ Login เข้ามา
  Future<List<Fest>> getAllFestByUser(int userId) async {
    try{
      final responseData = await dio.get(
        '${baseUrl}/fest/${userId}',
      );
      if(responseData.statusCode == 200){
        return (responseData.data["info"] as List).map((e) => Fest.fromJson(e)).toList();
      }else{
        return <Fest>[];
      }

    }catch(err){
      print('Exception: ${err}');
      return <Fest>[];
    }
  }

  //สร่าง method เรียกใช้ API ลบข้อมูล Fest
  Future<bool> deleteFest (int festId) async {
    try{
      final responseData = await dio.delete(
        '${baseUrl}/fest/${festId}',
      );
      if(responseData.statusCode == 200){
        return true;
      } else{
        return false;
      }
    } catch (err) {
      print('Exception: ${err}');
      return false;
    }
  }

  Future<bool> updateFest(Fest fest, File? festFile) async {
    try {
      //เอาข้อมูลใส่ FormData
      final formData = FormData.fromMap({
        'festName': fest.festName,
        'festDetail': fest.festDetail,
        'festState': fest.festState,
        'festNumDay': fest.festNumDay,
        'festCost': fest.festCost,
        'userId': fest.userId,
        if (festFile != null)
          'festImage': await MultipartFile.fromFile(
            festFile.path,
            filename: festFile.path.split('/').last,
            contentType: DioMediaType('image', festFile.path.split('.').last),
          ),
      });
      //เอาข้อมูลใน FormData ส่งไปผ่าน API ตาม Endpoint ที่ได้กำหนดไว้
      final responseData = await dio.put(
        '${baseUrl}/fest/${fest.festId}',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      //หลักจากทำงานเสร็จ ณ ที่นี้ตรวจสอบผลการทำงานจาก responseData
      if (responseData.statusCode == 200) {
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
}