import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

abstract class BrowserEvent {
  //Browser LocalStorage Values
  static final web.Storage _localStorage = web.window.localStorage;
  static final String _cookieStorage = web.document.cookie;

  static void setCookie({
    required String key,
    required String value,
  }) {
    final String exiestingCookie = _cookieStorage;
    final String newCookie = '$key=$value';

    final List<Map<String, String>> cookieMapList = exiestingCookie.isEmpty
        ? []
        : exiestingCookie
            .split(';')
            .map((e) => e.split('='))
            .map((e) => {e[0]: e[1]})
            .toList();

    final bool isKeyAladyExist = cookieMapList.any((element) {
      return element.containsKey(key);
    });

    if (isKeyAladyExist) {
      final List<String> newCookieList = cookieMapList.map((e) {
        if (e.containsKey(key)) {
          return newCookie;
        }
        return '${e.keys.first}=${e.values.first}';
      }).toList();
      web.document.cookie = newCookieList.join(';');
    } else {
      if (exiestingCookie.isEmpty) {
        web.document.cookie = newCookie;
      } else {
        web.document.cookie = '$exiestingCookie;$newCookie';
      }
    }
  }

  static String? getCookieValue(String key) {
    final List<String> cookies = _cookieStorage.split(';');
    for (String cookie in cookies) {
      final List<String> cookieData = cookie.split('=');
      if (cookieData[0].trim() == key) {
        return cookieData[1];
      }
    }
    return null;
  }

  static void storeStringData(String key, String value) {
    _localStorage[key] = value;
  }

  static String? getStringData(String key) {
    return _localStorage.getItem(key);
  }

  static void storeMapData(String key, Map<String, dynamic> value) {
    _localStorage[key] = jsonEncode(value);
  }

  static void storeListModelData(String key, List<Map<String, dynamic>> value) {
    _localStorage[key] = jsonEncode(value);
  }

  static void removeStringData(String key) {
    _localStorage.removeItem(key);
  }

  static Map<String, dynamic>? getMapData(String key) {
    final String? data = _localStorage[key];
    if (data == null) return <String, dynamic>{};
    return jsonDecode(data) as Map<String, dynamic>;
  }

  static List<Map<String, dynamic>>? getListModelData(String key) {
    final String? data = _localStorage[key];
    if (data == null) return <Map<String, dynamic>>[];
    return (jsonDecode(data) as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();
  }

  static web.EventHandler? get onUnload => web.window.onunload;
  static web.EventHandler? get onReload => web.window.onload;

  //Browser LocalStorage Values

  static bool get isWebReloaded {
    String? isReloaded = _localStorage['isReload'];
    if (isReloaded == null) return false;
    return isReloaded == 'true';
  }

  static void setWebPPageReloadValue(bool value) {
    _localStorage['isReload'] = value.toString().toLowerCase();
  }

  static void clearWebPageReloadValue() {
    _localStorage.removeItem('isReload');
  }
}

abstract class WebReloadDetector {
  WebReloadDetector._();

  /// Call `onBrowserReload`  on Top Level Widget only Once
  static void onReload(Future Function() reloadCallback) {
    if (!kIsWeb) return;
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (BrowserEvent.isWebReloaded) {
        BrowserEvent.setWebPPageReloadValue(false);
        await reloadCallback.call();
      }

      // ?.listen((_) => BrowserEvent.setWebPPageReloadValue(true));
    });
  }
}
