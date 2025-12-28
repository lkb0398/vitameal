//

class GoalEntity {
  GoalEntity({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.goalTitle,
    required this.goalValue,
    required this.goalUnit,
    required this.goalDate,
    required this.isDone,
    required this.isMain,
    this.datas,
  });
  final String id;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String goalTitle; // 목표명
  final num goalValue; // 목표 수치
  final String goalUnit; // 목표 단위
  final String goalDate; // 목표 날짜
  final bool isDone; // 달성 여부
  final bool isMain; // 대표설정 여부
  final List<DataEntity>? datas; // 데이터 입력값들
}

//

class DataEntity {
  DataEntity({
    required this.id,
    required this.goalId,
    required this.createdAt,
    required this.dataDate,
    required this.dataTime,
    required this.dataValue,
    required this.isChecked,
  });
  final String id;
  final String goalId;
  final DateTime createdAt;
  final String dataDate; // 데이터 날짜
  final String dataTime; // 데이터 시간
  final num dataValue; // 데이터 수치
  final bool isChecked; // 삭제를 위해 선택되었는지 여부
}

// TODO : 더미데이터 지우기

final List<GoalEntity> goals = [
  // 목표 1 (요산) : 달성 X, 대표설정 O
  GoalEntity(
    id: "goal_id1",
    userId: "user_id",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    goalTitle: "요산",
    goalValue: 2.24,
    goalUnit: "mg/dL",
    goalDate: "2025.01.23",
    isDone: false,
    isMain: true,
    datas: yosanDatas,
  ),
  // 목표 2 (체중) : 달성 O, 대표설정 X
  GoalEntity(
    id: "goal_id2",
    userId: "user_id",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    goalTitle: "체중",
    goalValue: 85.2,
    goalUnit: "kg",
    goalDate: "2025.02.23",
    isDone: true,
    isMain: false,
    datas: weightDatas,
  ),
  // 목표 3 (공복혈당) : 달성 X, 대표설정 X, 하위데이터 X
  GoalEntity(
    id: "goal_id3",
    userId: "user_id",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    goalTitle: "공복혈당",
    goalValue: 70.2,
    goalUnit: "mg/dL",
    goalDate: "2025.03.23",
    isDone: false,
    isMain: false,
  ),
];

final List<DataEntity> yosanDatas = [
  // 목표 1 - 데이터 1 : 삭제 체크 O
  DataEntity(
    id: "data_id1",
    goalId: "goal_id1",
    createdAt: DateTime.now(),
    dataDate: "2025.12.22",
    dataTime: "14:20",
    dataValue: 8.6,
    isChecked: true,
  ),
  // 목표 1 - 데이터 2 : 삭제 체크 X
  DataEntity(
    id: "data_id1",
    goalId: "goal_id1",
    createdAt: DateTime.now(),
    dataDate: "2026.11.05",
    dataTime: "16:00",
    dataValue: 7.2,
    isChecked: false,
  ),
];

final List<DataEntity> weightDatas = [
  // 목표 2 - 데이터 1 : 삭제 체크 O
  DataEntity(
    id: "data_id3",
    goalId: "goal_id2",
    createdAt: DateTime.now(),
    dataDate: "12/31",
    dataTime: "00:00",
    dataValue: 50,
    isChecked: true,
  ),
  // 목표 2 - 데이터 2 : 삭제 체크 X
  DataEntity(
    id: "data_id4",
    goalId: "goal_id2",
    createdAt: DateTime.now(),
    dataDate: "2025.11.30",
    dataTime: "15:53",
    dataValue: 59,
    isChecked: false,
  ),
];
