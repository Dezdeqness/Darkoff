import 'package:darkoff/data/models/item_api.dart';
import 'package:json_annotation/json_annotation.dart';

part 'items_response.g.dart';

@JsonSerializable(createToJson: false)
class ItemsResponse {
  const ItemsResponse({this.data = const ItemsData()});

  factory ItemsResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemsResponseFromJson(json);

  final ItemsData data;
}

@JsonSerializable(createToJson: false)
class ItemsData {
  const ItemsData({this.items = const {}, this.itemCategories = const {}});

  factory ItemsData.fromJson(Map<String, dynamic> json) =>
      _$ItemsDataFromJson(json);

  final Map<String, ItemApi> items;
  final Map<String, ItemCategoryApi> itemCategories;
}

@JsonSerializable(createToJson: false)
class ItemCategoryApi {
  const ItemCategoryApi({required this.id, this.name, this.normalizedName});

  factory ItemCategoryApi.fromJson(Map<String, dynamic> json) =>
      _$ItemCategoryApiFromJson(json);

  final String id;
  final String? name;
  final String? normalizedName;
}
