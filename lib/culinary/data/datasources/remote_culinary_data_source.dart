import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/models/culinary_catalog.dart';
import '../dto/culinary_response_dto.dart';

class RemoteCulinaryDataSource {
  const RemoteCulinaryDataSource({required this.client, required this.baseUrl});
  final http.Client client;
  final String baseUrl;
  Future<CulinaryCatalog> load() async {
    final base = Uri.parse(baseUrl);
    final loopback = ['localhost', '127.0.0.1', '10.0.2.2'].contains(base.host);
    if ((!loopback && base.scheme != 'https') ||
        base.host.isEmpty ||
        base.userInfo.isNotEmpty ||
        base.query.isNotEmpty ||
        base.fragment.isNotEmpty) {
      throw const FormatException(
        'URL API harus HTTPS (HTTP hanya untuk pengembangan lokal).',
      );
    }
    final uri = base
        .resolve('/api/v1/culinary')
        .replace(queryParameters: {'category': 'all', 'limit': '20'});
    final response = await client
        .get(uri, headers: {'Accept': 'application/json'})
        .timeout(const Duration(seconds: 10));
    if (response.statusCode != 200) {
      throw http.ClientException('API tidak tersedia.');
    }
    if (response.bodyBytes.length > 1024 * 1024) {
      throw const FormatException('Respons terlalu besar.');
    }
    return CulinaryResponseDto.fromJson(
      jsonDecode(utf8.decode(response.bodyBytes)),
    ).catalog;
  }
}
