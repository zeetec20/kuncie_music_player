// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RecentMusicPlayed.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentMusicPlayedAdapter extends TypeAdapter<RecentMusicPlayed> {
  @override
  final int typeId = 2;

  @override
  RecentMusicPlayed read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentMusicPlayed(
      id: fields[1] as int,
      artistId: fields[2] as int,
      userId: fields[3] as String?,
      artist: fields[5] as String,
      cover: fields[6] as String,
      url: fields[7] as String,
      title: fields[4] as String,
      trackTimeMillis: fields[9] as int,
      artistUrl: fields[8] as String,
      createdAt: fields[10] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, RecentMusicPlayed obj) {
    writer
      ..writeByte(10)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.artistId)
      ..writeByte(3)
      ..write(obj.userId)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.artist)
      ..writeByte(6)
      ..write(obj.cover)
      ..writeByte(7)
      ..write(obj.url)
      ..writeByte(8)
      ..write(obj.artistUrl)
      ..writeByte(9)
      ..write(obj.trackTimeMillis)
      ..writeByte(10)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentMusicPlayedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
