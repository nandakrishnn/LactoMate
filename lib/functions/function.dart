import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProjectFunctionalites{
  
  Future imagePickercir() async {
    final imageUrl=await ImagePicker().pickImage(source: ImageSource.gallery);
    return imageUrl;
    
    
  }
  Future<String?> uploadImageToFirebase(File imageFile) async {
  try {
    String fileName = path.basename(imageFile.path);
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
    
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  } catch (e) {
    print('Error uploading image: $e');
    return null;
  }
}
}