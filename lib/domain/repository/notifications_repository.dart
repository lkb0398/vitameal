import 'package:vitameal/domain/entity/notifications_entity.dart';

abstract interface class NotificationsRepository {
  Future<List<NotificationsEntity>?> readNotis();
  Future<void> createNoti(NotificationsEntity entity);
  Future<void> updateNoti(NotificationsEntity entity);
  Future<void> deleteNoti(String notiId);
}
