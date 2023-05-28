part of 'camera_item_bloc.dart';

class CameraItemState {
  final CameraController? controller; //To control the camera
  final Future<void>? initializeControllerFuture;
  final List<CameraDescription> cameras;
  final int selectedCamera;

  const CameraItemState({
    this.controller,
    this.initializeControllerFuture,
    this.cameras = const [],
    this.selectedCamera = 0,
  });

  CameraItemState copyWith({
    CameraController? controller,
    Future<void>? initializeControllerFuture,
    List<CameraDescription>? cameras,
    int? selectedCamera,
  }) {
    return CameraItemState(
      controller: controller ?? this.controller,
      initializeControllerFuture:
          initializeControllerFuture ?? this.initializeControllerFuture,
      cameras: cameras ?? this.cameras,
      selectedCamera: selectedCamera ?? this.selectedCamera,
    );
  }
}
