import 'package:image_picker/image_picker.dart';

class ProjectFunctionalites{
  
  Future imagePickercir() async {
    final imageUrl=await ImagePicker().pickImage(source: ImageSource.gallery);
    return imageUrl;
    
    
  }
}