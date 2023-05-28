import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_bottom_sheet_picker/bottom_sheet/bloc/image_bottom_sheet_picker_bloc.dart';
import 'package:image_bottom_sheet_picker/bottom_sheet/screens/list_widget.dart';
import 'package:image_bottom_sheet_picker/utils/utils.dart';

class BottomSheetScreen extends StatelessWidget {
  final int maxImage;
  final Function(List<File>) onImageSelected;

  const BottomSheetScreen({
    required this.maxImage,
    required this.onImageSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImageBottomSheetPickerBloc>(
      create: _createCubit,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
              ),
              _getContainer(),
              ListWidget(onImageSelected: onImageSelected),
            ],
          ),
          _getDoneButton(),
        ],
      ),
    );
  }

  Widget _getContainer() {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
            color: Color(0xFF727272),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            )),
        height: 3,
        width: 100,
      ),
    );
  }

  Widget _getDoneButton() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: BlocBuilder<ImageBottomSheetPickerBloc,
              ImageBottomSheetPickerState>(
            builder: (BuildContext context, state) {
              if (state.selectedAssets.isNotEmpty) {
                return FloatingActionButton(
                  child: const Icon(
                    Icons.check,
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                    onImageSelected(await Utils.getFileList(
                      selectedAssets: state.selectedAssets,
                      assets: state.assets,
                    ));
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  ImageBottomSheetPickerBloc _createCubit(BuildContext context) =>
      ImageBottomSheetPickerBloc(maxImage);
}
