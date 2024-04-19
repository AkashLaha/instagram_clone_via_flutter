import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/Screens/login_screen.dart';
import 'package:insta_clone/Screens/sign_up_screen.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/reponsive/mobile_screen_layout.dart';
import 'package:insta_clone/reponsive/responsive_layout_screen.dart';
import 'package:insta_clone/reponsive/web_screen_layout.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDHtr39iR0R-uUvoANYNly6EkHrd_OFCWU",
          appId: "1:410386619289:web:4ed790d84e8dab44fd5108",
          messagingSenderId: "410386619289",
          projectId: "instagram-clone-9a9de",
          storageBucket: "instagram-clone-9a9de.appspot.com"),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
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
        title: 'Instagram Clone',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
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
