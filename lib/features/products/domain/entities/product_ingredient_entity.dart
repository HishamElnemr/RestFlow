import 'package:equatable/equatable.dart';

class ProductIngredientEntity extends Equatable {
  const ProductIngredientEntity({
    required this.inventoryItemName,
    required this.quantityRequired,
  });

  final String inventoryItemName;
  final double quantityRequired;

  @override
  List<Object?> get props => [inventoryItemName, quantityRequired];
}
