import 'package:equatable/equatable.dart';

class InventoryCategoryResponseEntity extends Equatable {
  const InventoryCategoryResponseEntity({
    required this.id,
    required this.categoryName,
    required this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String categoryName;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => [id, categoryName, createdAt, updatedAt];
}
