import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import 'image_all_screen.dart';

class ImageItemWidget extends StatelessWidget {
  const ImageItemWidget({
    Key? key,
    required this.entity,
    required this.option,
    this.onTap,
    this.isSelect = false,
  }) : super(key: key);

  final AssetEntity entity;
  final ThumbnailOption option;
  final GestureTapCallback? onTap;
  final bool isSelect;

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
    return Stack(
      children: <Widget>[
        Positioned.fill(child: image),
        PositionedDirectional(
          top: 4,
          end: 4,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                !isSelect ? Icons.circle_outlined : Icons.circle,
                color: Colors.green,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => ImageAllScreen(
                      key: key,
                      entity: entity,
                      option: const ThumbnailOption(
                          size: ThumbnailSize.square(2000)),
                    )));
      },
      child: Hero(tag: entity.id, child: buildContent(context)),
    );
  }
}
