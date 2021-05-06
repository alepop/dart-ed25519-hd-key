import 'dart:io';
import 'dart:convert';
import "package:test/test.dart";
import '../lib/ed25519_hd_key.dart';
import 'package:convert/convert.dart';

void main() {
  Map<String, dynamic> vectors = json.decode(
      File('./test/test_vectors.json').readAsStringSync(encoding: utf8));
  final seeds = vectors.keys;

  group("Test vectors for ${seeds.first} seed", () {
    test("should have valid key and chainCode", () async {
      var master =
          await ED25519_HD_KEY.getMasterKeyFromSeed(hex.decode(seeds.first));
      expect(
          hex.encode(master.key),
          equals(
              "2b4be7f19ee27bbf30c667b642d5f4aa69fd169872f8fc3059c08ebae2eb19e7"));
      expect(
          hex.encode(master.chainCode),
          equals(
              "90046a93de5380a72b5e45010748567d5ea02bbf6522f979e05c0d8d8ca9fffb"));
    });
    for (var el in vectors[seeds.first]) {
      test("should calculate valid data for '${el['path']}' path", () async {
        KeyData data = await ED25519_HD_KEY.derivePath(
            el['path'], hex.decode(seeds.first));
        var pb = await ED25519_HD_KEY.getPublicKey(data.key);
        expect({
          "path": el['path'],
          "chainCode": hex.encode(data.chainCode),
          "key": hex.encode(data.key),
          "publicKey": hex.encode(pb),
        }, equals(el));
      });
    }
  });

  group("Test vectors for ${seeds.last} seed", () {
    test("should have valid key and chainCode", () async {
      var master =
          await ED25519_HD_KEY.getMasterKeyFromSeed(hex.decode(seeds.last));
      expect(
          hex.encode(master.key),
          equals(
              "171cb88b1b3c1db25add599712e36245d75bc65a1a5c9e18d76f9f2b1eab4012"));
      expect(
          hex.encode(master.chainCode),
          equals(
              "ef70a74db9c3a5af931b5fe73ed8e1a53464133654fd55e7a66f8570b8e33c3b"));
    });
    for (var el in vectors[seeds.last]) {
      test("should calculate valid data for '${el['path']}' path", () async {
        KeyData data =
            await ED25519_HD_KEY.derivePath(el['path'], hex.decode(seeds.last));
        var pb = await ED25519_HD_KEY.getPublicKey(data.key);
        expect({
          "path": el['path'],
          "chainCode": hex.encode(data.chainCode),
          "key": hex.encode(data.key),
          "publicKey": hex.encode(pb),
        }, equals(el));
      });
    }
  });

  group("Test optional master key change", () {
    const masterSecret = "Bitcoin seed";

    test("Using '$masterSecret' key", () async {
      var master = await ED25519_HD_KEY.getMasterKeyFromSeed(
          hex.decode(
              "cd7875cc62c027a41e030f484fb17afe9737d0eb904f7642fc1a921d5ef94344461418dd53376ea31983a29ec119b209b844fe70f6e6c86673ce2a414236a198"),
          masterSecret: masterSecret);

      expect(
          hex.encode(master.key),
          equals(
              "1352d9efc5c511f89ff262f913e58a2d42649d47246752790cbce6987e100bfe"));
    });
  });
}
