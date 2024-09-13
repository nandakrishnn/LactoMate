import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProjectFunctionalites {
  /// Picks an image from the gallery.
  Future<XFile?> imagePickercir() async {
    try {
      final XFile? imageUrl = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imageUrl == null) {
        print('No image selected.'); // Log when user cancels picking
        return null;
      }
      print('Image selected: ${imageUrl.path}'); // Debug log for selected image
      return imageUrl;
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }

  /// Uploads an image file to Firebase Storage and returns the download URL.
  Future<String?> uploadImageToFirebase(File imageFile) async {
    try {
      // Verify the file exists before uploading
      if (!imageFile.existsSync()) {
        print('File does not exist: ${imageFile.path}');
        return null;
      }

      String fileName = path.basename(imageFile.path);
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');

      // Start the upload task
      UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);

      // Await the completion of the upload
      TaskSnapshot taskSnapshot = await uploadTask;

      // Get the download URL
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      print('Upload successful: $downloadURL'); // Debug log for successful upload
      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}
