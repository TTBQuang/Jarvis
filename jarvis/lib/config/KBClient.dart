import 'package:dio/dio.dart';
import 'package:jarvis/constant.dart';
import 'package:jarvis/view_model/auth_view_model.dart';

class KBClient {
  AuthViewModel? authViewModel;

  final Dio _dio = Dio();

  KBClient({this.authViewModel}) {
    _dio.options = BaseOptions(
      baseUrl: baseUrlKb,
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['x-jarvis-guid'] =
              authViewModel?.user.userToken?.tokenKb.accessToken == null
                  ? authViewModel?.user.userUuid
                  : '';
          options.headers['Authorization'] =
              'Bearer ${authViewModel?.user.userToken?.tokenKb.accessToken}';
          return handler.next(options);
        },
        onError: (DioError error, handler) async {
          // Xử lý lỗi 401
          if (error.response?.statusCode == 401) {
            // Gọi hàm refresh token
            try {
              await _refreshTokenFunction();

              // Gửi lại request với token mới
              final options = error.requestOptions;
              options.headers['Authorization'] =
                  'Bearer ${authViewModel?.user.userToken?.tokenKb.accessToken}';

              final response = await _dio.fetch(options);
              return handler.resolve(response);
            } catch (e) {
              // Nếu làm mới token thất bại, trả về lỗi
              return handler.reject(error);
            }
          }

          return handler.next(error);
        },
      ),
    );
  }

  Future<void> _refreshTokenFunction() async {
    try {
      final response = await _dio.get(
        '/api/v1/auth/refresh',
        queryParameters: {
          'refresh_token': authViewModel?.user.userToken?.tokenKb.refreshToken
        },
      );

      authViewModel?.user.userToken?.tokenKb.accessToken =
          response.data['access_token'];
    } catch (e) {
      throw Exception('Failed to refresh token');
    }
  }

  Dio get dio => _dio;
}