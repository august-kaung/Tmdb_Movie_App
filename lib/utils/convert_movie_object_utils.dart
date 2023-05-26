import 'package:tmdb_app/data/vos/actor_vo/know_for_vo.dart';
import 'package:tmdb_app/data/vos/movie_vo/movie_vo.dart';

List<MovieVO> getMovieVOListFromKnowForVOList(
        List<KnownForVO> knownForVOList) =>
    knownForVOList
        .map((knownForVO) => MovieVO(
            knownForVO.adult,
            knownForVO.backdropPath,
            knownForVO.genreIds,
            knownForVO.id,
            knownForVO.originalLanguage,
            knownForVO.originalTitle,
            knownForVO.overview,
            null,
            knownForVO.posterPath,
            knownForVO.releaseDate,
            knownForVO.title,
            knownForVO.video,
            knownForVO.voteAverage,
            knownForVO.voteCount))
        .toList();
