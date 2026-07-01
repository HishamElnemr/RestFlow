import 'package:equatable/equatable.dart';

class CreateProductIngredientEntity extends Equatable {
  const CreateProductIngredientEntity({
    required this.inventoryItemId,
    required this.quantityRequired,
  });

  final String inventoryItemId;
  final double quantityRequired;

  @override
  List<Object?> get props => [inventoryItemId, quantityRequired];
}
