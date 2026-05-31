import 'package:equatable/equatable.dart';

class InventoryCategoryEntity extends Equatable {
  const InventoryCategoryEntity({required this.id, required this.categoryName});

  final String id;
  final String categoryName;

  @override
  List<Object?> get props => [id, categoryName];
}
