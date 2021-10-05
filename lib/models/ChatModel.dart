class ChatModel {
  final String name, currentMessage, icon, time;
  final bool isActive, isGroup;
  final String status;
  bool select = false;
  final int id;

  ChatModel({
    this.currentMessage,
    this.icon,
    this.isGroup,
    this.name,
    this.time,
    this.isActive,
    this.status,
    this.select = false,
    this.id,
  });
}
