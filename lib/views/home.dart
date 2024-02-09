import 'dart:html';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:souting_test_application/feedback_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

double calculate_auto_points_amp_avg(List<FeedbackModel> elements){
  int sum = 0;
  elements.forEach((element) {
    sum += element.AutoAmpPoints;
  });
  return sum/elements.length;

}

double calculate_auto_points_spiker_avg(List<FeedbackModel> elements){
  int sum = 0;
  elements.forEach((element) {
    sum += element.AutoSpikerPoints;
  });
  return sum/elements.length;

}

double calculate_teleop_points_amp_avg(List<FeedbackModel> elements){
  int sum = 0;
  elements.forEach((element) {
    sum += element.TeleopAmpPoints;
  });
  return sum/elements.length;

}

double calculate_defence_avg(List<FeedbackModel> elements){
  int sum = 0;
  elements.forEach((element) {
    sum += element.RobotDefence;
  });
  return sum/elements.length;

}

double calculate_offence_avg(List<FeedbackModel> elements){
  int sum = 0;
  elements.forEach((element) {
    sum += element.RobotOffence;
  });
  return sum/elements.length;

}

double calculate_teleop_points_spiker_avg(List<FeedbackModel> elements){
  int sum = 0;
  elements.forEach((element) {
    sum += element.TeleopSpikerPoints;
  });
  return sum/elements.length;

}


Map<String, List<FeedbackModel>> MapTeams(List<FeedbackModel> feedbacks){
  Map<String, List<FeedbackModel>> teams = {};
  feedbacks.forEach((element) {
      if(teams.keys.contains(element.TeamID)){
        teams[element.TeamID]!.add(element);
      }
      else{
        teams[element.TeamID] = [element];
      }
    });
    return teams;
}

void Download_route_feedbacks(String TeamID, List<FeedbackModel> elements) async{
  var link = new AnchorElement(href: "/lib/route");
  var myData = [];
  elements.forEach((element) { 
    myData.add("\nתגובה:\n");
    myData.add(element.RobotRoutes);
    myData.add("\n");
  });
  var blob = new Blob(myData, 'text/plain', 'native');
  link.download = "Team_Routes_$TeamID.txt";
  link.href = Url.createObjectUrlFromBlob(blob).toString();
  link.click();
}

void Download_auto_route_feedbacks(String TeamID, List<FeedbackModel> elements) async{
  var link = new AnchorElement(href: "/lib/route");
  var myData = [];
  elements.forEach((element) { 
    myData.add("\nתגובה:\n");
    myData.add(element.AutoRoute);
    myData.add("\n");
  });
  var blob = new Blob(myData, 'text/plain', 'native');
  link.download = "Team_AUTO_Routes_$TeamID.txt";
  link.href = Url.createObjectUrlFromBlob(blob).toString();
  link.click();
}


void Download_points_to_hurt_feedbacks(String TeamID, List<FeedbackModel> elements) async{
  var link = new AnchorElement(href: "/lib/route");
  var myData = [];
  elements.forEach((element) {
    myData.add("\nתגובה:\n");
    myData.add(element.WeekPoints);
    myData.add("\n");
  });
  var blob = new Blob(myData, 'text/plain', 'native');
  link.download = "Team_Routes_$TeamID.txt";
  link.href = Url.createObjectUrlFromBlob(blob).toString();
  link.click();
}


String calculate_avg_starting_pos(List<FeedbackModel> elements){
  Map<String, int> answers = {};
  elements.forEach((element) {
    if(answers.keys.contains(element.StartPos)){
        answers[element.StartPos] = (answers[element.StartPos]! + 1);
      }
      else{
        answers[element.StartPos] = 1;
      }
  });
  var answers_list = answers.entries.toList();
  answers_list.sort((e1,e2) => e1.value.compareTo(e2.value));
  return answers_list.last.key;
}

