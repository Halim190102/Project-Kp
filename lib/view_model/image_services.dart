import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class ImageServices with ChangeNotifier {
  Future<XFile?> getImage() async {
    notifyListeners();
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  Future<XFile?> getPhoto() async {
    notifyListeners();
    return await ImagePicker().pickImage(source: ImageSource.camera);
  }

  Future<String> uploadImage(Uint8List imageFile, String uid, String name) async {
    Reference ref = FirebaseStorage.instance.ref().child('$uid/$name');
    await ref.putData(imageFile);
    notifyListeners();
    return ref.getDownloadURL();
  }

  delete(String url) {
    Reference ref = FirebaseStorage.instance.refFromURL(url);
    ref.delete();
    notifyListeners();
  }
}
