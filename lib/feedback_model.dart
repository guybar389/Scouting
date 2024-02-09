import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class FeedbackModel {
  String TeamID;
  String StartPos;
  int AutoAmpPoints;
  int AutoSpikerPoints;
  int TeleopSpikerPoints;
  int TeleopAmpPoints;
  String AvgShootingTime;
  String AvgCollectingTime;
  String CanRobotClimb;
  String RobotTriedToClimb;
  String RobotClimbingTime;
  String AutoRoute;
  int RobotDefence;
  int RobotOffence;
  String TimeToRideField;
  String RobotRoutes;
  String WeekPoints;

  FeedbackModel(
      {required this.TeamID , required this.StartPos, required this.AutoAmpPoints, required this.AutoSpikerPoints, required this.TeleopSpikerPoints, required this.TeleopAmpPoints, 
      required this.AvgShootingTime, required this.AvgCollectingTime, required this.CanRobotClimb, required this.RobotTriedToClimb, required this.RobotClimbingTime, required this.AutoRoute, 
      required this.RobotDefence, required this.RobotOffence, required this.TimeToRideField, required this.RobotRoutes, required this.WeekPoints});

  // factory FeedbackModel.fromJson(dynamic json) {
  //   return FeedbackModel(
  //     TeamID: "${json['TeamID']}",
  //     StartPos: "${json['StartPos']}",
  //     Routes: "${json['Routes']}",
  //     PointerToHurt: "${json['PointerToHurt']}",
  //   );
  // }

  // Map toJson() => {
  //       "TeamID": TeamID,
  //       "StartPos": StartPos,
  //       "Routes": Routes,
  //       "PointerToHurt": PointerToHurt
  //     };
}

// class TeamData {
//   final String date;
//   TeamData({required this.date});
// }