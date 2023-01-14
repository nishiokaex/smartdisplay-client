// サンプルデータ
import '../../components/dashboard.dart';

Future<DashboardState> loadState(String dashboardId) async {
  const Map<String, dynamic> map = {
    "id": "b7cdb6bf-4bf9-462d-bd87-91f1909c17e5",
    "name": "Hello Dashboard",
    "description": "Hello Dashboard",
    "rootWidget": {
      "id": "1b9df627-96b8-4ca2-a4ea-b95657ebc146",
      "classId": "5a19746e-b048-47cc-b005-57bfed472114",
      "ids": ["921d075d-7035-4b0f-979e-fcbe8b10c32d"],
      "byId": {
        "921d075d-7035-4b0f-979e-fcbe8b10c32d": {
          "id": "921d075d-7035-4b0f-979e-fcbe8b10c32d",
          "classId": "9c4e0e4b-48f6-4bb4-9677-3d7d737b2813",
          "content": "Studying for TOEIC"
        }
      }
    }
  };

  return DashboardState.fromMap(map);
}
