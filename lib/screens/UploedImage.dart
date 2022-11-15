import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '../model/api.dart';
import '../model/imag.dart';
import '../wedget/button.dart';

late String docForvideo;
late String docForimage;

class Uplode_screen extends StatefulWidget {
  @override
  _Uplode_screenState createState() => _Uplode_screenState();
}

class _Uplode_screenState extends State<Uplode_screen> {
  UploadTask? task2;
  UploadTask? task1;

  File? file;
  String? url;
  File? myImage;

  // ___________________________select file_____________________________________________________________________
  Future selectFile() async {
    final myvideoPath =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (myvideoPath == null) return;
    final videoPath = myvideoPath.files.single.path!;

    setState(() => file = File(videoPath));
  }
  // _______________________________________________________________________________________________________________________

  // ___________uploed file _______________________________________________________________________________________________
  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'video/$fileName';

    task2 = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task2 == null) return;

    final sssss = await task2!.whenComplete(() {});
    final urlDownload = await sssss.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
    final ref = FirebaseStorage.instance.ref().child('video').child('.mp4');
    await ref.putFile(file!);
    url = await ref.getDownloadURL();
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');

    print('Download-Link: $urlDownload');
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
    FirebaseFirestore db = FirebaseFirestore.instance;
    Map<String, dynamic> videoInfo = {
      "video": url,
    };
    db.collection("video").add(videoInfo).then((DocumentReference doc) {
      docForvideo = doc.id.toString();
    });
  }

  // ___________________________________________________________________________________________________________
  // ________________persantage_________________________________________________________________________________
  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container(
              child: Text("data"),
            );
          }
        },
      );
  //_________________________________________________________________________________________
  Future selectImage() async {
    final imagePath = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (imagePath == null)
      return Container(
        child: Text("please select"),
      );
    final myImagePath = imagePath.files.single.path!;

    setState(() => myImage = File(myImagePath));
  }

  // _______________________________________________________________________________________________
  Future uploadimage() async {
    if (myImage == null) return Text("no image selected");

    final imageName = basename(myImage!.path);
    final destination1 = 'images/$imageName';

    task1 = ImageApi.uploadimage(destination1, myImage!);
    setState(() {});

    if (task1 == null) return;

    final snapshot = await task1!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');

    print('Download-Link: $urlDownload');
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');

    final ref =
        FirebaseStorage.instance.ref().child('images').child('$imageName');
    await ref.putFile(myImage!);
    url = await ref.getDownloadURL();
    FirebaseFirestore db = FirebaseFirestore.instance;
    Map<String, dynamic> imageInfo = {
      "image": url,
    };
    db.collection("images").add(imageInfo).then((DocumentReference doc) {
      docForimage = doc.id.toString();
    });
  }

  // _______________________________________________________________________________________________________
  CollectionReference userImage =
      FirebaseFirestore.instance.collection("images");

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : '';
    final imageName = myImage != null ? basename(myImage!.path) : '';

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context, "login_screen"),
            icon: Icon(
              Icons.app_registration,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: Colors.green,
        title: Text("image"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Image(
          image: AssetImage("images/upload.png"),
          color: Colors.green,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Container(
                  height: 700,
                  width: 700,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonWidget(
                          text: ' select video',
                          icon: Icons.attach_file,
                          onClicked: selectFile,
                        ),
                        Text(
                          fileName,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        ButtonWidget(
                          text: 'Upload video',
                          icon: Icons.cloud_upload_outlined,
                          onClicked: uploadFile,
                        ),
                        task2 != null ? buildUploadStatus(task2!) : Container(),
                        ButtonWidget(
                          text: ' select image',
                          icon: Icons.attach_file,
                          onClicked: selectImage,
                        ),
                        Text(
                          imageName,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        ButtonWidget(
                          text: 'Upload image',
                          icon: Icons.cloud_upload_outlined,
                          onClicked: uploadimage,
                        ),
                        task1 != null ? buildUploadStatus(task1!) : Container(),
                      ]),
                ),
              );
            },
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: StreamBuilder<QuerySnapshot>(
          stream: userImage.snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 20,
                  );
                },
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  QueryDocumentSnapshot x = snapshot.data!.docs[index];
                  return Container(
                    child: Column(children: [
                      Container(
                          height: 300,
                          width: double.infinity,
                          child: Image(
                            image: NetworkImage(x['image']),
                            fit: BoxFit.fill,
                          ))
                    ]),
                  );
                },
              );
            }
            return Center(
              child: Container(),
            );
          },
        ),
      ),
    );
  }
}
