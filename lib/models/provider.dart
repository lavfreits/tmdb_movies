class Provider {
  final int providerId;
  final String providerName;

  Provider({
    required this.providerId,
    required this.providerName,
  });

  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      providerId: json['provider_id'],
      providerName: json['provider_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'provider_id': providerId,
      'provider_name': providerName,
    };
  }
}

class CountryProviders {
  final List<Provider> flatrate;
  final List<Provider> buy;
  final List<Provider> rent;

  CountryProviders({
    required this.flatrate,
    required this.buy,
    required this.rent,
  });

  factory CountryProviders.fromJson(Map<String, dynamic> json) {
    return CountryProviders(
      flatrate: (json['flatrate'] as List<dynamic>?)
              ?.map((e) => Provider.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      buy: (json['buy'] as List<dynamic>?)
              ?.map((e) => Provider.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      rent: (json['rent'] as List<dynamic>?)
              ?.map((e) => Provider.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flatrate': flatrate.map((provider) => provider.toJson()).toList(),
      'buy': buy.map((provider) => provider.toJson()).toList(),
      'rent': rent.map((provider) => provider.toJson()).toList(),
    };
  }
}
