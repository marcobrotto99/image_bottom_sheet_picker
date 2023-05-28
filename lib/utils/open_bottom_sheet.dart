import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_bottom_sheet_picker/bottom_sheet/screens/bottom_sheet_screen.dart';

void imageBottomSheetPicker({
  required BuildContext context,
  int maxImage = 0,
  required Function(List<File>) onImageSelected,
}) {
  assert(maxImage >= 0);
  _openBottomSheet(context, maxImage, onImageSelected);
}

_openBottomSheet(
  BuildContext context,
  int maxImage,
  Function(List<File>) onImageSelected,
) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return BottomSheetScreen(
        maxImage: maxImage,
        onImageSelected: onImageSelected,
      );
    },
  );
}
