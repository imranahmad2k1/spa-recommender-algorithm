import 'dart:io';

class Subject {
  final int id;
  final String name;

  const Subject({
    required this.id,
    required this.name,
  });
}

class Topic {
  final int id;
  final String name;
  final Subject subject;
  int understandingLevel;
  final Topic? dependeeTopic;

  Topic({
    required this.id,
    required this.name,
    required this.subject,
    this.understandingLevel = 7,
    this.dependeeTopic,
  });
}

void main() {
  print('------------\nStarting\n------------');

  final subject = Subject(id: 1, name: 'Maths');
  final topic =
      Topic(id: 1, name: 'Algebra', subject: subject, understandingLevel: 2);
  final topic2 =
      Topic(id: 2, name: 'Geometry', subject: subject, understandingLevel: 5);
  final topic3 = Topic(
      id: 3, name: 'Trigonometry', subject: subject, understandingLevel: 7);
  // final topic11 =
  //     Topic(id: 11, name: 'A', subject: subject, understandingLevel: 5);
  // final topic12 =
  //     Topic(id: 12, name: 'B', subject: subject, understandingLevel: 2);
  // final topic13 =
  //     Topic(id: 13, name: 'B', subject: subject, understandingLevel: 4);

  // List<Topic> topics = [topic3, topic2, topic, topic11, topic12, topic13];
  List<Topic> topics = [topic3, topic2, topic];

  //PRINT ALL TOPICS
  // print('------------\nList of Topics\n------------');
  // topics.forEach((topic) {
  //   print('Topic: ${topic.name}: ${topic.understandingLevel}}');
  // });

  RecommenderAlgorithm recommenderAlgorithm =
      RecommenderAlgorithm(topics: topics);

  recommenderAlgorithm.getRecommendedTopics(false);

  // print('------------\nRecommended Topics\n------------');
  // recommendedTopics.forEach((topic) {
  //   print('Topic: ${topic.name}: ${topic.understandingLevel}');
  // });
}

class RecommenderAlgorithm {
  final List<Topic> topics;

  RecommenderAlgorithm({required this.topics});

  void getRecommendedTopics(bool stopStudying) {
    List<Topic> recommendedTopics = topics;

    recommendedTopics.sort(
      (a, b) => a.understandingLevel.compareTo(b.understandingLevel),
    );

    //PRINTING ALL RECOMMENDED TOPICS
    recommendedTopics.forEach((topic) {
      print('Topic: ${topic.name}: ${topic.understandingLevel}');
    });

    if (stopStudying)
      return;

    else {
      //UPDATING UNDERSTANDING LEVEL FOR RECOMMENDED TOPIC
      print('Enter understanding level for recommended topic:');
      int newUnderstandingLevel = int.parse(stdin.readLineSync()!);

      if (newUnderstandingLevel == 0) {
        stopStudying = true;
        return;
      }
      else{
        stopStudying = false;
      }

      updateUnderstandingLevel(
        topic: recommendedTopics[0],
        newUnderstandingLevel: newUnderstandingLevel,
      );

      getRecommendedTopics(stopStudying);
    }
  }

  void updateUnderstandingLevel(
      {required Topic topic, required int newUnderstandingLevel}) {
    topic.understandingLevel = newUnderstandingLevel;
  }
}
