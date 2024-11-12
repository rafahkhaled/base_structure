import 'package:base_structure/core/data/network/api_response.dart';
import 'package:base_structure/core/network/i_network_service.dart';
import 'package:base_structure/features/medicine_search/data/models/medical_details_res_model.dart';
import 'package:base_structure/features/medicine_search/data/models/medicine_res_model.dart';
import 'package:base_structure/features/medicine_search/domain/i_medicine_search_repo.dart';
import 'package:dio/dio.dart';

class MedicineSearchRepo implements IMedicineSearchRepo {
  final INetworkService networkService;
  MedicineSearchRepo({required this.networkService});
  @override
  Future<ApiResponse<MedicineResModel>> searchMedicineSearchAsync(
    String medName, {
    int take = 10,
    int skip = 0,
  }) async {
    try {
      var response = await networkService.get(
          "https://api.fda.gov/drug/ndc.json?search=${medName.isEmpty ? "" : "generic_name:$medName"}&limit=$take&skip=$skip");

      return ApiResponse<MedicineResModel>(
          data: MedicineResModel.fromJson(response), msg: "Success");
    } on DioException catch (_) {
      return ApiResponse<MedicineResModel>(exception: _, msg: "Error");
    }
  }

  @override
  Future<ApiResponse<MedicineDetailsModel>> getMedicineDetails(
      String ndc) async {
    try {
      var response = await networkService.get(
          "https://api.fda.gov/drug/label.json?search=openfda.product_ndc:$ndc");

      return ApiResponse<MedicineDetailsModel>(
          data: MedicineDetailsResModel.fromJson(response).results!.first,
          msg: "Success");
    } on DioException catch (_) {
      throw ApiResponse<MedicineDetailsModel>(exception: _, msg: "Error");
    }
  }
}
