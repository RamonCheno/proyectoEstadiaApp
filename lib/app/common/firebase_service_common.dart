import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseServiceCommon {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  FirebaseFirestore get firestore => _firestore;
  FirebaseAuth get firebaseAuth => _firebaseAuth;
  FirebaseStorage get firebaseStorage => _firebaseStorage;
}
