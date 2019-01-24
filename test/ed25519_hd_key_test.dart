import 'dart:io';
import 'dart:convert';
import "package:test/test.dart";
import "package:ed25519_hd_key/ed25519_hd_key.dart";
import "package:hex/hex.dart";

void main() {
  Map<String, dynamic> vectors = json.decode(
      File('./test/test_vectors.json').readAsStringSync(encoding: utf8));
  final seeds = vectors.keys;

  group("Test vectors for ${seeds.first} seed", () {
    test("should have valid key and chainCode", () {
      var master = ED25519_HD_KEY.getMasterKeyFromSeed(seeds.first);
      expect(
          HEX.encode(master.key),
          equals(
              "2b4be7f19ee27bbf30c667b642d5f4aa69fd169872f8fc3059c08ebae2eb19e7"));
      expect(
          HEX.encode(master.chainCode),
          equals(
              "90046a93de5380a72b5e45010748567d5ea02bbf6522f979e05c0d8d8ca9fffb"));
    });
    for (var el in vectors[seeds.first]) {
      test("should calculate valid data for '${el['path']}' path", () {
        KeyData data = ED25519_HD_KEY.derivePath(el['path'], seeds.first);
        var pb = ED25519_HD_KEY.getBublickKey(data.key);
        expect({
          "path": el['path'],
          "chainCode": HEX.encode(data.chainCode),
          "key": HEX.encode(data.key),
          "publicKey": HEX.encode(pb),
        }, equals(el));
      });
    }
  });

  group("Test vectors for ${seeds.last} seed", () {
    test("should have valid key and chainCode", () {
      var master = ED25519_HD_KEY.getMasterKeyFromSeed(seeds.last);
      expect(
          HEX.encode(master.key),
          equals(
              "171cb88b1b3c1db25add599712e36245d75bc65a1a5c9e18d76f9f2b1eab4012"));
      expect(
          HEX.encode(master.chainCode),
          equals(
              "ef70a74db9c3a5af931b5fe73ed8e1a53464133654fd55e7a66f8570b8e33c3b"));
    });
    for (var el in vectors[seeds.last]) {
      test("should calculate valid data for '${el['path']}' path", () {
        KeyData data = ED25519_HD_KEY.derivePath(el['path'], seeds.last);
        var pb = ED25519_HD_KEY.getBublickKey(data.key);
        expect({
          "path": el['path'],
          "chainCode": HEX.encode(data.chainCode),
          "key": HEX.encode(data.key),
          "publicKey": HEX.encode(pb),
        }, equals(el));
      });
    }
  });
}
