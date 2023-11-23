import 'dart:io';

import 'package:camera/camera.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageProviders with ChangeNotifier {
  CameraController? _controller;
  bool isCameraReady = false;
  String _assetFilePath = "";

  String get assetFilePath => _assetFilePath;
  final picker = ImagePicker();

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

  Future<String> takePicture() async {
    try {
      final XFile picture = await _controller!.takePicture();
      return picture.path;
    } catch (e) {
      throw ("Error al tomar la foto: $e");
    }
  }

  Future<String> pickImageFromGallery() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        return pickedFile.path;
      } else {
        throw ("Error al subir imagen: Valor nulo");
      }
    } catch (e) {
      throw ("Error al subir imagen: $e");
    }
  }

  Future<String> getAssetPath(String path) async {
    String assetPath = await copyAssetsToTempDirectory(path);
    return assetPath;
  }

  Future<String> copyAssetsToTempDirectory(String assetPath) async {
    ByteData data = await rootBundle.load(assetPath);
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = "${tempDir.path}/${assetPath.split('/').last}";
    File(tempPath).writeAsBytesSync(data.buffer.asUint8List());
    return tempPath;
  }

  void getAssetFile() async {
    _assetFilePath = await getAssetPath("assets/images/usuario.png");
  }

  ImageProvider<Object>? imageInternetLocal(String? imgPath) {
    ImageProvider<Object>? image;
    if (imgPath != null) {
      if (imgPath.startsWith("https")) {
        ImageProvider imgNetwork = CachedNetworkImageProvider(imgPath);
        image = imgNetwork;
      } else {
        image = FileImage(File(imgPath));
      }
      // notifyListeners();
    }
    return image;
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}
