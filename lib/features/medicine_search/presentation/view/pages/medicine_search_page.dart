import 'package:base_structure/core/domain/navigation/inavigation_controller.dart';
import 'package:base_structure/core/shared_widgets/basic_text_field.dart';
import 'package:base_structure/core/shared_widgets/common_scaffold.dart';
import 'package:base_structure/core/shared_widgets/inkwell/transparent_inkwell.dart';
import 'package:base_structure/core/shared_widgets/loadings/btn_loading.dart';
import 'package:base_structure/core/shared_widgets/spaces/custom_space.dart';
import 'package:base_structure/core/shared_widgets/texts/base_text.dart';
import 'package:base_structure/core/singletons/app_colors.dart';
import 'package:base_structure/core/singletons/font_sizes.dart';
import 'package:base_structure/core/singletons/font_weights.dart';
import 'package:base_structure/core/singletons/resource_path.dart';
import 'package:base_structure/core/utils.dart';

import 'package:base_structure/features/medicine_search/presentation/controller/medicine_search_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../data/models/medicine_res_model.dart';

class MedicineSearchPage extends StatefulWidget {
  const MedicineSearchPage({super.key});

  @override
  State<MedicineSearchPage> createState() => _MedicineSearchPageState();
}

class _MedicineSearchPageState extends State<MedicineSearchPage> {
  final ScrollController _scrollController = ScrollController();
  final medicineSearchController = Get.find<MedicineSearchController>();
  final navigationController = Get.find<INavigationController>();

  @override
  void initState() {
    super.initState();
    medicineSearchController.initHomepage();

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      medicineSearchController.fetchDrugsAsync();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "Find Medications",
      backGroundColor: AppColors.grey,
      child: Expanded(
        child: Column(
          children: [
            xLargeSpaceH(),
            BasicTextField(
              controller: medicineSearchController.searchController,
              hintTxt: "Search ...",
              icon: TransparentInkWell(
                onTap: () {
                  medicineSearchController.fetchDrugsAsync(reset: true);
                },
                child: Icon(
                  Icons.search,
                  color: AppColors.white,
                  size: 30.r,
                ),
              ),
            ),
            xSmallSpaceH(),
            Expanded(
              child: Obx(
                () => Visibility(
                  visible: medicineSearchController.isLoading.value &&
                      medicineSearchController.drugs.value.isEmpty,
                  replacement: RefreshIndicator(
                    onRefresh: () =>
                        medicineSearchController.fetchDrugsAsync(reset: true),
                    child: ListView.builder(
                      itemCount: medicineSearchController.drugs.value.length,
                      controller: _scrollController,
                      itemBuilder: (ctx, index) {
                        var drug = medicineSearchController.drugs.value[index];
                        return TransparentInkWell(
                          onTap: () {
                            medicineSearchController.selectedDrug = drug;
                          },
                          child: DrugItem(drug: drug),
                        );
                      },
                    ),
                  ),
                  child: Center(
                    child: Lottie.asset(ResourcePath.loading_icon),
                  ),
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: medicineSearchController.isLoading.value &&
                    medicineSearchController.drugs.value.isNotEmpty,
                child: BtnLoading(
                  width: 70.r,
                  height: 70.r,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrugItem extends StatelessWidget {
  final Result drug;

  const DrugItem({super.key, required this.drug});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        width: 1.sw,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
        margin: EdgeInsets.only(top: 20.h),
        decoration: BoxDecoration(
          color: Utils.getRandomColor(Utils.colors),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Icon(
              Icons.medical_information,
              size: 40.r,
            ),
            xSmallSpaceW(),
            Expanded(
              child: BaseText(
                drug.genericName,
                size: FontSizes.mid,
                textColor: AppColors.fontDark,
                fontWeight: FontWeights.semiBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
