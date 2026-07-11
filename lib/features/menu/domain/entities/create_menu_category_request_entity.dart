import 'package:equatable/equatable.dart';

class CreateMenuCategoryRequestEntity extends Equatable {
  const CreateMenuCategoryRequestEntity({
    required this.categoryName,
    this.description,
    this.displayOrder,
  });

  final String categoryName;
  final String? description;
  final int? displayOrder;

  @override
  List<Object?> get props => [categoryName, description, displayOrder];
}
