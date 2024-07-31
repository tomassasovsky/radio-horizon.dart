// ignore_for_file: prefer_const_constructors
import 'package:shazam_client/shazam_client.dart';
import 'package:test/test.dart';

void main() {
  group('ShazamClient', () {
    test('can be instantiated', () {
      expect(ShazamClient.localhost(), isNotNull);
    });
  });
}
