import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/notifications_repository.dart';
import 'notifications_list_state.dart';

class NotificationsListCubit extends Cubit<NotificationsListState> {
  NotificationsListCubit(this._repository)
      : super(const NotificationsListInitial());

  final NotificationsRepository _repository;

  Future<void> fetchNotifications() async {
    emit(const NotificationsListLoading());
    final result = await _repository.fetchNotifications();
    result.fold(
      (failure) => emit(NotificationsListFailure(failure)),
      (response) => emit(NotificationsListLoaded.fromEntity(response)),
    );
  }

  Future<void> markAsRead(String id) async {
    // Optimistic UI update logic can be placed here if NotificationEntity gets a copyWith
    // For now, we will simply rely on the fetch after completion.

    final result = await _repository.markAsRead(id);
    result.fold(
      (failure) {
        // Handle failure if needed, maybe revert optimistic update
      },
      (_) {
        // Re-fetch to get updated unread counts and status
        fetchNotifications();
      },
    );
  }

  Future<void> markAllAsRead() async {
    final result = await _repository.markAllAsRead();
    result.fold(
      (failure) {},
      (_) {
        fetchNotifications();
      },
    );
  }
}
