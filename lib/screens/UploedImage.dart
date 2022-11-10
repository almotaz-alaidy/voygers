// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';

// class UploadImage extends StatefulWidget {
//   const UploadImage({super.key});

//   @override
//   State<UploadImage> createState() => _UploadImageState();
// }

// class _UploadImageState extends State<UploadImage> {
//   File? image;
//   Future _pickImage1() async {
//     try {
//       final image = await ImagePicker().pickImage(source: ImageSource.gallery);

//       if (image == null) return;

//       final imageTemp = File(image.path);

//       setState(() => this.image = imageTemp);
//     } on PlatformException catch (e) {
//       print('Failed to pick image: $e');
//     }
//   }

//   Future _pickImage2() async {
//     try {
//       final image = await ImagePicker().pickImage(source: ImageSource.camera);

//       if (image == null) return;

//       final imageTemp = File(image.path);

//       setState(() => this.image = imageTemp);
//     } on PlatformException catch (e) {
//       print('Failed to pick image: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           "voygers",
//           style: TextStyle(
//               fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//         elevation: 0,
//         backgroundColor: Color.fromARGB(144, 7, 211, 20),
//         actions: <Widget>[
//           IconButton(
//             onPressed: () => Navigator.pop(context, "trip_page"),
//             icon: Icon(
//               Icons.app_registration,
//               color: Color.fromARGB(255, 9, 9, 9),
//             ),
//           )
//         ],
//       ),
//       body: Container(
//         width: 600,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             InkWell(
//               child: image != null
//                   ? Image.file(
//                       image!,
//                       width: 200,
//                       height: 200,
//                     )
//                   : Image.network(
//                       "https://flyclipart.com/thumb2/purple-camera-clip-art-594601.png",
//                       width: 200,
//                       height: 200,
//                     ),
//               onTap: () {
//                 showDialog(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         title: Text("Upload image from"),
//                         content: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             IconButton(
//                                 onPressed: () {
//                                   _pickImage1();
//                                 },
//                                 icon: Icon(Icons.browse_gallery)),
//                             IconButton(
//                                 onPressed: () {
//                                   _pickImage2();
//                                 },
//                                 icon: Icon(Icons.camera))
//                           ],
//                         ),
//                       );
//                     });
//               },
//             ),
//             ElevatedButton(
//               onPressed: () {},
//               child: Text("Upload"),
//               style: ElevatedButton.styleFrom(
//                   // backgroundColor: Colors.purple
//                   ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart';

// import '../model/api.dart';
// import '../model/imag.dart';
// import '../wedget/button.dart';

// class Uplode_screen extends StatefulWidget {
//   @override
//   _Uplode_screenState createState() => _Uplode_screenState();
// }

// class _Uplode_screenState extends State<Uplode_screen> {
//   UploadTask? task2;
//   UploadTask? task1;

//   File? file;
//   String? url;
//   File? myImage;

//   // ___________________________select file_____________________________________________________________________
//   Future selectFile() async {
//     final myvideoPath =
//         await FilePicker.platform.pickFiles(allowMultiple: true);

//     if (myvideoPath == null) return;
//     final videoPath = myvideoPath.files.single.path!;

//     setState(() => file = File(videoPath));
//   }
//   // _______________________________________________________________________________________________________________________

//   // ___________uploed file _______________________________________________________________________________________________
//   Future uploadFile() async {
//     if (file == null) return;

//     final fileName = basename(file!.path);
//     final destination = 'files/$fileName';

//     task2 = FirebaseApi.uploadFile(destination, file!);
//     setState(() {});

//     if (task2 == null) return;

//     final snapshot = await task2!.whenComplete(() {});
//     final urlDownload = await snapshot.ref.getDownloadURL();

//     print('Download-Link: $urlDownload');
//     final ref = FirebaseStorage.instance.ref().child('video').child('.mp4');
//     await ref.putFile(file!);
//     url = await ref.getDownloadURL();
//     FirebaseFirestore db = FirebaseFirestore.instance;
//     Map<String, dynamic> imageInfo = {
//       "video": url,
//     };
//     db.collection("file").add(imageInfo).then((DocumentReference doc) =>
//         print('DocumentSnapshot added with ID: ${doc.id}'));
//   }

