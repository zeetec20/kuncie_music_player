class Music {
  Music(
    this.id,
    this.artistId,
    this.artist,
    this.cover,
    this.url,
    this.title,
    this.trackTimeMillis,
    this.artistUrl,
  );
  
  final int id, artistId, trackTimeMillis;
  final String title, artist, cover, url, artistUrl;
}
