import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../saving_rhythm/Controller/saving_rhythm_controller.dart';
import '../model/buddy_model.dart';

class BuddyController extends GetxController {
  // dynamic list
  final buddies = <BuddyModel>[].obs;

  // selected buddy id
  final selectedBuddyId = RxnString();

  @override
  void onInit() {
    super.onInit();
    _loadLocalBuddies();
    // for now local; later replace with api
  }

  void _loadLocalBuddies() {
    final colors = <Color>[
      AppColors.tileYellow,
      AppColors.tileLilac,
      AppColors.tilePeach,
      AppColors.tileMint,
      AppColors.tileGrey,
      AppColors.tilePink,
    ];

    final local = <BuddyModel>[
      BuddyModel(id: 'luca',  name: 'Luca',  avatarAsset: AppAssets.luca,  bgColor: colors[0]),
      BuddyModel(id: 'drew',  name: 'Drew',  avatarAsset: AppAssets.drew,  bgColor: colors[1]),
      BuddyModel(id: 'fred',  name: 'Fred',  avatarAsset: AppAssets.fred,  bgColor: colors[2]),
      BuddyModel(id: 'peter', name: 'Peter', avatarAsset: AppAssets.peter, bgColor: colors[3]),
      BuddyModel(id: 'benny', name: 'Benny', avatarAsset: AppAssets.bunny, bgColor: colors[4]),
      BuddyModel(id: 'wally', name: 'Wally', avatarAsset: AppAssets.wally, bgColor: colors[5]),
    ];

    buddies.assignAll(local);
  }

  void selectBuddy(String id) {
    selectedBuddyId.value = id;
  }

  BuddyModel? get selectedBuddy {
    final id = selectedBuddyId.value;
    if (id == null) return null;
    return buddies.firstWhereOrNull((b) => b.id == id);
  }

  // ✅ future: backend fetch
  Future<void> fetchBuddiesFromApi() async {
    // TODO: call service -> parse list -> buddies.assignAll(parsed)
    // keep same model so backend integration is smooth.
  }

  void onContinue() {
    final buddyId = selectedBuddyId.value;
    if (buddyId == null) return;

    final selectedBuddy = buddies.firstWhere((b) => b.id == buddyId);

    // ✅ IMPORTANT: Purana controller hatao taake naya arguments read kare
    if (Get.isRegistered<SavingRhythmController>()) {
      Get.delete<SavingRhythmController>(force: true);
    }

    Get.toNamed(
      AppRoutes.savingRhythm,
      arguments: selectedBuddy,
    );
  }
}
