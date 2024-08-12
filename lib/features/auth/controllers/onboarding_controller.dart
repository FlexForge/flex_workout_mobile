import 'package:flex_workout_mobile/features/auth/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_controller.g.dart';

@riverpod
class OnboardingController extends _$OnboardingController {
  @override
  bool build() {
    final res = ref.watch(onboardingRepositoryProvider).getIsFirstLoad();

    final isFirstLoad = res.fold((l) => throw l, (r) => r);

    _updateIsFirstLoad(isFirstLoad);

    return isFirstLoad;
  }

  Future<void> setIsFirstLoad({required bool isFirstLoad}) async {
    final res = await ref
        .read(onboardingRepositoryProvider)
        .setIsFirstLoad(isFirstLoad: isFirstLoad);

    _updateIsFirstLoad(isFirstLoad);

    state = res.fold((l) => throw l, (r) => r);
  }

  void _updateIsFirstLoad(bool? isFirstLoad) {
    isFirstLoadListener.value = isFirstLoad ?? true;
  }
}
