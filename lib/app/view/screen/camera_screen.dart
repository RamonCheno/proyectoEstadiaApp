import 'dart:io';

import 'package:camera/camera.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/view/provider/image_provider.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});
  static const route = "/cameraScreen";

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    final cameraProvider = Provider.of<ImageProviders>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Captura de Cámara'),
      ),
      body: FutureBuilder(
        future: cameraProvider.initializeCamera(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CameraPreview(cameraProvider.cameraController),
                IconButton(
                  iconSize: 40,
                  onPressed: () async {
                    await cameraProvider.takePicture();
                    if (!mounted) return;
                    File image = cameraProvider.image;
                    Navigator.pop(context, image);
                  },
                  icon: const Icon(Icons.camera),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
