import 'package:vitameal/domain/entity/notifications_entity.dart';

abstract interface class NotificationsRepository {
  Future<List<NotificationsEntity>?> readNotis(String userId);
  Future<void> createNoti(NotificationsEntity entity);
  Future<void> updateNoti(NotificationsEntity entity);
  Future<void> deleteNoti(String notiId);
}
