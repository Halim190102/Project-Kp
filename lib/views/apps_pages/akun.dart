import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    var url = FirebaseAuth.instance.currentUser!.photoURL;
    if (url != null) {
      setState(() {
        oldImage = url;
      });
    }
  }

  upload(XFile? file) async {
    final providerImage = Provider.of<ImageServices>(context, listen: false);

    Uint8List filess = await file!.readAsBytes();
    imagePath = await providerImage.uploadImage(filess, uid, file.name);
    FireAuth.auth.currentUser!.updatePhotoURL(imagePath!).whenComplete(() {
      if (oldImage.isNotEmpty) {
        providerImage.delete(oldImage);
        Future.delayed(Duration.zero, () {
          oldImage = imagePath!;
        });
      } else {
        oldImage = imagePath!;
      }
    });
    setState(() {});
  }

  String oldImage = '';
  String? imagePath;
  final uid = FireAuth.auth.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    final providerImage = Provider.of<ImageServices>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          imagePath == null
              ? ProfilePicture(foto: oldImage)
              : CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(imagePath!),
                ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  XFile? file = await providerImage.getImage();
                  upload(file);
                },
                child: const Text(
                  'Galery',
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 4),
                child: ElevatedButton(
                  onPressed: () async {
                    XFile? file = await providerImage.getPhoto();
                    upload(file);
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
        ],
      ),
    );
  }
}
