// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `JdShop`
  String get jd_shop {
    return Intl.message(
      'JdShop',
      name: 'jd_shop',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get tab_home {
    return Intl.message(
      'Home',
      name: 'tab_home',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get tab_category {
    return Intl.message(
      'Category',
      name: 'tab_category',
      desc: '',
      args: [],
    );
  }

  /// `Shopping Cart`
  String get tab_shop_cart {
    return Intl.message(
      'Shopping Cart',
      name: 'tab_shop_cart',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get tab_profile {
    return Intl.message(
      'Profile',
      name: 'tab_profile',
      desc: '',
      args: [],
    );
  }

  /// `you may also like`
  String get title_may_like {
    return Intl.message(
      'you may also like',
      name: 'title_may_like',
      desc: '',
      args: [],
    );
  }

  /// `Popular recommendation`
  String get title_hot_recommend {
    return Intl.message(
      'Popular recommendation',
      name: 'title_hot_recommend',
      desc: '',
      args: [],
    );
  }

  /// `Goods list`
  String get goods_list {
    return Intl.message(
      'Goods list',
      name: 'goods_list',
      desc: '',
      args: [],
    );
  }

  /// `Shopping cart`
  String get shopping_cart {
    return Intl.message(
      'Shopping cart',
      name: 'shopping_cart',
      desc: '',
      args: [],
    );
  }

  /// `add to Shopping Cart`
  String get add_shopping_cart {
    return Intl.message(
      'add to Shopping Cart',
      name: 'add_shopping_cart',
      desc: '',
      args: [],
    );
  }

  /// `Buy now`
  String get buy_now {
    return Intl.message(
      'Buy now',
      name: 'buy_now',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
