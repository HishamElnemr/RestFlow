import 'package:equatable/equatable.dart';

class AddProductIngredientRequestEntity extends Equatable {
  const AddProductIngredientRequestEntity({
    required this.productId,
    required this.inventoryItemId,
    required this.quantityRequired,
  });

  final String productId;
  final String inventoryItemId;
  final double quantityRequired;

  @override
  List<Object?> get props => [productId, inventoryItemId, quantityRequired];
}
