<<<<<<< HEAD
  import 'package:flutter/foundation.dart';
=======
>>>>>>> daaf3ff007918d1d46173cf43c1035b9099f5f42
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:ecommerce_app/screens/auth_wrapper.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

<<<<<<< HEAD
const Color kRichBlack = Color(0xFF2C1810);
const Color kDarkRedBrown = Color(0xFF6B2C1A);
const Color kBrightPink = Color(0xFFFF10F0);
const Color kLightPink = Color(0xFFFF69B4);
const Color kOffWhite = Color(0xFFF5E6E0);
=======
const Color kRichBlack = Color(0xFF1D1F24);
const Color kBrown = Color(0xFF8B5E3C);
const Color kLightBrown = Color(0xFFD2B48C);
const Color kOffWhite = Color(0xFFF8F4F0);
>>>>>>> daaf3ff007918d1d46173cf43c1035b9099f5f42


void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

<<<<<<< HEAD
  if (kIsWeb) {
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  }
=======
  await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
>>>>>>> daaf3ff007918d1d46173cf43c1035b9099f5f42

  final cartProvider = CartProvider();

  runApp(
    ChangeNotifierProvider.value(
      value: cartProvider,
      child: const MyApp(),
    ),
  );

  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      title: 'TuneTrove',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: kDarkRedBrown,
          brightness: Brightness.light,
          primary: kDarkRedBrown,
          onPrimary: Colors.white,
          secondary: kBrightPink,
          onSecondary: Colors.white,
=======
      title: 'eCommerce App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: kBrown,
          brightness: Brightness.light,
          primary: kBrown,
          onPrimary: Colors.white,
          secondary: kLightBrown,
>>>>>>> daaf3ff007918d1d46173cf43c1035b9099f5f42
          background: kOffWhite,
        ),
        useMaterial3: true,

        scaffoldBackgroundColor: kOffWhite,

<<<<<<< HEAD
        textTheme: GoogleFonts.interTextTheme(
=======
        textTheme: GoogleFonts.latoTextTheme(
>>>>>>> daaf3ff007918d1d46173cf43c1035b9099f5f42
          Theme.of(context).textTheme,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
<<<<<<< HEAD
            backgroundColor: kDarkRedBrown,
=======
            backgroundColor: kBrown,
>>>>>>> daaf3ff007918d1d46173cf43c1035b9099f5f42
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
          labelStyle: TextStyle(color: kRichBlack.withOpacity(0.8)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
<<<<<<< HEAD
            borderSide: const BorderSide(color: kDarkRedBrown, width: 2.0),
=======
            borderSide: const BorderSide(color: kBrown, width: 2.0),
>>>>>>> daaf3ff007918d1d46173cf43c1035b9099f5f42
          ),
        ),

        cardTheme: CardThemeData(
          elevation: 1,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: kRichBlack,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: const AuthWrapper(),
    );
  }
}