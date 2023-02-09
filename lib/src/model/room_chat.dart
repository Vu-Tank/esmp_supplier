// ignore_for_file: public_member_api_docs, sort_constructors_first
class RoomChat {
  final String roomID;
  final String createDate;
  final String time;
  final String recentMessage;
  final String recentMessageSender;
  final String receiverName;
  final String receiverImageUrl;
  final String receiverUid;
  final bool isImage;
  RoomChat({
    required this.roomID,
    required this.createDate,
    required this.time,
    required this.recentMessage,
    required this.recentMessageSender,
    required this.receiverName,
    required this.receiverImageUrl,
    required this.receiverUid,
    required this.isImage,
  });

  @override
  String toString() {
    return 'RoomChat(roomID: $roomID, createDate: $createDate, time: $time, recentMessage: $recentMessage, recentMessageSender: $recentMessageSender, receiverName: $receiverName, receiverImageUrl: $receiverImageUrl, receiverUid: $receiverUid, isImage: $isImage)';
  }
}
