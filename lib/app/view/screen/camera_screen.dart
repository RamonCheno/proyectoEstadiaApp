import 'package:control_asistencia_app/app/packages/packagelocal_provider.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';

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
        builder: (BuildContext futureContext, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CameraPreview(cameraProvider.cameraController),
                IconButton(
                  iconSize: 40,
                  onPressed: () {
                    cameraProvider.takePicture().then((value) {
                      String imagePath = value;
                      Navigator.pop(context, imagePath);
                    });
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
