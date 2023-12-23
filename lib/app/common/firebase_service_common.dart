import 'package:control_asistencia_app/app/packages/packages_pub.dart';

class FirebaseServiceCommon {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  FirebaseServiceCommon(
      {FirebaseFirestore? firestore,
      FirebaseAuth? firebaseAuth,
      FirebaseStorage? firebaseStorage}) {
    _firestore = firestore!;
    _firebaseAuth = firebaseAuth!;
    _firebaseStorage = firebaseStorage!;
  }

  FirebaseFirestore get firestore => _firestore;
  FirebaseAuth get firebaseAuth => _firebaseAuth;
  FirebaseStorage get firebaseStorage => _firebaseStorage;
}
