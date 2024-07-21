class DiningLocation {
  final String name;
  final String address;
  final String hours;
  final bool isOpen;
  final List<String> menu; // Add this line

  DiningLocation({
    required this.name,
    required this.address,
    required this.hours,
    required this.isOpen,
    required this.menu, // Include 'menu' in the constructor
  });

  factory DiningLocation.fromJson(Map<String, dynamic> json) {
    return DiningLocation(
      name: json['name'],
      address: json['address'],
      hours: json['hours'],
      isOpen: json['isOpen'],
      menu: List<String>.from(json['menu']), // Include 'menu' in fromJson
    );
  }
}
