import 'package:equatable/equatable.dart';

class CreateInventoryCategoryRequestEntity extends Equatable {
  const CreateInventoryCategoryRequestEntity({required this.categoryName});

  final String categoryName;

  @override
  List<Object?> get props => [categoryName];
}
