import 'dart:convert';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:kuncie/models/Music.dart';

class ApiRepository {
  final httpClient = http.Client();

  Future<List<Music>> search(String keyword) async {
    keyword = keyword.replaceAll(' ', '+').toLowerCase();
    Uri url = Uri.parse(
        "https://itunes.apple.com/search?term=$keyword&entity=musicTrack");
    http.Response response = await httpClient.get(url);

    if (response.statusCode == 200) {
      Map musics = json.decode(response.body);
      return List<Map>.from(musics['results']).map((e) {
        return Music(
            e['trackId'],
            e['artistId'],
            e['artistName'],
            e['artworkUrl100'],
            e['previewUrl'],
            e['trackName'],
            e['trackTimeMillis'],
            e['artistViewUrl']);
      }).toList();
    }
    return [];
  }

  Future<String> getImageArtist(String url) async {
    http.Response response = await httpClient.get(Uri.parse(url));
    Document html = parse(response.body);
    String image;
    try {
      List<Element> elements =
          html.getElementsByClassName('circular-artwork__artwork');
      List<Element> element = elements[0].getElementsByTagName('source');
      image = element[1].attributes['srcset']!;
      return image.split(', ').last.replaceAll(' 380w', '');
    } catch (e) {
      image = 'http://via.placeholder.com/640x360';
    }
    return image;
  }
}
