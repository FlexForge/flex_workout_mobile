enum Units {
  kgs(name: 'kg', fullName: 'Kilograms'),
  lbs(name: 'lb', fullName: 'Pounds');

  const Units({required this.name, required this.fullName});

  final String name;
  final String fullName;
}
