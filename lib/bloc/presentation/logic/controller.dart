import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pointycastle/export.dart';

class MyController {
  String encryted = '';
  String decrypted = '';

  String encrypt(String plainText) {
    final ivLength = 16; // 128 bits
    final algorithm = 'AES';
    final CBCBlockCipher cbcCipher = CBCBlockCipher(BlockCipher(algorithm));

    final salt = generateRandomBytes(32);
    final key = _generateKey("", salt);
    final iv = generateRandomBytes(ivLength);

    ParametersWithIV<KeyParameter> params =
        ParametersWithIV<KeyParameter>(KeyParameter(key), iv);
    PaddedBlockCipherParameters<ParametersWithIV<KeyParameter>, Null>
        paddingParams =
        PaddedBlockCipherParameters<ParametersWithIV<KeyParameter>, Null>(
            params, null);
    PaddedBlockCipherImpl paddingCipher =
        PaddedBlockCipherImpl(PKCS7Padding(), cbcCipher);
    paddingCipher.init(true, paddingParams);
    Uint8List plainData = Uint8List.fromList(utf8.encode(plainText));
    Uint8List encryptedBytes = paddingCipher.process(plainData);

    Uint8List fullEncryptedData =
        Uint8List.fromList([...salt, ...iv, ...encryptedBytes]);
    encryted = base64.encode(fullEncryptedData);
    return encryted;
  }

  String decrypt(String cipherText) {
    final algorithm = 'AES';
    final ivLength = 16; // 128 bits
    final CBCBlockCipher cbcCipher = CBCBlockCipher(BlockCipher(algorithm));
    Uint8List ciphertextlist = base64.decode(cipherText);
    Uint8List salt = ciphertextlist.sublist(0, 32);
    Uint8List key = _generateKey("", salt);
    Uint8List iv = ciphertextlist.sublist(32, 32 + ivLength);
    Uint8List encrypted = ciphertextlist.sublist(32 + ivLength);

    ParametersWithIV<KeyParameter> params =
        ParametersWithIV<KeyParameter>(KeyParameter(key), iv);
    PaddedBlockCipherParameters<ParametersWithIV<KeyParameter>, Null>
        paddingParams =
        PaddedBlockCipherParameters<ParametersWithIV<KeyParameter>, Null>(
            params, null);
    PaddedBlockCipherImpl paddingCipher =
        PaddedBlockCipherImpl(PKCS7Padding(), cbcCipher);
    paddingCipher.init(false, paddingParams);
    Uint8List decryptedBytes = paddingCipher.process(encrypted);
    decrypted = utf8.decode(decryptedBytes);
    debugPrint(decrypted);
    return decrypted;
  }

  // Generate key
  static Uint8List _generateKey(String passphrase, Uint8List salt) {
    Uint8List passphraseInt8List = Uint8List.fromList(passphrase.codeUnits);
    KeyDerivator derivator = PBKDF2KeyDerivator(HMac(SHA1Digest(), 64));
    Pbkdf2Parameters params = Pbkdf2Parameters(salt, 65556, 32);
    derivator.init(params);
    return derivator.process(passphraseInt8List);
  }

  Uint8List generateRandomBytes(int length) {
    final random = Random.secure();
    final values = List<int>.generate(length, (index) => random.nextInt(256));
    return Uint8List.fromList(values);
  }
}
