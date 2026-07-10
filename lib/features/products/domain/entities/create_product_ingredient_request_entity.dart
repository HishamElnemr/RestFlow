import 'package:equatable/equatable.dart';

class CreateProductIngredientRequestEntity extends Equatable {
  const CreateProductIngredientRequestEntity({
    required this.inventoryItemId,
    required this.quantityRequired,
  });

  final String inventoryItemId;
  final double quantityRequired;

  Map<String, dynamic> toJson() {
    return {
      'inventoryItemId': inventoryItemId,
      'quantityRequired': quantityRequired,
    };
  }

  @override
  List<Object?> get props => [inventoryItemId, quantityRequired];
}
