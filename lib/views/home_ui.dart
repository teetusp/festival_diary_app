import 'dart:math';

import 'package:festival_diary_app/constants/baseurl_constant.dart';
import 'package:festival_diary_app/constants/color_constant.dart';
import 'package:festival_diary_app/models/fest.dart';
import 'package:festival_diary_app/models/user.dart';
import 'package:festival_diary_app/services/fest_api.dart';
import 'package:festival_diary_app/views/add_fest_ui.dart';
import 'package:festival_diary_app/views/edit_del_fest_ui.dart';
import 'package:festival_diary_app/views/login_ui.dart';
import 'package:festival_diary_app/views/user_ui.dart';
import 'package:flutter/material.dart';

class HomeUI extends StatefulWidget {
  User? user;

  HomeUI({super.key, this.user});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  //สร้างตัวแปรสําหรับเก็บข้อมูล fest ที่ได้จากการดึงมาจาก DB ผ่าน API
  late Future<List<Fest>> festAllData;

  //สร้าง method ดึงข้อมูล fest ทั้งหมดของผู้ใช้งานที่ login เข้ามาจาก API ที่สร้างไว้
  Future<List<Fest>> getAllFestByUserFromHomeUI() async {
    final festData = await FestAPI().getAllFestByUser(widget.user!.userId!);
    return festData;
  }

  @override
  void initState() {
    festAllData = getAllFestByUserFromHomeUI();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(mainColor),
        title: Text(
          'Festival Diary',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginUI(),
                ),
              );
            },
            icon: Icon(
              Icons.exit_to_app,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40.0,
            ),
            widget.user!.userImage! == ''
                ? Image.asset(
                    'assets/images/festlogo.png',
                    width: 100,
                    height: 100,
                  )
                : Image.network(
                    '${baseUrl}/images/users/${widget.user!.userImage!}',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              widget.user!.userFullname!,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserUI(
                      user: widget.user,
                    ),
                  ),
                ).then((value) {
                  setState(() {
                    widget.user = value;
                  });
                });
              },
              child: Text(
                '(Edit Profile)',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.redAccent,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: FutureBuilder(
                future: festAllData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'พบปัญหาในการทำงาน ลองใหม่อีกครั้ง Error: ${snapshot.error}',
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:(context) => EditDelFestUI(
                                    fest: snapshot.data![index],
                                  ),
                                ),
                              ).then( (value){
                                setState(() {
                                 festAllData = getAllFestByUserFromHomeUI(); 
                                });
                              });
                            },
                            leading: snapshot.data![index].festImage! == ""
                                ? Image.asset('assets/images/festlogo.png')
                                : Image.network(
                                    '${baseUrl}/images/fests/${snapshot.data![index].festImage!}'),
                            title: Text(
                              snapshot.data![index].festName!,
                            ),
                            subtitle: Text(
                              snapshot.data![index].festDetail!,
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        'ไม่พบข้อมูล',
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFestUI(
                userId: widget.user!.userId,
              ),
            ),
          ).then((value) {
            setState(() {
              festAllData = getAllFestByUserFromHomeUI  ();
            });
          });
        },
        label: Text(
          'Festival',
        ),
        icon: Icon(
          Icons.add,
        ),
        backgroundColor: Color(mainColor),
        foregroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
