import 'package:equatable/equatable.dart';

class UpdateProductIngredientRequestEntity extends Equatable {
  const UpdateProductIngredientRequestEntity({
    this.inventoryItemId,
    this.quantityRequired,
  });

  final String? inventoryItemId;
  final double? quantityRequired;

  @override
  List<Object?> get props => [inventoryItemId, quantityRequired];
}
