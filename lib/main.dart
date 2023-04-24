import 'package:carritoapp/di_module.dart';
import 'package:carritoapp/shared/const/colors_const.dart';
import 'package:carritoapp/shared/router/app_router.dart';
import 'package:carritoapp/ui/login/cubit/auth_cubit.dart';
import 'package:carritoapp/ui/login/login_screen.dart';
import 'package:carritoapp/ui/products/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

Future<void> main() async {
  final di = GetIt.instance;
  await setupDependencyInjection(di);

  runApp(
    FutureBuilder(
      future: checkIfDependenciesAreInitialized(di),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => di.get<AuthCubit>()),
              BlocProvider(create: (_) => di.get<ProductCubit>()),
            ],
            child: MaterialApp(
              title: 'Challenge app',
              theme: ThemeData(
                primarySwatch: primarySwatch,
              ),
              debugShowCheckedModeBanner: false,
              onGenerateRoute: AppRouter.generateRoute,
              home: const LoginScreen(),
            ),
          );
        } else {
          return Container();
        }
      },
    ),
  );
}
