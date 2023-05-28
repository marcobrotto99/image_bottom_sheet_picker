import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class ImageAllScreen extends StatelessWidget {
  const ImageAllScreen({
    Key? key,
    required this.entity,
    required this.option,
    this.onTap,
  }) : super(key: key);

  final AssetEntity entity;
  final ThumbnailOption option;
  final GestureTapCallback? onTap;

  Widget buildContent(BuildContext context) {
    if (entity.type == AssetType.audio) {
      return const Center(
        child: Icon(Icons.audiotrack, size: 30),
      );
    }
    return _buildImageWidget(context, entity, option);
  }

  Widget _buildImageWidget(
    BuildContext context,
    AssetEntity entity,
    ThumbnailOption option,
  ) {
    final Widget image = AssetEntityImage(
      entity,
      isOriginal: false,
      thumbnailSize: option.size,
      thumbnailFormat: option.format,
      fit: BoxFit.cover,
    );
    if (entity.isFavorite) {
      return Stack(
        children: <Widget>[
          Positioned.fill(child: image),
        ],
      );
    }
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Hero(tag: entity.id, child: buildContent(context)),
    ));
  }
}
