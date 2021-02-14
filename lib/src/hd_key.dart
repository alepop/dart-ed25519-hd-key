import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';

import 'constants.dart';
import 'key_data.dart';

// Supported curve
const ED25519_HD_KEY = _ED25519HD();

/// Implementation of ED25519 private key derivation from master private key
class _ED25519HD {
  static final _curveBytes = utf8.encode(ED25519_CURVE);
  static final _pathRegex = RegExp(r"^(m\/)?(\d+'?\/)*\d+'?$");

  const _ED25519HD();

  KeyData derivePath(String path, Uint8List seedBytes) {
    if (!_ED25519HD._pathRegex.hasMatch(path)) {
      throw ArgumentError(
          "Invalid derivation path. Expected BIP32 path format");
    }

    KeyData master = getMasterKeyFromSeed(seedBytes);
    List<String> segments = path.split('/');
    segments = segments.sublist(1);

    return segments.fold<KeyData>(master, (prevKeyData, indexStr) {
      int index = int.parse(indexStr.substring(0, indexStr.length - 1));
      return _getCKDPriv(prevKeyData, index + HARDENED_OFFSET);
    });
  }

  Uint8List getPublicKey(Uint8List privateKey, [bool withZeroByte = true]) {
    final signature = ed25519.newKeyPairFromSeedSync(PrivateKey(privateKey));
    if (withZeroByte == true) {
      Uint8List dataBytes = Uint8List(33);
      dataBytes[0] = 0x00;
      dataBytes.setRange(1, 33, signature.publicKey.bytes);
      return dataBytes;
    } else {
      return signature.publicKey.bytes;
    }
  }

  KeyData getMasterKeyFromSeed(Uint8List seedBytes) =>
      _getKeys(seedBytes, _ED25519HD._curveBytes);

  KeyData _getCKDPriv(KeyData data, int index) {
    Uint8List dataBytes = Uint8List(37);
    dataBytes[0] = 0x00;
    dataBytes.setRange(1, 33, data.key);
    dataBytes.buffer.asByteData().setUint32(33, index);
    return _getKeys(dataBytes, data.chainCode);
  }

  KeyData _getKeys(Uint8List data, Uint8List keyParameter) {
    final hmac = Hmac(sha512).newSink(secretKey: SecretKey(keyParameter));
    hmac
      ..add(data)
      ..close();

    final I = hmac.mac.bytes;
    final IL = I.sublist(0, 32);
    final IR = I.sublist(32);

    return KeyData(key: IL, chainCode: IR);
  }
}
