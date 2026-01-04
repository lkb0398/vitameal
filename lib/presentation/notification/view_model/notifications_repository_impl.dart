import 'package:vitameal/presentation/notification/view_model/notifications_data_source.dart';
import 'package:vitameal/presentation/notification/view_model/notifications_entity.dart';
import 'package:vitameal/presentation/notification/view_model/notifications_mapper.dart';
import 'package:vitameal/presentation/notification/view_model/notifications_repository.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl(this.dataSource);

  final NotificationDataSource dataSource;

  @override
  Future<List<NotificationsEntity>?> getAllNotis() async {
    final dtos = await dataSource.getAllNotis();
    if (dtos == null) return [];
    return dtos.map(NotificationsMapper.toEntity).toList();
  }

  @override
  Future<void> saveNoti(NotificationsEntity entity) async {
    final dto = NotificationsMapper.toDto(entity);
    await dataSource.saveNoti(dto);
  }

  @override
  Future<void> updateNoti(NotificationsEntity entity) async {
    final dto = NotificationsMapper.toDto(entity);
    await dataSource.updateNoti(dto);
  }

  @override
  Future<void> deleteNoti(String notiId) async {
    await dataSource.deleteNoti(notiId);
  }
}
