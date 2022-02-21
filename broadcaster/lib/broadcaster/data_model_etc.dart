class BroadcastGroups{
  String name;
  bool selected = false;
  // List<int> bunch = [];

  BroadcastGroups({this.name, this.selected});
}
class Switchy{
  static bool open = false;
}
List<BroadcastGroups> broadcastgroups = [
  BroadcastGroups(name:"church", selected: false),
  BroadcastGroups(name:"jss mates", selected: false),
  BroadcastGroups(name:"ss mates", selected: false),
  BroadcastGroups(name:"legon mates", selected: false),
  BroadcastGroups(name:"work group", selected: false),
  BroadcastGroups(name:"hood", selected: false),
  BroadcastGroups(name:"football joint", selected: false),
];