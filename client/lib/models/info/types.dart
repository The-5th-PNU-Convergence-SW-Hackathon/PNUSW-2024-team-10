class HeronInfoFilter {
  final String name;
  final String id;
  final List<HeronInfoFilterOption> options;

  const HeronInfoFilter({
    required this.name,
    required this.id,
    this.options = const [],
  });
}

class HeronInfoFilterOption {
  final String value;
  final String id;
  final bool selected;

  const HeronInfoFilterOption({
    required this.value,
    required this.id,
    this.selected = true,
  });
}
