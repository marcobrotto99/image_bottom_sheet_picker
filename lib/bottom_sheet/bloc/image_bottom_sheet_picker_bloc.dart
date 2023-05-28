import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';

part 'image_bottom_sheet_picker_state.dart';

class ImageBottomSheetPickerBloc extends Cubit<ImageBottomSheetPickerState> {
  ImageBottomSheetPickerBloc(int maxImage)
      : super(
          const ImageBottomSheetPickerState(selectedAssets: []),
        ) {
    maxSelect = maxImage;
    requestAssets();
  }

  late final int maxSelect;

  requestAssets() async {
    emit(state.copyWith(isLoading: true));
    try {
      final PermissionState ps = await PhotoManager.requestPermissionExtend();
      if (!ps.hasAccess) {
        emit(state.copyWith(isLoading: false));
        return;
      }
      final FilterOptionGroup filterOptionGroup = FilterOptionGroup(
        imageOption: const FilterOption(
          sizeConstraint: SizeConstraint(ignoreSize: true),
        ),
      );

      final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
        onlyAll: true,
        filterOption: filterOptionGroup,
        type: RequestType.image,
      );
      if (paths.isEmpty) {
        emit(state.copyWith(isLoading: false));
        return;
      }
      final List<AssetEntity> entities = await paths.first.getAssetListPaged(
        page: 0,
        size: await paths.first.assetCountAsync,
      );
      emit(
        state.copyWith(
          isLoading: false,
          path: paths.first,
          assets: entities,
          totalEntitiesCount: await paths.first.assetCountAsync,
        ),
      );
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void addRemoveSelect(String addSelect) {
    var selectedAssets = state.selectedAssets.toList();

    if (selectedAssets.contains(addSelect)) {
      selectedAssets.remove(addSelect);
    } else {
      if (maxSelect != 0 && selectedAssets.length >= maxSelect) {
        selectedAssets.removeAt(0);
      }
      selectedAssets.add(addSelect);
    }
    emit(
      state.copyWith(
        selectedAssets: selectedAssets,
      ),
    );
  }
}
