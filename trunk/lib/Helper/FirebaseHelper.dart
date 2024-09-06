import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


class FirebaseHelper{
  static  FirebaseAuth auth=FirebaseAuth.instance;
  static FirebaseOptions firebaseOptions= const FirebaseOptions(
      apiKey: "AIzaSyAg9KldIM-UW3sOgyl7dZ2Nu1r9Q-8cLN4",
      appId: "1:206996905275:android:633386410a0c0aa9c9eb1e",
      projectId: "symbaa-4f8a9",
      messagingSenderId: "206996905275",
      storageBucket: 'symbaa-4f8a9.appspot.com',
      iosBundleId: "com.symbaa.app"
  );
}