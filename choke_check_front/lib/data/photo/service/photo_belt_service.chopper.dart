// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_belt_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$PhotoBeltService extends PhotoBeltService {
  _$PhotoBeltService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = PhotoBeltService;

  @override
  Future<Response<dynamic>> validateBelt(File file) {
    final Uri $url = Uri.parse('validate_belt_color');
    final $body = file;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
