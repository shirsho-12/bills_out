import 'package:bills_out/routes.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'loading/loading_screen.dart';
import 'services/auth/bloc/auth.dart';
import 'services/auth/firebase_auth_provider.dart';
import 'views/auth/auth.dart';
import 'views/home/home_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'CodeXeR',
    debugShowCheckedModeBanner: false,
    theme: FlexThemeData.light(
      scheme: FlexScheme.greyLaw,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 20,
      lightIsWhite: true,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
        outlinedButtonRadius: 10.0,
        bottomSheetRadius: 10.0,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      // swapLegacyOnMaterial3: true,
      // To use the playground font, add GoogleFonts package and uncomment
      // fontFamily: GoogleFonts.notoSans().fontFamily,
    ),
    themeMode: ThemeMode.light,

    darkTheme: FlexThemeData.dark(
      scheme: FlexScheme.greyLaw,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 15,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        outlinedButtonRadius: 10.0,
        bottomSheetRadius: 10.0,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      fontFamily: GoogleFonts.rubik().fontFamily,
      // swapLegacyOnMaterial3: true,
      // To use the Playground font, add GoogleFonts package and uncomment
      // fontFamily: GoogleFonts.notoSans().fontFamily,
    ),
    home: BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(FirebaseAuthProvider()),
      child: const HomePage(),
    ),
    // routes: const {
    //   // createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
    // },
    onGenerateRoute: RouteGenerator.generateRoute,
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state.isLoading) {
        LoadingScreen().show(
            context: context,
            text: state.loadingText ?? "Please wait a moment");
      } else {
        LoadingScreen().hide();
      }
    }, builder: ((context, state) {
      // return const LoginView();
      if (state is AuthStateLoggedIn) {
        // context.read<AuthBloc>().add(const AuthEventLogOut());
        return const HomeView();
      } else if (state is AuthStateRegistering) {
        return const RegisterView();
      } else if (state is AuthStateNeedsVerification) {
        return const VerifyEmailView();
      } else if (state is AuthStateLoggedOut) {
        return const LoginView();
      } else if (state is AuthStateForgotPassword) {
        return const ForgotPasswordView();
      } else {
        return const Scaffold(
          body: CircularProgressIndicator(),
        );
      }
    }));
  }
}