//   // ___________________________________________________________________________________________________________
//   // ________________persantage_________________________________________________________________________________
//   Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
//         stream: task.snapshotEvents,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final snap = snapshot.data!;
//             final progress = snap.bytesTransferred / snap.totalBytes;
//             final percentage = (progress * 100).toStringAsFixed(2);

//             return Text(
//               '$percentage %',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             );
//           } else {
//             return Container(
//               child: Text("data"),
//             );
//           }
//         },
//       );
//   //_________________________________________________________________________________________
//   Future selectImage() async {
//     final imagePath = await FilePicker.platform.pickFiles(allowMultiple: false);

//     if (imagePath == null) return;
//     final myImagePath = imagePath.files.single.path!;

//     setState(() => myImage = File(myImagePath));
//   }

//   // _______________________________________________________________________________________________
//   Future uploadimage() async {
//     if (myImage == null) return;

//     final imageName = basename(myImage!.path);
//     final destination1 = 'images/$imageName';

//     task1 = ImageApi.uploadFile(destination1, myImage!);
//     setState(() {});

//     if (task1 == null) return;

//     final snapshot = await task1!.whenComplete(() {});
//     final urlDownload = await snapshot.ref.getDownloadURL();
//     print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');

//     print('Download-Link: $urlDownload');
//     print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');

//     final ref = FirebaseStorage.instance.ref().child('image').child('.jpg');
//     await ref.putFile(myImage!);
//     url = await ref.getDownloadURL();
//     FirebaseFirestore db = FirebaseFirestore.instance;
//     Map<String, dynamic> imageInfo = {
//       "image": url,
//     };
//     db.collection("images").add(imageInfo).then((DocumentReference doc) =>
//         print('DocumentSnapshot added with ID: ${doc.id}'));
//   }

//   // _______________________________________________________________________________________________________
//   CollectionReference studentRef =
//       FirebaseFirestore.instance.collection("images");

//   @override
//   Widget build(BuildContext context) {
//     final fileName = file != null ? basename(file!.path) : '';
//     final imageName = myImage != null ? basename(file!.path) : '';

//     return Scaffold(
//       appBar: AppBar(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 content: Container(
//                   height: 700,
//                   width: 700,
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ButtonWidget(
//                           text: ' select video',
//                           icon: Icons.attach_file,
//                           onClicked: selectFile,
//                         ),
//                         Text(
//                           fileName,
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//                         ButtonWidget(
//                           text: 'Upload video',
//                           icon: Icons.cloud_upload_outlined,
//                           onClicked: uploadFile,
//                         ),
//                         task2 != null ? buildUploadStatus(task2!) : Container(),
//                         ButtonWidget(
//                           text: ' select image',
//                           icon: Icons.attach_file,
//                           onClicked: selectImage,
//                         ),
//                         Text(
//                           imageName,
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//                         ButtonWidget(
//                           text: 'Upload image',
//                           icon: Icons.cloud_upload_outlined,
//                           onClicked: uploadimage,
//                         ),
//                         task1 != null ? buildUploadStatus(task1!) : Container(),
//                       ]),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       body: Container(
//         child: Container(
//           child: StreamBuilder<QuerySnapshot>(
//             stream: studentRef.snapshots(),
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               if (snapshot.hasData) {
//                 return ListView.separated(
//                   separatorBuilder: (context, index) {
//                     return Divider(
//                       height: 20,
//                     );
//                   },
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (context, index) {
//                     QueryDocumentSnapshot x = snapshot.data!.docs[index];
//                     return Container(
//                       child: Column(children: [
//                         Container(
//                             height: 200,
//                             child: Image(
//                               image: NetworkImage(x['image']),
//                               fit: BoxFit.fill,
//                             ))
//                       ]),
//                     );
//                   },
//                 );
//               }
//               return Center(
//                 child: Container(),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class Uplode_screen extends StatefulWidget {
  const Uplode_screen({super.key});

  @override
  State<Uplode_screen> createState() => _Uplode_screenState();
}

class _Uplode_screenState extends State<Uplode_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
