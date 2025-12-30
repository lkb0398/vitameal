/*

< Entity >

class UserGoalsEntity {
  final String userId;
  final String goalId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String goalTitle; // 목표명
  final String goalUnit; // 목표 단위
  final double goalValue; // 목표 수치
  final DateTime goalDate; // 목표 날짜
  final bool isDone; // 달성 여부
  final bool isMain; // 대표설정 여부
}

class GoalDatasEntity {
  final String goalId;
  final String dataId;
  final DateTime dataDate; // 데이터 날짜
  final double dataValue; // 데이터 수치
}


< Table >

profiles
- user_id // uuid, PK ( auth.users.id )

     │ 1 : N

user_goals
- user_id // uuid, FK ( profiles user_id ), NN
- goal_id // uuid, PK, NN
- created_at // timestamptz, NN
- updated_at // timestamptz, NN
- goal_title // text, NN
- goal_unit // text, NN
- goal_value // num, NN
- goal_date // timestamptz, NN
- is_done // bool, NN
- is_main // bool, NN

      │ 1 : N

goal_datas
- goal_id // uuid, FK ( user_goals goal_id ), NN
- data_id // uuid, PK, NN
- created_at // timestamptz, NN
- data_date // timestamptz, NN
- data_value // num, NN

*/

// TODO : 더미데이터 지우기

class GoalsEntity {
  GoalsEntity({
    required this.userId,
    required this.goalId,
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
  final String userId;
  final String goalId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String goalTitle; // 목표명
  final String goalUnit; // 목표 단위
  final double goalValue; // 목표 수치
  final DateTime goalDate; // 목표 날짜
  final bool isDone; // 달성 여부
  final bool isMain; // 대표설정 여부
  final List<DatasEntity>? datas; // 데이터 입력값들 > 지우기
}

//

class DatasEntity {
  DatasEntity({
    required this.goalId,
    required this.dataId,
    required this.createdAt,
    required this.dataDateTime,
    required this.dataValue,
  });
  final String goalId;
  final String dataId;
  final DateTime createdAt;
  final DateTime dataDateTime; // 데이터 날짜+시간
  final double dataValue; // 데이터 수치
}

final List<GoalsEntity> goals = [
  // 목표 1 (요산) : 달성 X, 대표설정 O
  GoalsEntity(
    goalId: "goal_id1",
    userId: "user_id",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    goalTitle: "요산",
    goalValue: 2.24,
    goalUnit: "mg/dL",
    goalDate: DateTime.now(),
    isDone: false,
    isMain: true,
    datas: yosanDatas,
  ),
  // 목표 2 (체중) : 달성 O, 대표설정 X
  GoalsEntity(
    goalId: "goal_id2",
    userId: "user_id",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    goalTitle: "체중",
    goalValue: 85.2,
    goalUnit: "kg",
    goalDate: DateTime.now(),
    isDone: true,
    isMain: false,
    datas: weightDatas,
  ),
  // 목표 3 (공복혈당) : 달성 X, 대표설정 X, 하위데이터 X
  GoalsEntity(
    goalId: "goal_id3",
    userId: "user_id",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    goalTitle: "공복혈당",
    goalValue: 70.2,
    goalUnit: "mg/dL",
    goalDate: DateTime.now(),
    isDone: false,
    isMain: false,
  ),
];

final List<DatasEntity> yosanDatas = [
  // 목표 1 - 데이터 1
  DatasEntity(
    dataId: "data_id1",
    goalId: "goal_id1",
    createdAt: DateTime.now(),
    dataDateTime: DateTime.now(),
    dataValue: 8.6,
  ),
  // 목표 1 - 데이터 2
  DatasEntity(
    dataId: "data_id1",
    goalId: "goal_id1",
    createdAt: DateTime.now(),
    dataDateTime: DateTime.now(),
    dataValue: 7.2,
  ),
];

final List<DatasEntity> weightDatas = [
  // 목표 2 - 데이터 1
  DatasEntity(
    dataId: "data_id3",
    goalId: "goal_id2",
    createdAt: DateTime.now(),
    dataDateTime: DateTime.now(),
    dataValue: 50,
  ),
  // 목표 2 - 데이터 2
  DatasEntity(
    dataId: "data_id4",
    goalId: "goal_id2",
    createdAt: DateTime.now(),
    dataDateTime: DateTime.now(),
    dataValue: 59,
  ),
];
