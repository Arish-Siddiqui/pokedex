import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/api.dart' hide SecureRandom;
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/key_generators/api.dart';
import 'package:pointycastle/key_generators/rsa_key_generator.dart';
import 'package:pointycastle/random/fortuna_random.dart';

class CryptoService {
  // ---------- AES ----------
  static final _aesKey = Key.fromUtf8('1234567890123456'); // 16 bytes
  static final _aesIv = IV.fromUtf8('1234567890123456');

  String encryptAES(String plainText) {
    final encrypter = Encrypter(AES(_aesKey));
    return encrypter.encrypt(plainText, iv: _aesIv).base64;
  }

  String decryptAES(String cipherText) {
    final encrypter = Encrypter(AES(_aesKey));
    return encrypter.decrypt64(cipherText, iv: _aesIv);
  }

  // ---------- RSA ----------

  static final _keyPair = RSAKeyHelper.generateKeyPair();

  String encryptRSA(String plainText) {
    final encrypter = Encrypter(
      RSA(publicKey: _keyPair.publicKey as RSAPublicKey),
    );
    return encrypter.encrypt(plainText).base64;
  }

  String decryptRSA(String cipherText) {
    final encrypter = Encrypter(
      RSA(privateKey: _keyPair.privateKey as RSAPrivateKey),
    );
    return encrypter.decrypt64(cipherText);
  }
}

class RSAKeyHelper {
  static AsymmetricKeyPair<PublicKey, PrivateKey> generateKeyPair() {
    final keyGen = RSAKeyGenerator()
      ..init(
        ParametersWithRandom(
          RSAKeyGeneratorParameters(BigInt.parse('65537'), 2048, 12),
          _secureRandom(),
        ),
      );

    return keyGen.generateKeyPair();
  }

  static FortunaRandom _secureRandom() {
    final secureRandom = FortunaRandom();
    final seed = Uint8List(32);
    for (int i = 0; i < seed.length; i++) {
      seed[i] = i;
    }
    secureRandom.seed(KeyParameter(seed));
    return secureRandom;
  }
}
