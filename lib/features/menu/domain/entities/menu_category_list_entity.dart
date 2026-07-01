import 'package:equatable/equatable.dart';

class MenuCategoryListEntity extends Equatable {
  const MenuCategoryListEntity({
    required this.id,
    required this.categoryName,
    this.description,
    required this.displayOrder,
  });

  final String id;
  final String categoryName;
  final String? description;
  final int displayOrder;

  @override
  List<Object?> get props => [id, categoryName, description, displayOrder];
}
