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
  final topic11 =
      Topic(id: 11, name: 'A', subject: subject, understandingLevel: 5);
  // final topic12 =
  //     Topic(id: 12, name: 'B', subject: subject, understandingLevel: 2);
  // final topic13 =
  //     Topic(id: 13, name: 'B', subject: subject, understandingLevel: 4);

  // List<Topic> topics = [topic3, topic2, topic, topic11, topic12, topic13];
  List<Topic> topics = [topic3, topic2, topic, topic11];

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
    // mergeSort(topics, 0, topics.length - 1);
    //PRINTING ALL RECOMMENDED TOPICS

    List<Topic> recommendedTopics = topics;

    bubbleSort(recommendedTopics);

    recommendedTopics.forEach((topic) {
      print('Topic: ${topic.name}: ${topic.understandingLevel}');
    });

    //UPDATING UNDERSTANDING LEVEL FOR RECOMMENDED TOPIC
    print('Enter understanding level for recommended topic:');
    int newUnderstandingLevel = int.parse(stdin.readLineSync()!);

    updateUnderstandingLevel(
      topic: recommendedTopics[0],
      newUnderstandingLevel: newUnderstandingLevel,
    );

    getRecommendedTopics(false);
  }

  void customCompare(recommendedTopics, Topic a, Topic b) {
    if (b.understandingLevel > a.understandingLevel) {
      Topic temp = b;
      b = a;
      a = temp;
    } else if (b.understandingLevel == a.understandingLevel) {
      recommendedTopics.remove(a);
      recommendedTopics.add(a);
    }
  }

  void bubbleSort(List<Topic> recommendedTopics) {
    int n = recommendedTopics.length;
    bool swapped;

    for (int i = 0; i < n - 1; i++) {
      swapped = false;

      for (int j = 0; j < n - i - 1; j++) {
        int comparison =
            compare(recommendedTopics[j], recommendedTopics[j + 1]);
        if (comparison > 0) {
          Topic temp = recommendedTopics[j];
          recommendedTopics[j] = recommendedTopics[j + 1];
          recommendedTopics[j + 1] = temp;
          swapped = true;
        }
      }

      // If no swaps were made, the list is already sorted, so we can break the loop.
      if (!swapped) {
        break;
      }
    }

    // After sorting, push the first topic to the end of the list if it has the maximum understanding level.
    if (recommendedTopics.isNotEmpty &&
        recommendedTopics[0].understandingLevel == 7) {
      recommendedTopics.add(recommendedTopics.removeAt(0));
    }
  }

  int compare(Topic a, Topic b) {
    if (a.understandingLevel == b.understandingLevel) {
      return 0;
    } else if (a.understandingLevel == 7) {
      return 1; // Return 1 to push the first topic to the end of the list.
    } else if (b.understandingLevel == 7) {
      return -1;
    } else {
      return a.understandingLevel.compareTo(b.understandingLevel);
    }
  }

  void updateUnderstandingLevel(
      {required Topic topic, required int newUnderstandingLevel}) {
    topic.understandingLevel = newUnderstandingLevel;
  }
}
