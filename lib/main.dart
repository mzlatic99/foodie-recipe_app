import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/services/storage/hive_storage_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'constants/app_constants.dart';
import 'features/authentification/data/auth_repository.dart';
import 'features/challenges/domain/challenge.dart';
import 'features/recipes/domain/recipe.dart';
import 'features/recipes/domain/recipe_ingredients/component.dart';
import 'features/recipes/domain/recipe_ingredients/ingredient.dart';
import 'features/recipes/domain/recipe_ingredients/measurement.dart';
import 'features/recipes/domain/recipe_ingredients/section.dart';
import 'features/recipes/domain/recipe_ingredients/unit.dart';
import 'features/recipes/domain/recipe_instruction/recipe_instruction.dart';
import 'features/rewards/domain/reward.dart';
import 'firebase_options.dart';
import 'providers/providers.dart';
import 'router/app_router.dart';
import 'theme/theme.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

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
  Hive.registerAdapter(ChallengeAdapter());
  Hive.registerAdapter(RewardAdapter());
  final hiveStorageService = HiveStorageService();

  final user = AuthRepository(FirebaseAuth.instance).currentUser;
  if (user != null) {
    hiveStorageService.user = user.email!;
    if (!hiveStorageService.isBoxOpen(StorageBox.favoritesBox)) {
      await hiveStorageService.openBox<Recipe>(StorageBox.favoritesBox);
    }
    if (!hiveStorageService.isBoxOpen(StorageBox.challengesBox)) {
      await hiveStorageService.openBox<Challenge>(StorageBox.challengesBox);
    }
    if (!hiveStorageService.isBoxOpen(StorageBox.pointsBox)) {
      await hiveStorageService.openBox<int>(StorageBox.pointsBox);
    }
    if (!hiveStorageService.isBoxOpen(StorageBox.rewardsBox)) {
      await hiveStorageService.openBox<Reward>(StorageBox.rewardsBox);
    }
  }

  runApp(
    ProviderScope(
      overrides: [storageServiceProvider.overrideWithValue(hiveStorageService)],
      child: const Foodie(),
    ),
  );

  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };
}

// ignore: must_be_immutable
class Foodie extends StatelessWidget {
  const Foodie({Key? key}) : super(key: key);

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
          routeInformationProvider: goRouter.routeInformationProvider,
        );
      },
    );
  }
}
