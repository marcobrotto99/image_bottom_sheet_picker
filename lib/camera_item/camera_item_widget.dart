import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_bottom_sheet_picker/camera_item/bloc/camera_item_bloc.dart';

class CameraItemWidget extends StatelessWidget {
  const CameraItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CameraItemBloc>(
      create: (context) => CameraItemBloc(),
      child: BlocBuilder<CameraItemBloc, CameraItemState>(
        builder: (BuildContext context, state) {
          return state.cameras.length > 1
              ? FutureBuilder<void>(
                  future: state.initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        state.controller != null) {
                      return CameraPreview(state.controller!);
                    } else {
                      // Otherwise, display a loading indicator.
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                )
              : const CircularProgressIndicator();
        },
      ),
    );
  }
}
