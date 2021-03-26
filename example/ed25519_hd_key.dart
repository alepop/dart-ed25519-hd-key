import "package:ed25519_hd_key/ed25519_hd_key.dart";
import 'package:convert/convert.dart';

void main() async {
  String hexSeed =
      'fffcf9f6f3f0edeae7e4e1dedbd8d5d2cfccc9c6c3c0bdbab7b4b1aeaba8a5a29f9c999693908d8a8784817e7b7875726f6c696663605d5a5754514e4b484542';
  List<int> seedBytes = hex.decode(hexSeed);
  KeyData master = await ED25519_HD_KEY.getMasterKeyFromSeed(seedBytes);
  print(hex.encode(master.key));
  print(hex.encode(master.chainCode));

  KeyData data = await ED25519_HD_KEY.derivePath("m/0'/2147483647'", seedBytes);
  print(hex.encode(data.key));
  print(hex.encode(data.chainCode));
  var pb = await ED25519_HD_KEY.getPublicKey(data.key);
  print(hex.encode(pb));
}
