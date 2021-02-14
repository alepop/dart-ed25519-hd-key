ed25519 HD Key
=====

Key Derivation for `ed25519`
------------
Ported from [ed25519-hd-key](https://github.com/alepop/ed25519-hd-key) js library

[SLIP-0010](https://github.com/satoshilabs/slips/blob/master/slip-0010.md) - Specification

Usage
-----

```dart
import 'dart:typed_data';

import "package:ed25519_hd_key/ed25519_hd_key.dart";
import 'package:convert/convert.dart';

void main() {
  String hexSeed =
      'fffcf9f6f3f0edeae7e4e1dedbd8d5d2cfccc9c6c3c0bdbab7b4b1aeaba8a5a29f9c999693908d8a8784817e7b7875726f6c696663605d5a5754514e4b484542';
  Uint8List seedBytes = hex.decode(hexSeed);
  KeyData master = ED25519_HD_KEY.getMasterKeyFromSeed(seedBytes);
  print(hex.encode(master.key)); // 171cb88b1b3c1db25add599712e36245d75bc65a1a5c9e18d76f9f2b1eab4
  print(hex.encode(master.chainCode)); // ef70a74db9c3a5af931b5fe73ed8e1a53464133654fd55e7a66f8570b8e33c3b
  KeyData data = ED25519_HD_KEY.derivePath("m/0'/2147483647'", seedBytes);
  print(hex.encode(data.key)); // ea4f5bfe8694d8bb74b7b59404632fd5968b774ed545e810de9c32a4fb4192f4
  print(hex.encode(data.chainCode)); // 138f0b2551bcafeca6ff2aa88ba8ed0ed8de070841f0c4ef0165df8181eaad7f
  var pb = ED25519_HD_KEY.getPublicKey(data.key);
  print(hex.encode(pb)); // 005ba3b9ac6e90e83effcd25ac4e58a1365a9e35a3d3ae5eb07b9e4d90bcf7506d
}
```

References
----------
[SLIP-0010](https://github.com/satoshilabs/slips/blob/master/slip-0010.md)

[BIP-0032](https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki)

[BIP-0044](https://github.com/bitcoin/bips/blob/master/bip-0044.mediawiki)
