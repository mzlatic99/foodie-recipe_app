import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/services/storage/hive_storage_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/recipes/domain/recipe.dart';
import 'features/recipes/domain/recipe_ingredients/component.dart';
import 'features/recipes/domain/recipe_ingredients/ingredient.dart';
import 'features/recipes/domain/recipe_ingredients/measurement.dart';
import 'features/recipes/domain/recipe_ingredients/section.dart';
import 'features/recipes/domain/recipe_ingredients/unit.dart';
import 'features/recipes/domain/recipe_instruction/recipe_instruction.dart';
import 'firebase_options.dart';
import 'providers/providers.dart';
import 'router/app_router.dart';
import 'theme/theme.dart';

const favoritesBox = 'favorite_recipes';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));

  await Hive.initFlutter();
  Hive.registerAdapter(RecipeAdapter());
  Hive.registerAdapter(RecipeInstructionAdapter());
  Hive.registerAdapter(SectionAdapter());
  Hive.registerAdapter(ComponentAdapter());
  Hive.registerAdapter(IngredientAdapter());
  Hive.registerAdapter(MeasurementAdapter());
  Hive.registerAdapter(UnitAdapter());
  final hiveStorageService = HiveStorageService();
  await hiveStorageService.openBox(favoritesBox);

  runApp(
    ProviderScope(
      overrides: [
        storageServiceProvider.overrideWith((ref) => hiveStorageService)
      ],
      child: const Foodie(),
    ),
  );
}

// ignore: must_be_immutable
class Foodie extends StatelessWidget {
  const Foodie({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final goRouter = ref.watch(goRouterProvider);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Foodie Recipe App',
          theme: AppThemes.primary(),
          routerDelegate: goRouter.routerDelegate,
          routeInformationParser: goRouter.routeInformationParser,
        );
      },
    );
  }
}
