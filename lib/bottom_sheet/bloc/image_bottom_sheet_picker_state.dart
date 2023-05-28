part of 'image_bottom_sheet_picker_bloc.dart';

class ImageBottomSheetPickerState {
  final List<String> selectedAssets;
  final List<AssetEntity>? assets;
  final bool isLoading;
  final int? totalEntitiesCount;
  final AssetPathEntity? path;

  const ImageBottomSheetPickerState(
      {required this.selectedAssets,
      this.assets,
      this.isLoading = false,
      this.totalEntitiesCount,
      this.path});

  ImageBottomSheetPickerState copyWith({
    List<String>? selectedAssets,
    List<AssetEntity>? assets,
    bool? isLoading,
    int? totalEntitiesCount,
    AssetPathEntity? path,
  }) {
    return ImageBottomSheetPickerState(
      selectedAssets: selectedAssets ?? this.selectedAssets,
      assets: assets ?? this.assets,
      isLoading: isLoading ?? this.isLoading,
      totalEntitiesCount: totalEntitiesCount ?? this.totalEntitiesCount,
      path: path ?? this.path,
    );
  }
}
