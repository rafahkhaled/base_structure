class MedicineResModel {
  final Meta? meta;
  final List<Result>? results;

  MedicineResModel({this.meta, this.results});

  factory MedicineResModel.fromJson(Map<String, dynamic> json) {
    return MedicineResModel(
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      results: json['results'] != null
          ? (json['results'] as List).map((item) => Result.fromJson(item)).toList()
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
  final Results? results;

  Meta({
    this.disclaimer,
    this.terms,
    this.license,
    this.lastUpdated,
    this.results,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      disclaimer: json['disclaimer'],
      terms: json['terms'],
      license: json['license'],
      lastUpdated: json['last_updated'],
      results: json['results'] != null ? Results.fromJson(json['results']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'disclaimer': disclaimer,
      'terms': terms,
      'license': license,
      'last_updated': lastUpdated,
      'results': results?.toJson(),
    };
  }
}

class Results {
  final int? skip;
  final int? limit;
  final int? total;

  Results({
    this.skip,
    this.limit,
    this.total,
  });

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      skip: json['skip'],
      limit: json['limit'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'skip': skip,
      'limit': limit,
      'total': total,
    };
  }
}

class Result {
  final String? productNdc;
  final String? genericName;
  final String? labelerName;
  final String? brandName;
  final String? brandNameSuffix;
  final List<ActiveIngredient>? activeIngredients;
  final bool? finished;
  final List<Packaging>? packaging;
  final String? listingExpirationDate;
  final OpenFda? openFda;
  final String? marketingCategory;
  final String? dosageForm;
  final String? splId;
  final String? productType;
  final List<String>? route;
  final String? marketingStartDate;
  final String? productId;
  final String? applicationNumber;
  final String? brandNameBase;
  final List<String>? pharmClass;

  Result({
    this.productNdc,
    this.genericName,
    this.labelerName,
    this.brandName,
    this.brandNameSuffix,
    this.activeIngredients,
    this.finished,
    this.packaging,
    this.listingExpirationDate,
    this.openFda,
    this.marketingCategory,
    this.dosageForm,
    this.splId,
    this.productType,
    this.route,
    this.marketingStartDate,
    this.productId,
    this.applicationNumber,
    this.brandNameBase,
    this.pharmClass,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      productNdc: json['product_ndc'],
      genericName: json['generic_name'],
      labelerName: json['labeler_name'],
      brandName: json['brand_name'],
      brandNameSuffix: json['brand_name_suffix'],
      activeIngredients: json['active_ingredients'] != null
          ? (json['active_ingredients'] as List)
              .map((item) => ActiveIngredient.fromJson(item))
              .toList()
          : null,
      finished: json['finished'],
      packaging: json['packaging'] != null
          ? (json['packaging'] as List)
              .map((item) => Packaging.fromJson(item))
              .toList()
          : null,
      listingExpirationDate: json['listing_expiration_date'],
      openFda: json['openfda'] != null ? OpenFda.fromJson(json['openfda']) : null,
      marketingCategory: json['marketing_category'],
      dosageForm: json['dosage_form'],
      splId: json['spl_id'],
      productType: json['product_type'],
      route: json['route'] != null ? List<String>.from(json['route']) : null,
      marketingStartDate: json['marketing_start_date'],
      productId: json['product_id'],
      applicationNumber: json['application_number'],
      brandNameBase: json['brand_name_base'],
      pharmClass: json['pharm_class'] != null ? List<String>.from(json['pharm_class']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_ndc': productNdc,
      'generic_name': genericName,
      'labeler_name': labelerName,
      'brand_name': brandName,
      'brand_name_suffix': brandNameSuffix,
      'active_ingredients': activeIngredients?.map((ingredient) => ingredient.toJson()).toList(),
      'finished': finished,
      'packaging': packaging?.map((pkg) => pkg.toJson()).toList(),
      'listing_expiration_date': listingExpirationDate,
      'openfda': openFda?.toJson(),
      'marketing_category': marketingCategory,
      'dosage_form': dosageForm,
      'spl_id': splId,
      'product_type': productType,
      'route': route,
      'marketing_start_date': marketingStartDate,
      'product_id': productId,
      'application_number': applicationNumber,
      'brand_name_base': brandNameBase,
      'pharm_class': pharmClass,
    };
  }
}

class ActiveIngredient {
  final String? name;
  final String? strength;

  ActiveIngredient({
    this.name,
    this.strength,
  });

  factory ActiveIngredient.fromJson(Map<String, dynamic> json) {
    return ActiveIngredient(
      name: json['name'],
      strength: json['strength'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'strength': strength,
    };
  }
}

class Packaging {
  final String? packageNdc;
  final String? description;
  final String? marketingStartDate;
  final bool? sample;

  Packaging({
    this.packageNdc,
    this.description,
    this.marketingStartDate,
    this.sample,
  });

  factory Packaging.fromJson(Map<String, dynamic> json) {
    return Packaging(
      packageNdc: json['package_ndc'],
      description: json['description'],
      marketingStartDate: json['marketing_start_date'],
      sample: json['sample'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'package_ndc': packageNdc,
      'description': description,
      'marketing_start_date': marketingStartDate,
      'sample': sample,
    };
  }
}

class OpenFda {
  final List<String>? manufacturerName;
  final List<String>? rxcui;
  final List<String>? splSetId;
  final List<bool>? isOriginalPackager;
  final List<String>? upc;
  final List<String>? unii;

  OpenFda({
    this.manufacturerName,
    this.rxcui,
    this.splSetId,
    this.isOriginalPackager,
    this.upc,
    this.unii,
  });

  factory OpenFda.fromJson(Map<String, dynamic> json) {
    return OpenFda(
      manufacturerName: json['manufacturer_name'] != null ? List<String>.from(json['manufacturer_name']) : null,
      rxcui: json['rxcui'] != null ? List<String>.from(json['rxcui']) : null,
      splSetId: json['spl_set_id'] != null ? List<String>.from(json['spl_set_id']) : null,
      isOriginalPackager: json['is_original_packager'] != null ? List<bool>.from(json['is_original_packager']) : null,
      upc: json['upc'] != null ? List<String>.from(json['upc']) : null,
      unii: json['unii'] != null ? List<String>.from(json['unii']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'manufacturer_name': manufacturerName,
      'rxcui': rxcui,
      'spl_set_id': splSetId,
      'is_original_packager': isOriginalPackager,
      'upc': upc,
      'unii': unii,
    };
  }
}
