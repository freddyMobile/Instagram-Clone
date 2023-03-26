import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_instagram_clone/providers/user_provider.dart';
import 'package:flutter_instagram_clone/resources/auth_methods.dart';
import 'package:flutter_instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:flutter_instagram_clone/responsive/responsive_screen_layout.dart';
import 'package:flutter_instagram_clone/responsive/web_screen_layout.dart';
import 'package:flutter_instagram_clone/screens/login_screen.dart';
import 'package:flutter_instagram_clone/screens/signup_screen.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBLYPkhNkeOMMuqrmzGTmj_KGQTlluZgaA",
            appId: "1:487582615587:web:f8f0de86ce8ca4c45dc996",
            messagingSenderId: "487582615587",
            projectId: "instagram-clone-e1218",
            storageBucket: "instagram-clone-e1218.appspot.com"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram clone',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                    webScreenLayout: WebScreenLayout(),
                    mobileScreenLayout: MobileScreenLayout());
              } else if (snapshot.hasError) {
                //take out ! sign from this block
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }

            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
