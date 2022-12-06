import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:koperasi/view_model/authentication/auth.dart';
import 'package:koperasi/views/apps_pages/data_photo/foto.dart';
import 'package:koperasi/views/authentication/login.dart';
import 'package:koperasi/views/component/circleAvatar/circle.dart';
import 'package:koperasi/views/component/theme/color.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    super.initState();
    final fire = FirebaseAuth.instance.currentUser!;
    name = fire.displayName!;
    email = fire.email!;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var url = FirebaseAuth.instance.currentUser!.photoURL;
    if (url != null) {
      setState(() {
        oldImage = url;
      });
    }
  }

  String name = '';
  String email = '';
  String oldImage = '';
  String? imagePath;
  final uid = FireAuth.auth.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    // final providerIamge = Provider.of<ImageServices>(context, listen: false);

    return Drawer(
      width: MediaQuery.of(context).size.width * .7,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .35,
            width: double.infinity,
            color: Colors.deepPurple,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      String dataFoto = '';
                      if (imagePath == null) {
                        dataFoto = oldImage;
                      } else {
                        dataFoto = imagePath!;
                      }
                      Navigator.push(context, MaterialPageRoute(builder: (_) => Foto(src: dataFoto)));
                    },
                    child: ProfilePicture(foto: imagePath == null ? oldImage : imagePath!),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    name,
                    style: TextStyle(
                      color: white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    email,
                    style: TextStyle(
                      color: white,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await FireAuth.logout();
                      if (!mounted) return;
                      if (FireAuth.auth.currentUser == null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginPage(),
                          ),
                        );
                      }
                    },
                    child: const Text('Log Out'),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     ElevatedButton(
                  //       onPressed: () async {
                  //         if (oldImage.isEmpty) {
                  //           var data = FirebaseAuth.instance.currentUser!.photoURL;
                  //           if (data != null) {
                  //             oldImage = data;
                  //           }
                  //         }
                  //         XFile? file = await providerIamge.getImage();
                  //         imagePath = await providerIamge.uploadImage(base64Decode(file!.path), uid, file.name);
                  //         FireAuth.auth.currentUser!
                  //             .updatePhotoURL(imagePath!)
                  //             .whenComplete(() => oldImage.isNotEmpty ? providerIamge.delete(oldImage) : null);

                  //         setState(() {});
                  //       },
                  //       child: const Text(
                  //         'Galery',
                  //       ),
                  //     ),
                  //     Container(
                  //       margin: const EdgeInsets.only(left: 4),
                  //       child: ElevatedButton(
                  //         onPressed: () async {
                  //           if (oldImage.isEmpty) {
                  //             var data = FirebaseAuth.instance.currentUser!.photoURL;
                  //             if (data != null) {
                  //               oldImage = data;
                  //             }
                  //           }
                  //           XFile? file = await providerIamge.getPhoto();
                  //           imagePath = await providerIamge.uploadImage(base64Decode(file!.path), uid, file.name);
                  //           FireAuth.auth.currentUser!
                  //               .updatePhotoURL(imagePath!)
                  //               .whenComplete(() => oldImage.isNotEmpty ? providerIamge.delete(oldImage) : null);

                  //           setState(() {
                  //             FireAuth.auth.currentUser!.updatePhotoURL(imagePath!);
                  //           });
                  //         },
                  //         child: const Text(
                  //           'Camera',
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 10),

                  // ElevatedButton(
                  //   onPressed: () async {
                  //     await FireAuth.logout();
                  //     if (!mounted) return;
                  //     if (FireAuth.auth.currentUser == null) {
                  //       Navigator.pushReplacementNamed(context, LoginPage.id);
                  //     }
                  //   },
                  //   child: const Text('Log Out'),
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
