import 'package:flex_workout_mobile/bootstrap.dart';
import 'package:flex_workout_mobile/db/objectbox.g.dart';
import 'package:flex_workout_mobile/features/auth/controllers/onboarding_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'providers.g.dart';

PackageInfo packageInfo = PackageInfo(
  appName: '',
  packageName: '',
  version: '',
  buildNumber: '',
);

@riverpod
Store objectBoxStore(ObjectBoxStoreRef ref) {
  return objectBox.store;
}

@Riverpod(keepAlive: true)
FutureOr<SharedPreferences> sharedPreferences(SharedPreferencesRef ref) {
  return SharedPreferences.getInstance();
}

Future<void> initializeProviders(ProviderContainer container) async {
  await container.read(sharedPreferencesProvider.future);

  packageInfo = await PackageInfo.fromPlatform();

  container.read(onboardingControllerProvider);
}
