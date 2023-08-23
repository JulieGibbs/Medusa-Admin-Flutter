import 'index.dart';


class ProductCollection {
  String? id;
  String? title;
  String? handle;
  List<Product>? products;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  Map<String, dynamic>? metadata;

  ProductCollection({
    this.id,
    required this.title,
    this.handle,
    this.products,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.metadata,
  });

  ProductCollection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    handle = json['handle'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products']
          .forEach((e) => products!.add(Product.fromJson(e)));
    }
    createdAt = DateTime.tryParse(json['created_at'] ?? '')?.toLocal();
    updatedAt = DateTime.tryParse(json['updated_at'] ?? '')?.toLocal();
    deletedAt = DateTime.tryParse(json['deleted_at'] ?? '')?.toLocal();
    metadata = json['metadata'] ;
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};
    json['id'] = id;
    json['title'] = title;
    json['handle'] = handle;
    json['products'] = products?.map((e) => e.toJson()).toList() ?? [];
    json['created_at'] = createdAt.toString();
    json['updated_at'] = updatedAt.toString();
    json['deleted_at'] = deletedAt.toString();
    json['metadata'] = metadata;
    return json;
  }
}
