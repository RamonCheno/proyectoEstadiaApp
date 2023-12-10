import 'package:control_asistencia_app/app/packages/packages_pub.dart';

class FirebaseServiceCommon {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  FirebaseFirestore get firestore => _firestore;
  FirebaseAuth get firebaseAuth => _firebaseAuth;
  FirebaseStorage get firebaseStorage => _firebaseStorage;
}