String calculate_avg_shooting_time(List<FeedbackModel> elements){
  Map<String, int> answers = {};
  elements.forEach((element) {
    if(answers.keys.contains(element.AvgShootingTime)){
        answers[element.AvgShootingTime] = (answers[element.AvgShootingTime]! + 1);
      }
      else{
        answers[element.AvgShootingTime] = 1;
      }
  });
  var answers_list = answers.entries.toList();
  answers_list.sort((e1,e2) => e1.value.compareTo(e2.value));
  return answers_list.last.key;
}

String calculate_avg_collecting_time(List<FeedbackModel> elements){
  Map<String, int> answers = {};
  elements.forEach((element) {
    if(answers.keys.contains(element.AvgCollectingTime)){
        answers[element.AvgCollectingTime] = (answers[element.AvgCollectingTime]! + 1);
      }
      else{
        answers[element.AvgCollectingTime] = 1;
      }
  });
  var answers_list = answers.entries.toList();
  answers_list.sort((e1,e2) => e1.value.compareTo(e2.value));
  return answers_list.last.key;
}

String calculate_can_robot_climb(List<FeedbackModel> elements){
  Map<String, int> answers = {};
  elements.forEach((element) {
    if(answers.keys.contains(element.CanRobotClimb)){
        answers[element.CanRobotClimb] = (answers[element.CanRobotClimb]! + 1);
      }
      else{
        answers[element.CanRobotClimb] = 1;
      }
  });
  var answers_list = answers.entries.toList();
  answers_list.sort((e1,e2) => e1.value.compareTo(e2.value));
  return answers_list.last.key;
}

String calculate_avg_robot_climbing_time(List<FeedbackModel> elements){
  Map<String, int> answers = {};
  elements.forEach((element) {
    if(answers.keys.contains(element.RobotClimbingTime)){
        answers[element.CanRobotClimb] = (answers[element.RobotClimbingTime]! + 1);
      }
      else{
        answers[element.CanRobotClimb] = 1;
      }
  });
  var answers_list = answers.entries.toList();
  answers_list.sort((e1,e2) => e1.value.compareTo(e2.value));
  return answers_list.last.key;
}


String calculate_avg_climbing_time(List<FeedbackModel> elements){
  Map<String, int> answers = {};
  elements.forEach((element) {
    if(answers.keys.contains(element.RobotClimbingTime)){
        answers[element.RobotClimbingTime] = (answers[element.RobotClimbingTime]! + 1);
      }
      else{
        answers[element.RobotClimbingTime] = 1;
      }
  });
  var answers_list = answers.entries.toList();
  answers_list.sort((e1,e2) => e1.value.compareTo(e2.value));
  return answers_list.last.key;
}

class _HomeState extends State<Home> {
  List<FeedbackModel> feedbacks = [];

  getFeedbackFromSheet() async {
    var raw = await http.get(
        Uri.parse("https://script.google.com/macros/s/AKfycbz_6F8u80iSx2GqPlx8DHXkzDejkCl1jFSBr_oMaBG3McRQ8o7t3Vg3dG8zwjus-HxW/exec"));
    var jsonFeedback = convert.jsonDecode(raw.body);
    print('this is json Feedback $jsonFeedback');

    jsonFeedback.forEach((element) {
      print('$element THIS IS NEXT>>>>>>>');
      FeedbackModel feedbackModel = new FeedbackModel(TeamID: element["TeamID"], StartPos: element['StartPos'], AutoAmpPoints: element['AutoAmpPoints'], AutoSpikerPoints: element['AutoSpikerPoints'],
      TeleopSpikerPoints: element['TeleopSpikerPoints'], TeleopAmpPoints: element['TeleopAmpPoints'], AvgShootingTime: element['AvgShootingTime'], AvgCollectingTime: element['AvgCollectingTime'],
      CanRobotClimb: element['CanRobotClimb'], RobotTriedToClimb: element['RobotTriedToClimb'], RobotClimbingTime: element['RobotClimbingTime'], AutoRoute: element['AutoRoute'], RobotDefence: element['RobotDefence'],
      RobotOffence: element['RobotOffence'], TimeToRideField: element['TimeToRideField'], RobotRoutes: element['RobotRoutes'], WeekPoints: element['WeekPoints']);
      feedbacks.add(feedbackModel);
    });
    return MapTeams(feedbacks);

    //print('${feedbacks[0]}');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scouting"),
        elevation: 0,
      ),
      body: Container(child: FutureBuilder( future: getFeedbackFromSheet(),
    builder:(context, snapshot) {
         if (snapshot.data != null) {
          return FeedbackTable(teamsData:  MapTeams(feedbacks));
         }
         else{
           return Container(
          child: Center(
            child: Text('Loading.....'),
          ),
        );
         }
    } )));
  }
}

