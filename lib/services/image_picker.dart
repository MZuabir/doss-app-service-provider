import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static final ImagePicker _picker = ImagePicker();
  static Future<XFile?> onImgSelected(ImageSource source) async {
    //Picking from the files

    final image = await _picker.pickImage(source: source);
    
    if (image != null) {
      return image;
      ////print("Image picked ${widget.cont.pickedImagePath.value}");

      // FirebaseApi.onImageUploaded(File(widget.cont.pickedImagePath.value))
      //     .then((value) {
      //   Database().onImageUpdate(widget.cont.imgURL.value);
      // });
    }
  }
  static Future<String> xFileToBase64(XFile xFile) async {
    final Uint8List fileBytes = await xFile.readAsBytes();
    final String base64String = base64Encode(fileBytes);
    return base64String;
  }

}
