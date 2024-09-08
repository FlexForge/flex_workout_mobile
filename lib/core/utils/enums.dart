enum Units {
  kgs(name: 'kgs', fullName: 'Kilograms'),
  lbs(name: 'lbs', fullName: 'Pounds');

  const Units({required this.name, required this.fullName});

  final String name;
  final String fullName;
}
