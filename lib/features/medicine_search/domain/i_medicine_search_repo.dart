import 'package:base_structure/core/data/network/api_response.dart';
import 'package:base_structure/features/medicine_search/data/models/medical_details_res_model.dart';
import 'package:base_structure/features/medicine_search/data/models/medicine_res_model.dart';

abstract class IMedicineSearchRepo {
  Future<ApiResponse<MedicineResModel>> searchMedicineSearchAsync(
      String medName,
      {int take = 10,
      int skip = 0});
  Future<ApiResponse<MedicineDetailsModel>> getMedicineDetails(String ndc);
}