class FeedbackTable extends StatelessWidget {
  final Map<String, List<FeedbackModel>> teamsData;
  const FeedbackTable(
      {required this.teamsData});

  Widget build(BuildContext context) {
     return Container(
      child: ListView.builder(itemCount: teamsData.length, itemBuilder: (context, index) {
        return FeedbackTile(TeamID: teamsData.entries.toList()[index].key, elements:  teamsData.entries.toList()[index].value);
      }));
  }
}

class FeedbackTile extends StatelessWidget {
  final String TeamID;
  final List<FeedbackModel> elements;
  
  const FeedbackTile(
      {required this.TeamID, required this.elements});

  @override
  Widget build(BuildContext context) {
     return Container(
      padding: EdgeInsets.all(16),
      child: Column(children: [
          Row(
            children: [
                Text(TeamID, style: TextStyle(          
     decoration: TextDecoration.underline,  fontWeight: FontWeight.bold
   ),),
                SizedBox(width: 15),
                Text("${calculate_auto_points_amp_avg(elements)} : ממוצעות באוטונומי amp נקודות"),
                SizedBox(width: 15),
                Text("${calculate_auto_points_spiker_avg(elements)} : ממוצעות באוטונומי spiker נקודות"),
                SizedBox(width: 15),
                Text("${calculate_teleop_points_amp_avg(elements)} : ממוצעות בטלואפ amp נקודות"),
                SizedBox(width: 15),
                Text("${calculate_teleop_points_spiker_avg(elements)} : ממוצעות בטלאופ spiker נקודות"),
                SizedBox(width: 15),
                Text("ניקוד הגנה ממוצע : ${calculate_defence_avg(elements)}"),
                SizedBox(width: 15),
                Text("ניקוד התקפה ממוצע : ${calculate_offence_avg(elements)}"),
                SizedBox(width: 15)
                ],
              ), 
              Row(children: [
                SizedBox(width: 35),
                Text(" \"${calculate_avg_starting_pos(elements)}\"  : נקודת התחלה ממוצעת "),
                SizedBox(width: 15),
                Text(" זמן ירייה ממוצע : ${calculate_avg_shooting_time(elements)}"),
                SizedBox(width: 12),
                Text(" זמן איסוף ממוצע : ${calculate_avg_collecting_time(elements)}"),
                SizedBox(width: 12),
                Text(" האם הרובוט יכול לטפס (בממוצע): ${calculate_can_robot_climb(elements)}"),
                SizedBox(width: 12),
                Text(" זמן טיפוס ממוצע :  ${calculate_avg_climbing_time(elements)}"),
              ],),
              Row(children: [
                ElevatedButton(
                  onPressed: () {
                    Download_route_feedbacks(TeamID, elements);
                  },
                  child: Text("קבוצה $TeamID מסלולי נסיעה"),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                  onPressed: () {
                    Download_auto_route_feedbacks(TeamID, elements);
                  },
                  child: Text("קבוצה $TeamID מסלולי נסיעה באוטונומי"),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                  onPressed: () {
                    Download_points_to_hurt_feedbacks(TeamID, elements);
                  },
                  child: Text("קבוצה $TeamID - נקודות לפגיעה"),
                  )
              ],)
              ])
    );
  }
}