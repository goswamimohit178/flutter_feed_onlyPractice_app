// Bloc Pattern for the feed.
// STEP-1: Imports
// STEP-2: List of Feeds
// STEP-3: Stream controller
// STEP-4: Stream sink getter
// STEP-5: Constructor - Add Likes, Listen to the changes
// STEP-6: Core functions
// STEP-7: Dispose
//Stream Is Already Been Cooked In Flutter

import 'dart:async';

class Feed {
  int feedId, type, likes;
  String title,
      description,
      category,
      subcategory,
      time,
      name,
      avatarImg,
      bannerImg,
      location,
      comments,
      members;

  Feed(
      {required this.feedId,
      required this.type,
      required this.title,
      required this.description,
      required this.category,
      required this.subcategory,
      required this.time,
      required this.name,
      required this.avatarImg,
      required this.bannerImg,
      required this.location,
      required this.likes,
      required this.comments,
      required this.members});
}

class QuestionModel {
  String question;

  QuestionModel({required this.question});
}

class Category {
  bool isSelected = false;
  String categoryType;

  Category({required this.categoryType});
}

class FeedBloc {
  List<Feed> feedList = [
    Feed(
        feedId: 1,
        type: 0,
        title: 'rohit.shetty12',
        description:
            'I have been facing a few possible symptoms of skin cancer. I have googled the possibilities but i can thought i did asked the community instead...',
        category: 'DIET',
        subcategory: 'Asked a question',
        time: '1 min',
        name: 'What Are The Sign And Symptoms Of Skin Cancer?',
        avatarImg:
            "https://th.bing.com/th?q=Boy+Emoji&w=120&h=120&c=1&rs=1&qlt=90&cb=1&dpr=1.3&pid=InlineBlock&mkt=en-IN&cc=IN&setlang=en&adlt=moderate&t=1&mw=247",
        bannerImg:
            "https://th.bing.com/th?q=Boy+Emoji&w=120&h=120&c=1&rs=1&qlt=90&cb=1&dpr=1.3&pid=InlineBlock&mkt=en-IN&cc=IN&setlang=en&adlt=moderate&t=1&mw=247",
        location: 'Peninsula park Andheri, Mumbai',
        likes: 24,
        comments: '24',
        members: '24'),
    Feed(
        feedId: 2,
        type: 0,
        title: 'rohit.shetty02',
        description:
            'My husband has his 3 days transpalnt assessment in Newcastle next month, strange mix of emotions. for those that have been thought this how long did it take following assessment was it intil you were t...',
        category: 'DIET',
        subcategory: 'Asked a question',
        time: '10 min',
        name: '',
        avatarImg:
            "https://th.bing.com/th?q=Boy+Emoji&w=120&h=120&c=1&rs=1&qlt=90&cb=1&dpr=1.3&pid=InlineBlock&mkt=en-IN&cc=IN&setlang=en&adlt=moderate&t=1&mw=247",
        bannerImg:
            "https://th.bing.com/th?q=Boy+Emoji&w=120&h=120&c=1&rs=1&qlt=90&cb=1&dpr=1.3&pid=InlineBlock&mkt=en-IN&cc=IN&setlang=en&adlt=moderate&t=1&mw=247",
        location: 'Peninsula park Andheri, Mumbai',
        likes: 23,
        comments: '2',
        members: '12'),
    Feed(
        feedId: 3,
        type: 0,
        title: 'username1275',
        description: '',
        category: 'DIET',
        subcategory: 'Asked a question',
        time: '10 min',
        name: 'Cancer Meet At Rajiv Gandhi National Park',
        avatarImg:
            "https://th.bing.com/th?q=Boy+Emoji&w=120&h=120&c=1&rs=1&qlt=90&cb=1&dpr=1.3&pid=InlineBlock&mkt=en-IN&cc=IN&setlang=en&adlt=moderate&t=1&mw=247",
        bannerImg:
            "https://th.bing.com/th?q=Boy+Emoji&w=120&h=120&c=1&rs=1&qlt=90&cb=1&dpr=1.3&pid=InlineBlock&mkt=en-IN&cc=IN&setlang=en&adlt=moderate&t=1&mw=247",
        location: 'Peninsula park Andheri, Mumbai',
        likes: 23,
        comments: '2',
        members: '12'),
    Feed(
        feedId: 4,
        type: 0,
        title: 'super987',
        description: '#itsokeyto #cancerserviver',
        category: 'LIFESTYLE',
        subcategory: 'Asked a question',
        time: '10 min',
        name: 'Something To Motivate You',
        avatarImg:
            "https://th.bing.com/th?q=Boy+Emoji&w=120&h=120&c=1&rs=1&qlt=90&cb=1&dpr=1.3&pid=InlineBlock&mkt=en-IN&cc=IN&setlang=en&adlt=moderate&t=1&mw=247",
        bannerImg:
            "https://th.bing.com/th?q=Boy+Emoji&w=120&h=120&c=1&rs=1&qlt=90&cb=1&dpr=1.3&pid=InlineBlock&mkt=en-IN&cc=IN&setlang=en&adlt=moderate&t=1&mw=247",
        location: 'Peninsula park Andheri, Mumbai',
        likes: 25,
        comments: '24',
        members: '18'),
    Feed(
        feedId: 5,
        type: 0,
        title: 'username1275',
        description: '#itsokeyto #cancerserviver',
        category: 'LIFESTYLE',
        subcategory: 'created a poll',
        time: '1 min',
        name: 'What is the best hospital in india for the cancer?',
        avatarImg:
            "https://th.bing.com/th?q=Boy+Emoji&w=120&h=120&c=1&rs=1&qlt=90&cb=1&dpr=1.3&pid=InlineBlock&mkt=en-IN&cc=IN&setlang=en&adlt=moderate&t=1&mw=247",
        bannerImg: 'https://www.w3schools.com/w3images/avatar4.png',
        location: 'Peninsula park Andheri, Mumbai',
        likes: 25,
        comments: '24',
        members: '18'),
  ];

  // 2. Stream controller
  final _feedListStreamController = StreamController<List<Feed>>();
  final _feedLikeIncrementController = StreamController<Feed>();
  final _feedLikeDecrementController = StreamController<Feed>();

  // 3. Stream Sink Getter
  Stream<List<Feed>> get feedListStream => _feedListStreamController.stream;
  StreamSink<List<Feed>> get feedListSink => _feedListStreamController.sink;

  StreamSink<Feed> get feedLikeIncrement => _feedLikeIncrementController.sink;
  StreamSink<Feed> get feedLikeDecrement => _feedLikeDecrementController.sink;

  // Constructor
  FeedBloc() {
    _feedListStreamController.add(feedList);
    _feedLikeIncrementController.stream.listen(_incrementLike);
    _feedLikeDecrementController.stream.listen(_decrementLike);
  }

  _incrementLike(Feed feed) {
    int like = feed.likes;
    int incrementLike = like + 1;
    feedList[feed.feedId - 1].likes = like + incrementLike;
    feedListSink.add(feedList);
  }

  _decrementLike(Feed feed) {
    int like = feed.likes;
    int decrementLike = like - 1;
    feedList[feed.feedId - 1].likes = like - decrementLike;
    feedListSink.add(feedList);
  }

  dispose() {
    _feedLikeDecrementController.close();
    _feedLikeIncrementController.close();
    _feedListStreamController.close();
  }
}
