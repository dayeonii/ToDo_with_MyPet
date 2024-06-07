// Friend.dart
class Friend {
  final String name;
  final String image;

  Friend({required this.name, required this.image});
}

class FriendRepository {
  // Example list of friends
  final List<Friend> _friends = [
    Friend(name: "친구 1", image: "assets/images/profileIcon.png"),
    Friend(name: "친구 2", image: "assets/images/profileIcon.png"),
    Friend(name: "친구 3", image: "assets/images/profileIcon.png"),
    Friend(name: "amy", image: "assets/images/profileIcon.png"),
    Friend(name: "Amile", image: "assets/images/profileIcon.png"),
  ];

  List<Friend> getFriends() {
    return _friends;
  }

  List<Friend> searchFriends(String query) {
    // return _friends.where((friend) => friend.name.contains(query)).toList();
    final lowerCaseQuery = query.toLowerCase(); //영어 대소문자 구분 없이
    return _friends.where((friend) => friend.name.toLowerCase().contains(lowerCaseQuery)).toList();
  }

  //요청온 친구 리스트
  final List<Friend> _requests = [
    Friend(name: "Bob", image: "assets/images/profileIcon.png"),
    Friend(name: "Tom", image: "assets/images/profileIcon.png"),
    Friend(name: "다연", image: "assets/images/profileIcon.png"),
  ];
  List<Friend> getRequests() {
    return _requests;
  }

  void acceptRequest(Friend friend) {
    _friends.add(friend);
    _requests.remove(friend);
  }

  void rejectRequest(Friend friend) {
    _requests.remove(friend);
  }
}