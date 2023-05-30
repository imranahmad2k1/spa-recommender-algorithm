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

  // final topic11 = Topic(
  //   id: 11,
  //   name: 'Topic11',
  //   subject: subject,
  //   understandingLevel: 5,
  // );
  // final topic12 = Topic(
  //   id: 12,
  //   name: 'Topic12',
  //   subject: subject,
  //   understandingLevel: 4,
  // );
  // final topic13 = Topic(
  //   id: 13,
  //   name: 'Topic13',
  //   subject: subject,
  //   understandingLevel: 2,
  // );

  final topic = Topic(
    id: 1,
    name: 'Topic1',
    subject: subject,
    understandingLevel: 2,
    // dependeeTopic: topic11,
  );
  final topic2 = Topic(
    id: 2,
    name: 'Topic2',
    subject: subject,
    understandingLevel: 5,
    // dependeeTopic: topic12,
  );
  final topic3 = Topic(
    id: 3,
    name: 'Topic3',
    subject: subject,
    understandingLevel: 7,
    // dependeeTopic: topic13,
  );

  List<Topic> topics = [topic3, topic2, topic]; //, topic11, topic12, topic13];

  RecommenderAlgorithm recommenderAlgorithm =
      RecommenderAlgorithm(topics: topics);

  recommenderAlgorithm.getRecommendedTopics(false);
}

class RecommenderAlgorithm {
  final List<Topic> topics;

  RecommenderAlgorithm({required this.topics});

  void getRecommendedTopics(bool stopStudying) {
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

  void bubbleSort(List<Topic> recommendedTopics) {
    int n = recommendedTopics.length;
    bool swapped;

    for (int i = 0; i < n - 1; i++) {
      swapped = false;

      for (int j = 0; j < n - i - 1; j++) {
        int comparison = recommendedTopics[j]
            .understandingLevel
            .compareTo(recommendedTopics[j + 1].understandingLevel);
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

  void updateUnderstandingLevel(
      {required Topic topic, required int newUnderstandingLevel}) {
    topic.understandingLevel = newUnderstandingLevel;
  }
}
