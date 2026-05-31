import 'package:equatable/equatable.dart';

class InventoryCategoryListEntity extends Equatable {
  const InventoryCategoryListEntity({
    required this.id,
    required this.categoryName,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  final String id;
  final String categoryName;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  @override
  List<Object?> get props => [
    id,
    categoryName,
    createdAt,
    updatedAt,
    deletedAt,
  ];
}
