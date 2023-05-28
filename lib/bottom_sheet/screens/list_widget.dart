import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_bottom_sheet_picker/bottom_sheet/bloc/image_bottom_sheet_picker_bloc.dart';
import 'package:image_bottom_sheet_picker/camera_item/camera_item_widget.dart';
import 'package:image_bottom_sheet_picker/image_widget/image_item_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

class ListWidget extends StatelessWidget {
  final Function(List<File>) onImageSelected;

  const ListWidget({Key? key, required this.onImageSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(14),
        child: BlocBuilder<ImageBottomSheetPickerBloc,
            ImageBottomSheetPickerState>(
          builder: (BuildContext context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (state.assets != null) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                  ),
                  itemCount: state.assets!.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return InkWell(
                        onTap: () async {
                          ImagePicker picker = ImagePicker();
                          await picker
                              .pickImage(source: ImageSource.camera)
                              .then(
                            (value) {
                              if (value != null) {
                                onImageSelected([File(value.path)]);
                                Navigator.pop(context);
                              }
                            },
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: const CameraItemWidget(),
                        ),
                      );
                    }
                    index--;
                    final AssetEntity entity = state.assets![index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: ImageItemWidget(
                        onTap: () async {
                          BlocProvider.of<ImageBottomSheetPickerBloc>(context)
                              .addRemoveSelect(entity.id);
                        },
                        key: ValueKey<int>(index),
                        isSelect: state.selectedAssets.contains(entity.id),
                        entity: entity,
                        option: const ThumbnailOption(
                            size: ThumbnailSize.square(2000)),
                      ),
                    );
                  },
                  findChildIndexCallback: (Key key) {
                    // Re-use elements.
                    if (key is ValueKey<int>) {
                      return key.value;
                    }
                    return null;
                  },
                );
              }
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
