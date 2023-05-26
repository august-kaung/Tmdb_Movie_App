import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb_app/constant/hive_constant.dart';

part 'genre_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: kHiveTypeIDForGenreVO)
class GenreVO{
  @JsonKey(name: 'id')
  @HiveField(1)
  int ?id;

  @JsonKey(name: 'name')
  @HiveField(2)
  String ?name;

  bool isSelect=false;

  GenreVO(this.id,this.name);
  
  factory GenreVO.fromJson(Map<String,dynamic>json)=>_$GenreVOFromJson(json);

  @override
  String toString() {
    return 'GenreVO{id: $id, name: $name}';
  }
}