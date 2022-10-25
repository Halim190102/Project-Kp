import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koperasi/view_model/authentication/auth.dart';
import 'package:koperasi/view_model/image_services.dart';
import 'package:koperasi/views/authentication/login.dart';
import 'package:koperasi/views/component/circleAvatar/circle.dart';
import 'package:provider/provider.dart';

class MyAkun extends StatefulWidget {
  const MyAkun({super.key});

  @override
  State<MyAkun> createState() => _MyAkunState();
}

class _MyAkunState extends State<MyAkun> {
  @override
  void initState() {
    super.initState();
    final foto = FireAuth.auth.currentUser!.photoURL!;
    setState(() {
      oldImage = foto;
    });
  }

  String? oldImage;
  String? imagePath;
  final uid = FireAuth.auth.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    final providerIamge = Provider.of<ImageServices>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        imagePath == null
            ? ProfilePicture(foto: oldImage!)
            : CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(imagePath!),
              ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final foto = FireAuth.auth.currentUser!.photoURL!;
                setState(() {
                  oldImage = foto;
                });
                XFile? file = await providerIamge.getImage();
                imagePath = await providerIamge.uploadImage(File(file!.path), uid, file.name);
                FireAuth.auth.currentUser!
                    .updatePhotoURL(imagePath!)
                    .whenComplete(() => providerIamge.delete(oldImage!));

                setState(() {});
              },
              child: const Text(
                'Galerry',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 4),
              child: ElevatedButton(
                onPressed: () async {
                  final foto = FireAuth.auth.currentUser!.photoURL!;
                  setState(() {
                    oldImage = foto;
                  });
                  XFile? file = await providerIamge.getPhoto();
                  imagePath = await providerIamge.uploadImage(File(file!.path), uid, file.name);
                  FireAuth.auth.currentUser!
                      .updatePhotoURL(imagePath!)
                      .whenComplete(() => providerIamge.delete(oldImage!));

                  setState(() {
                    FireAuth.auth.currentUser!.updatePhotoURL(imagePath!);
                  });
                },
                child: const Text(
                  'Camera',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            await FireAuth.logout();
            if (!mounted) return;
            if (FireAuth.auth.currentUser == null) {
              Navigator.pushReplacementNamed(context, LoginPage.id);
            }
          },
          child: const Text('Log Out'),
        ),
      ],
    );
  }
}
