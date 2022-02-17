import 'package:the_movie_db/Library/Domain/Api_client/api_handler.dart';
import 'package:the_movie_db/Library/Domain/Api_client/base_api_client.dart';
import 'package:the_movie_db/Library/Domain/Api_client/http_method.dart';
import 'package:the_movie_db/Library/Domain/Api_client/request_api_arguments.dart';
import 'package:the_movie_db/data/entity/movie_list_response.dart';
import 'package:the_movie_db/domain/api/api_links.dart';

import '../api_key.dart' as key;
import '../../../data/entity/movie_view_category.dart';

class MovieApiClient {

  Future<MovieListResponse> getMoviesOfCategory({
      required MovieViewCategory category, 
      required int page}) async {
    _queryParametrs['page'] = page.toString();
    return await _apiClient.sendRequest(
      httpMethod: HttpMethod.get, 
      args: RequestAPIArguments(
        url: _apiClient.makeUri(
          APILinks.mainHost, 
          CategoryRoot.getDataByCategory(category).urlPath,
          _queryParametrs
          ), 
          responseHandler: _responseHandler,
    ));
  }

  final Map<String, dynamic> _queryParametrs = {
    'api_key' : key.apiKey,
    'language' : 'ru-Ru',
    'region' : 'RU',
  };

  

  final _responseHandler = ResponseHandler(
    contentParser: (jsonMap) => MovieListResponse.fromJson(jsonMap));

  final BaseAPIClient _apiClient = BaseAPIClient();
}




