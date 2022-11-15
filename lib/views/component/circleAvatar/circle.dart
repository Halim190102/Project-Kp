import 'package:flutter/material.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({
    Key? key,
    required this.foto,
  }) : super(key: key);

  final String foto;

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 80,
      child: ClipOval(
        child: Image.network(
          widget.foto,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.person,
              size: 60,
            );
          },
        ),
      ),
    );
  }
}
