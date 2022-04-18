class Artist {
  Artist(this.name, this.image, {this.bestMonthly = false});

  late final int id =
      int.parse(image.split('/').last.replaceFirst('?uo=4', ''));
  final bool bestMonthly;
  final String name;
  String image;
}
