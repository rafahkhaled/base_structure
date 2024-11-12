import 'package:base_structure/core/helpers/loadable_models/loadable_object.dart';
import 'package:base_structure/core/models/pagination_model.dart';

import 'package:base_structure/features/medicine_search/data/models/medical_details_res_model.dart';
import 'package:base_structure/features/medicine_search/data/models/medicine_res_model.dart';
import 'package:base_structure/features/medicine_search/domain/i_medicine_search_repo.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicineSearchController extends GetxController {
  final IMedicineSearchRepo medicineSearchRepo;

  MedicineSearchController({
    required this.medicineSearchRepo,
  });

  TextEditingController searchController = TextEditingController();
  var isLoading = false.obs;
  var hasMore = true.obs;
  var noResultsFound =
      false.obs; // Tracks if no results were found for the search.

  Result selectedDrug = Result();

  var medicineDetailsModel = Rx<LoadableObject<MedicineDetailsModel>>(
      LoadableObject<MedicineDetailsModel>());
  Rx<List<Result>> drugs = Rx<List<Result>>([]);

  Rx<PaginationModel> paginationModel = PaginationModel().obs;

  @override
  void onInit() {
    // Adding debounce to search input to limit API calls
    debounce(
      searchController.text.obs,
      (_) => fetchDrugsAsync(reset: true),
      time: const Duration(milliseconds: 500),
    );
    super.onInit();
  }

  Future<void> fetchDrugsAsync({bool reset = false}) async {
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;

    if (reset) {
      resetSearch(); // Reset pagination and clear previous results
    }

    try {
      final response = await medicineSearchRepo.searchMedicineSearchAsync(
        searchController.text,
        skip: paginationModel.value.skip,
        take: paginationModel.value.limit,
      );

      final newDrugs = response.data?.results ?? [];
      if (newDrugs.isEmpty) {
        hasMore.value = false;
        noResultsFound.value =
            drugs.value.isEmpty; // Show 'No Results' if initial load is empty
      } else {
        drugs.value.addAll(newDrugs);
        paginationModel.update((val) {
          val?.skip += val.limit;
        });
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load data. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

  void resetSearch() {
    paginationModel.value = PaginationModel();
    drugs.value.clear();
    hasMore.value = true;
    noResultsFound.value = false;
  }

  Future<void> initHomepage() async {
    await Future.delayed(Duration.zero);
    searchController.clear();
    await fetchDrugsAsync(reset: true);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
