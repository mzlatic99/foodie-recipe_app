import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../../../../../constants/string_constants.dart';
import '../../../../../theme/theme.dart';

class MessageField extends StatefulWidget {
  const MessageField({super.key, required this.onSubmit});
  final void Function(String message, String type) onSubmit;

  @override
  State<MessageField> createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField> {
  final controller = TextEditingController();

  final _picker = ImagePicker();

  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      final compressedImage = await FlutterImageCompress.compressWithFile(
        pickedImage.path,
        quality: 60,
      );
      await _uploadImageToFirebase(compressedImage!);
    }
  }

  Future<void> _uploadImageToFirebase(Uint8List imageFile) async {
    try {
      final firebaseStorage = FirebaseStorage.instance;
      final storageRef = firebaseStorage.ref();
      final uploadTask = storageRef
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg')
          .putData(imageFile);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      widget.onSubmit('URL:$downloadUrl',
          'image'); // Sending the image URL as a message with type 'image'
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: TextField(
        controller: controller,
        style: TextStyles.textFieldStyle,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        decoration: messageTextFieldStyle(
          onSubmit: () {
            widget.onSubmit(controller.text, 'text');
            controller.clear();
          },
        ),
      ),
    );
  }

  InputDecoration messageTextFieldStyle({required Function() onSubmit}) {
    return InputDecoration(
      hintText: StringConstants.enterMessage,
      hintStyle: TextStyles.text,
      focusColor: ThemeColors.greyText,
      contentPadding: const EdgeInsets.all(18),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ThemeColors.primary,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ThemeColors.main,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      prefixIcon: GestureDetector(
        onTap: _openImagePicker,
        child: SvgPicture.asset(
          Assets.icons.image,
          width: 14,
          fit: BoxFit.scaleDown,
        ),
      ),
      suffixIcon: GestureDetector(
        onTap: onSubmit,
        child: SvgPicture.asset(
          Assets.icons.paperPlane,
          width: 14,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
