import 'dart:io';
import 'package:camera/camera.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:image_picker/image_picker.dart';

class ImageProviders with ChangeNotifier {
  CameraController? _controller;
  bool isCameraReady = false;
  File? _image;
  String? imagePath;
  final picker = ImagePicker();

  File get image => _image!;

  CameraController get cameraController => _controller!;

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(firstCamera, ResolutionPreset.medium,
        enableAudio: false);

    await _controller!.initialize();

    if (_controller!.value.isInitialized) {
      isCameraReady = true;
    }
    notifyListeners();
  }

  Future<void> takePicture() async {
    try {
      final XFile picture = await _controller!.takePicture();

      _image = File(picture.path);

      notifyListeners();
    } catch (e) {
      debugPrint("Error al tomar la foto: $e");
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setImagePath(pickedFile.path);
      }
    } catch (e) {
      debugPrint("Error al subir imagen: $e");
    }
  }

  void setImagePath(String path) {
    _image = File(path);
    notifyListeners();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}
