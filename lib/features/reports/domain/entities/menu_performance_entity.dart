import 'package:equatable/equatable.dart';

class MenuPerformanceEntity extends Equatable {
  const MenuPerformanceEntity({
    required this.productId,
    required this.productName,
    required this.quantitySold,
  });

  final String productId;
  final String productName;
  final double quantitySold;

  @override
  List<Object?> get props => [productId, productName, quantitySold];
}
