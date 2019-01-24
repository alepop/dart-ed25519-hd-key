ed25519 HD Key
=====

Key Derivation for `ed25519`
------------
Ported from [ed25519-hd-key](https://github.com/alepop/ed25519-hd-key) js library

[SLIP-0010](https://github.com/satoshilabs/slips/blob/master/slip-0010.md) - Specification

Usage
-----

```dart
import "package:hex/hex.dart";
import "package:ed25519_hd_key/ed25519_hd_key.dart";

var String hexSeed = 'fffcf9f6f3f0edeae7e4e1dedbd8d5d2cfccc9c6c3c0bdbab7b4b1aeaba8a5a29f9c999693908d8a8784817e7b7875726f6c696663605d5a5754514e4b484542';

KeyData data = ED25519_HD_KEY.getMasterKeyFromSeed(hexSeed);

print(HEX.encode(data.key));
// => 2b4be7f19ee27bbf30c667b642d5f4aa69fd169872f8fc3059c08ebae2eb19e7
print(HEX.encode(data.chainCode));
// => 90046a93de5380a72b5e45010748567d5ea02bbf6522f979e05c0d8d8ca9fffb

KeyData data = ED25519_HD_KEY.derivePath("m/0'/2147483647'", hexSeed);

print(HEX.encode(data.key));
// => ea4f5bfe8694d8bb74b7b59404632fd5968b774ed545e810de9c32a4fb4192f4
print(HEX.encode(data.chainCode));
// => 138f0b2551bcafeca6ff2aa88ba8ed0ed8de070841f0c4ef0165df8181eaad7f

var pb = ED25519_HD_KEY.getBublickKey(data.key);
print(HEX.encode(pb));
// => 005ba3b9ac6e90e83effcd25ac4e58a1365a9e35a3d3ae5eb07b9e4d90bcf7506d
```

References
----------
[SLIP-0010](https://github.com/satoshilabs/slips/blob/master/slip-0010.md)

[BIP-0032](https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki)

[BIP-0044](https://github.com/bitcoin/bips/blob/master/bip-0044.mediawiki)