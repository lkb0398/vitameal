import 'package:vitameal/presentation/notification/view_model/notifications_entity.dart';

abstract interface class NotificationsRepository {
  Future<List<NotificationsEntity>?> getAllNotis();
  Future<void> saveNoti(NotificationsEntity entity);
  Future<void> updateNoti(NotificationsEntity entity);
  Future<void> deleteNoti(String notiId);
}
