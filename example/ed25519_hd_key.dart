import "package:hex/hex.dart";
import "package:ed25519_hd_key/ed25519_hd_key.dart";

void main() {
  String hexSeed =
      'fffcf9f6f3f0edeae7e4e1dedbd8d5d2cfccc9c6c3c0bdbab7b4b1aeaba8a5a29f9c999693908d8a8784817e7b7875726f6c696663605d5a5754514e4b484542';
  KeyData master = ED25519_HD_KEY.getMasterKeyFromSeed(hexSeed);
  print(HEX.encode(master.key));
  print(HEX.encode(master.chainCode));

  KeyData data = ED25519_HD_KEY.derivePath("m/0'/2147483647'", hexSeed);
  print(HEX.encode(data.key));
  print(HEX.encode(data.chainCode));
  var pb = ED25519_HD_KEY.getBublickKey(data.key);
  print(HEX.encode(pb));
}
