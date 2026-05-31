import 'package:equatable/equatable.dart';

class UpdateInventoryCategoryRequestEntity extends Equatable {
  const UpdateInventoryCategoryRequestEntity({required this.categoryName});

  final String categoryName;

  @override
  List<Object?> get props => [categoryName];
}
