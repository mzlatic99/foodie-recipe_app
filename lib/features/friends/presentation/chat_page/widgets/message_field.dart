import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
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
  final _controller = TextEditingController();

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
      widget.onSubmit('URL:$downloadUrl', 'image');
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading image: $e');
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: TextField(
        controller: _controller,
        style: TextStyles.textFieldStyle,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        decoration: _messageTextFieldStyle(
          onSubmit: () {
            widget.onSubmit(_controller.text, 'text');
            _controller.clear();
          },
        ),
      ),
    );
  }

  InputDecoration _messageTextFieldStyle({required Function() onSubmit}) {
    return InputDecoration(
      hintText: StringConstants.enterMessage,
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
