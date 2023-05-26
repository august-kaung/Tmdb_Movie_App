import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:tmdb_app/constant/api_constant.dart';
import 'package:tmdb_app/data/vos/movies_details_vo/movie_details_vo.dart';
import 'package:tmdb_app/network/response/actor_response/actor_response.dart';
import 'package:tmdb_app/network/response/genre_response/genre_response.dart';

import '../../data/vos/actor_details_vo/actor_details_vo.dart';
import '../response/cast_and_crew_response/cast_and_crew_response.dart';
import '../response/movie_response/movie_response.dart';

part 'tmdb_api.g.dart';

@RestApi(baseUrl: kBaseURL)
abstract class TMDBapi {
  factory TMDBapi(Dio dio) => _TMDBapi(dio);

  @GET(kMovieByGenresIDEndPoint)
  Future<MovieResponse> getMovieResponseByGenresIDResponse(
      @Query(kQueryParamsWithGenres) int genreID,
      @Query(kQueryParamsApiKey) String apiKey,
      @Query(kQueryParamsPage) int page);

  @GET(kGenresEndPoint)
  Future<GenreResponse> getGenreResponse(
    @Query(kQueryParamsApiKey) String apiKey,
  );

  @GET(kTopRatedMoviesEndPoint)
  Future<MovieResponse> getTopRatedMoviesResponse(
      @Query(kQueryParamsApiKey) String apiKey,
      @Query(kQueryParamsPage) int page);

  @GET(kGetPopularMoviesEndPoint)
  Future<MovieResponse> getPopularMoviesResponse(
      @Query(kQueryParamsApiKey) String apiKey,
      @Query(kQueryParamsPage) int page);

  @GET(kActorListEndPoint)
  Future<ActorResponse> getActorsResponse(
      @Query(kQueryParamsApiKey) String apiKey,
      @Query(kQueryParamsPage) int page);

  @GET(kActorDetailsEndPoint)
  Future<ActorDetailsVO> getActorDetailsResponse(
      @Query(kQueryParamsApiKey) String apiKey,
      @Path(kPathParameterFoActorID) int actorID);

  @GET(kSearchMovieEndPoint)
  Future<MovieResponse> getSearchMovieResponse(
      @Query(kQueryParamsApiKey) String apiKey,
      @Query(kQueryParamsQuery) String query,
      @Query(kQueryParamsPage) int page);

  @GET(kMovieDetailsEndPoint)
  Future<MovieDetailsVO> getMovieDetailsResponse(
      @Query(kQueryParamsApiKey) String apiKey,
      @Path(kPathParameterForMovieID) int movieID);

  @GET(kCreditsEndPoint)
  Future<CastAndCrewResponse> getCastAndCrewResponse(
      @Query(kQueryParamsApiKey) String apiKey,
      @Path(kPathParameterForMovieID) int movieID);

  @GET(kSimilarEndPoint)
  Future<MovieResponse> getSimilarResponse(
    @Query(kQueryParamsApiKey) String apiKey,
    @Query(kQueryParamsPage) int page,
    @Path(kPathParameterForMovieID) int movieID,
  );
}
