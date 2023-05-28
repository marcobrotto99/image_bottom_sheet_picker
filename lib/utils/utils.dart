import 'dart:io';

import 'package:photo_manager/photo_manager.dart';

class Utils {
  static Future<List<File>> getFileList({
    required List<String> selectedAssets,
    required List<AssetEntity>? assets,
  }) async {
    List<File> fileList = [];
    if (assets != null) {
      for (var i = 0; i < selectedAssets.length; i++) {
        for (var j = 0; j < assets.length; j++) {
          if (selectedAssets[i] == assets[j].id) {
            var file = await assets[j].file;
            if (file != null) {
              fileList.add(file);
              break;
            }
          }
        }
      }
    }
    return fileList;
  }
}
