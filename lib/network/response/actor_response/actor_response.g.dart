// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actor_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActorResponse _$ActorResponseFromJson(Map<String, dynamic> json) =>
    ActorResponse(
      json['page'] as int?,
      (json['results'] as List<dynamic>?)
          ?.map((e) => ActorVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total_pages'] as int?,
      json['total_results'] as int?,
    );
