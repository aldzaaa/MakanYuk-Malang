import 'dart:io';

import 'package:makanyuk_malang/culinary/data/datasources/remote_culinary_data_source.dart';

import 'package:http/http.dart' as http;

Future<void> main(List<String> args) async {
  final client = http.Client();
  try {
    final data = await RemoteCulinaryDataSource(
      client: client,
      baseUrl: args.single,
    ).load();
    if (!data.isDemo || data.places.length != 20) {
      throw StateError('Kontrak server demo tidak sesuai.');
    }
    stdout.writeln(
      'HTTP integration passed: ${data.places.length} typed places, isDemo=${data.isDemo}',
    );
  } finally {
    client.close();
  }
}
