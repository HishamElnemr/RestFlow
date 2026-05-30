import '../../domain/entities/customer_entity.dart';
import '../../domain/entities/customer_response_entity.dart';
import 'customer_model.dart';

class CustomerResponseModel extends CustomerResponseEntity {
  const CustomerResponseModel({
    required super.isSuccess,
    required super.message,
    super.data,
  });

  CustomerResponseEntity toEntity() {
    return CustomerResponseEntity(
      isSuccess: isSuccess,
      message: message,
      data: data,
    );
  }

  factory CustomerResponseModel.fromJson(Map<String, dynamic> json) {
    return CustomerResponseModel(
      isSuccess: json['isSuccess'] == true,
      message: (json['message'] ?? '').toString(),
      data: _dataFromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
    'isSuccess': isSuccess,
    'message': message,
    'data': _dataToJson(data),
  };
}

CustomerEntity? _dataFromJson(dynamic json) {
  if (json is Map<String, dynamic>) {
    return CustomerModel.fromJson(json);
  }
  return null;
}

Map<String, dynamic>? _dataToJson(CustomerEntity? entity) {
  if (entity == null) {
    return null;
  }
  if (entity is CustomerModel) {
    return entity.toJson();
  }
  return CustomerModel.fromEntity(entity).toJson();
}
