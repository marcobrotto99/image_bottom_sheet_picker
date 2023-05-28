import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'camera_item_state.dart';

class CameraItemBloc extends Cubit<CameraItemState> {
  CameraItemBloc() : super(const CameraItemState()) {
    _initCamera();
  }

  _initializeCamera(int cameraIndex) async {
    CameraController controller =
        CameraController(state.cameras[cameraIndex], ResolutionPreset.max);
    emit(
      state.copyWith(
        controller: controller,
        initializeControllerFuture: controller.initialize(),
      ),
    );
  }

  _initCamera() async {
    if (state.cameras.isEmpty) {
      await availableCameras().then((value) {
        emit(state.copyWith(cameras: value));
        if (value.length > 1) {
          _initializeCamera(state.selectedCamera);
        }
        return value;
      });
    } else {
      if (state.cameras.length > 1) {
        _initializeCamera(state.selectedCamera);
      }
    }
  }

  @override
  Future<void> close() {
    state.controller?.dispose();
    super.close();
    return Future.value();
  }
}
