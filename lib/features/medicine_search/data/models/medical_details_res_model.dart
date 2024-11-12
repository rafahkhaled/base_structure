class MedicineDetailsResModel {
  final Meta? meta;
  final List<MedicineDetailsModel>? results;

  MedicineDetailsResModel({this.meta, this.results});

  factory MedicineDetailsResModel.fromJson(Map<String, dynamic> json) {
    return MedicineDetailsResModel(
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      results: json['results'] != null
          ? (json['results'] as List).map((item) => MedicineDetailsModel.fromJson(item)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meta': meta?.toJson(),
      'results': results?.map((result) => result.toJson()).toList(),
    };
  }
}

class Meta {
  final String? disclaimer;
  final String? terms;
  final String? license;
  final String? lastUpdated;


  Meta({
    this.disclaimer,
    this.terms,
    this.license,
    this.lastUpdated,
   
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      disclaimer: json['disclaimer'],
      terms: json['terms'],
      license: json['license'],
      lastUpdated: json['last_updated'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'disclaimer': disclaimer,
      'terms': terms,
      'license': license,
      'last_updated': lastUpdated,
      
    };
  }
}


class MedicineDetailsModel {
  final List<String>? splProductDataElements;
  final List<String>? activeIngredient;
  final List<String>? purpose;
  final List<String>? indicationsAndUsage;
  final List<String>? dosageAndAdministration;
  final List<String>? warnings;
  final List<String>? stopUse;
  final List<String>? pregnancyOrBreastFeeding;
  final List<String>? keepOutOfReachOfChildren;
  final List<String>? doNotUse;
  final List<String>? inactiveIngredient;
  final List<String>? storageAndHandling;
  final List<String>? questions;
  final List<String>? packageLabelPrincipalDisplayPanel;
  final String? setId;
  final String? id;
  final String? effectiveTime;
  final String? version;
  final OpenFda? openFda;

  MedicineDetailsModel({
    this.splProductDataElements,
    this.activeIngredient,
    this.purpose,
    this.indicationsAndUsage,
    this.dosageAndAdministration,
    this.warnings,
    this.stopUse,
    this.pregnancyOrBreastFeeding,
    this.keepOutOfReachOfChildren,
    this.doNotUse,
    this.inactiveIngredient,
    this.storageAndHandling,
    this.questions,
    this.packageLabelPrincipalDisplayPanel,
    this.setId,
    this.id,
    this.effectiveTime,
    this.version,
    this.openFda,
  });

  factory MedicineDetailsModel.fromJson(Map<String, dynamic> json) {
    return MedicineDetailsModel(
      splProductDataElements: json['spl_product_data_elements'] != null
          ? List<String>.from(json['spl_product_data_elements'])
          : null,
      activeIngredient: json['active_ingredient'] != null
          ? List<String>.from(json['active_ingredient'])
          : null,
      purpose: json['purpose'] != null ? List<String>.from(json['purpose']) : null,
      indicationsAndUsage: json['indications_and_usage'] != null
          ? List<String>.from(json['indications_and_usage'])
          : null,
      dosageAndAdministration: json['dosage_and_administration'] != null
          ? List<String>.from(json['dosage_and_administration'])
          : null,
      warnings: json['warnings'] != null ? List<String>.from(json['warnings']) : null,
      stopUse: json['stop_use'] != null ? List<String>.from(json['stop_use']) : null,
      pregnancyOrBreastFeeding: json['pregnancy_or_breast_feeding'] != null
          ? List<String>.from(json['pregnancy_or_breast_feeding'])
          : null,
      keepOutOfReachOfChildren: json['keep_out_of_reach_of_children'] != null
          ? List<String>.from(json['keep_out_of_reach_of_children'])
          : null,
      doNotUse: json['do_not_use'] != null ? List<String>.from(json['do_not_use']) : null,
      inactiveIngredient: json['inactive_ingredient'] != null
          ? List<String>.from(json['inactive_ingredient'])
          : null,
      storageAndHandling: json['storage_and_handling'] != null
          ? List<String>.from(json['storage_and_handling'])
          : null,
      questions: json['questions'] != null ? List<String>.from(json['questions']) : null,
      packageLabelPrincipalDisplayPanel: json['package_label_principal_display_panel'] != null
          ? List<String>.from(json['package_label_principal_display_panel'])
          : null,
      setId: json['set_id'],
      id: json['id'],
      effectiveTime: json['effective_time'],
      version: json['version'],
      openFda: json['openfda'] != null ? OpenFda.fromJson(json['openfda']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'spl_product_data_elements': splProductDataElements,
      'active_ingredient': activeIngredient,
      'purpose': purpose,
      'indications_and_usage': indicationsAndUsage,
      'dosage_and_administration': dosageAndAdministration,
      'warnings': warnings,
      'stop_use': stopUse,
      'pregnancy_or_breast_feeding': pregnancyOrBreastFeeding,
      'keep_out_of_reach_of_children': keepOutOfReachOfChildren,
      'do_not_use': doNotUse,
      'inactive_ingredient': inactiveIngredient,
      'storage_and_handling': storageAndHandling,
      'questions': questions,
      'package_label_principal_display_panel': packageLabelPrincipalDisplayPanel,
      'set_id': setId,
      'id': id,
      'effective_time': effectiveTime,
      'version': version,
      'openfda': openFda?.toJson(),
    };
  }
}

class OpenFda {
  final List<String>? brandName;
  final List<String>? genericName;
  final List<String>? manufacturerName;
  final List<String>? productNdc;
  final List<String>? productType;
  final List<String>? route;
  final List<String>? substanceName;
  final List<String>? splId;
  final List<String>? splSetId;
  final List<String>? packageNdc;
  final List<bool>? isOriginalPackager;
  final List<String>? unii;

  OpenFda({
    this.brandName,
    this.genericName,
    this.manufacturerName,
    this.productNdc,
    this.productType,
    this.route,
    this.substanceName,
    this.splId,
    this.splSetId,
    this.packageNdc,
    this.isOriginalPackager,
    this.unii,
  });

  factory OpenFda.fromJson(Map<String, dynamic> json) {
    return OpenFda(
      brandName: json['brand_name'] != null ? List<String>.from(json['brand_name']) : null,
      genericName: json['generic_name'] != null ? List<String>.from(json['generic_name']) : null,
      manufacturerName: json['manufacturer_name'] != null ? List<String>.from(json['manufacturer_name']) : null,
      productNdc: json['product_ndc'] != null ? List<String>.from(json['product_ndc']) : null,
      productType: json['product_type'] != null ? List<String>.from(json['product_type']) : null,
      route: json['route'] != null ? List<String>.from(json['route']) : null,
      substanceName: json['substance_name'] != null ? List<String>.from(json['substance_name']) : null,
      splId: json['spl_id'] != null ? List<String>.from(json['spl_id']) : null,
      splSetId: json['spl_set_id'] != null ? List<String>.from(json['spl_set_id']) : null,
      packageNdc: json['package_ndc'] != null ? List<String>.from(json['package_ndc']) : null,
      isOriginalPackager: json['is_original_packager'] != null ? List<bool>.from(json['is_original_packager']) : null,
      unii: json['unii'] != null ? List<String>.from(json['unii']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brand_name': brandName,
      'generic_name': genericName,
      'manufacturer_name': manufacturerName,
      'product_ndc': productNdc,
      'product_type': productType,
      'route': route,
      'substance_name': substanceName,
      'spl_id': splId,
      'spl_set_id': splSetId,
      'package_ndc': packageNdc,
      'is_original_packager': isOriginalPackager,
      'unii': unii,
    };
  }
}
