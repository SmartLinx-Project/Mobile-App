import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'auth.dart';

class GoogleStorage{

  Future<void> pickUploadImage() async{
    String uid = await Auth().getUid();
    String photoUri = "$uid.jpg";
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 75,
    );

    Reference ref = FirebaseStorage.instance.ref().child(photoUri);

    await ref.putFile(File(image!.path));
    await ref.getDownloadURL().then((value) async{
      await Auth().updateProfilePhoto(value);
    });

  }
}