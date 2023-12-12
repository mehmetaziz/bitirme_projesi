import 'package:bitirme_projesi/ui/cubit/anasayfa_cubit.dart';
import 'package:bitirme_projesi/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:bitirme_projesi/ui/cubit/urun_sayfa_cubit.dart';
import 'package:bitirme_projesi/ui/views/anasayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AnasayfaCubit(),),
        BlocProvider(create: (context) => SepetSayfaCubit(),),
        BlocProvider(create: (context) => UrunSayfaCubit(),),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          brightness: Brightness.light,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(useMaterial3: true,
        brightness: Brightness.dark),
        themeMode: ThemeMode.system,
        home: Anasayfa(),
      ),
    );
  }
}


