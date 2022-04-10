import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as Crypto;
import 'package:pointycastle/asymmetric/api.dart' as api;

///加密工具类
class CryptoUtils {
  ///AES加密
  static String aesEncrypt(String text, String key, String iv) {
    var keyUtf = Crypto.Key.fromUtf8(key);
    var ivUtf = Crypto.IV.fromUtf8(iv);
    var encrypter =
        Crypto.Encrypter(Crypto.AES(keyUtf, mode: Crypto.AESMode.cbc));
    var encrypt = encrypter.encrypt(text, iv: ivUtf);
    return encrypt.toString();
  }

  ///RSA加密
  static String rsEncrypt(String text, String key) {
    var rsa = Crypto.RSA(
        publicKey: Crypto.RSAKeyParser().parse(key) as api.RSAPublicKey);
    var encrypt = rsa.encrypt(encode(text));
    var base64 = encrypt.base64;
    return base64;
  }

  static String getRandomBase62(int length) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    String result = "";
    for (int i = length; i > 0; --i) {
      result += chars[Random().nextInt(100) * chars.length.floor()];
    }
    return result;
  }

  static Uint8List encode(String s) {
    var encodedString = utf8.encode(s);
    var encodedLength = encodedString.length;
    var data = ByteData(encodedLength + 4);
    data.setUint32(0, encodedLength, Endian.big);
    var bytes = data.buffer.asUint8List();
    bytes.setRange(4, encodedLength + 4, encodedString);
    return bytes;
  }

  static String weapi() {
    const iv = '0102030405060708';
    const presetKey = '0CoJUm6Qyw8W8jud';
    const publicKey =
        '-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDgtQn2JZ34ZC28NWYpAUd98iZ37BUrX/aKzmFbt7clFSs6sXqHauqKWqdtLkF2KexO40H1YTX8z2lSgBBOAxLsvaklV8k4cBFK9snQXE9/DDaFt6Rr7iVZMldczhC0JNgTz+SHXT6CBHuX3e9SdB1Ua44oncaTWz7OBGLbCiK45wIDAQAB\n-----END PUBLIC KEY-----';

    var secretKey = getRandomBase62(16);




    return "";
  }
}
