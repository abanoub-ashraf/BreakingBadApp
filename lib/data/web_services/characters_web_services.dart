import '../../utils/app_strings.dart';
import '../../utils/console_logger.dart';
import 'package:print_color/print_color.dart';
import 'package:dio/dio.dart';

///
/// - this web services will send the data it got from the internet to
///   the repository as a json response
/// 
/// - the repository will map that response into our model
///
class CharactersWebServices {
    late Dio dio;

    CharactersWebServices() {
        final BaseOptions options = BaseOptions(
            baseUrl: AppStrings.apiBaseUrl,
            receiveDataWhenStatusError: true,
            connectTimeout: 20 * 1000, // 20 seconds
            receiveTimeout: 20 * 1000,
        );

        dio = Dio(options);
    }

    ///
    /// - this web services function will get called from the repository
    /// 
    /// -  this will send the json response to the repository and that response 
    ///    will get converted into the mode in the repository not here
    ///
    Future<List<dynamic>> getAllCharacters() async {
        try {
            final Response response = await dio.get(AppStrings.getAllCharactersEndpoint);
            
            return response.data as List<dynamic>;
        } catch (exception) {
            Print.red('===========================');
            logger.e(exception.toString());
            Print.red('===========================');

            return [];
        }
    }

    Future<List<dynamic>> getCharacterQuotes(String characterName) async {
        try {
            final Response response = await dio.get(
                'quote', 
                queryParameters: {
                    'author': characterName
                }
            );

            return response.data as List<dynamic>;
        } catch (exception) {
            Print.red('===========================');
            logger.e(exception.toString());
            Print.red('===========================');

            return [];
        }
    }
}