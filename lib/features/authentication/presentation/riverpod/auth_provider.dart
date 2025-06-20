import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moneynest/core/utils/logger.dart';
import 'package:moneynest/features/authentication/data/repositories/user_repository.dart';
import 'package:moneynest/features/authentication/data/models/user_model.dart';
import 'package:moneynest/features/currency_picker/data/models/currency.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authProvider = FutureProvider<UserModel?>((ref) async {
  return await ref.read(authStateProvider.notifier).getSession();
});

class AuthProvider extends StateNotifier<UserModel> {
  AuthProvider() : super(UserRepository.dummy);

  void setUser(UserModel user) {
    state = user;
    _setSession();
  }

  void setImage(String? imagePath) {
    state = state.copyWith(profilePicture: imagePath);
  }

  void setCurrency(Currency currency) {
    state = state.copyWith(currency: currency);
  }

  UserModel getUser() => state;

  Future<void> _setSession() async {
    final prefs = await SharedPreferences.getInstance();
    Log.i(state.toJson(), label: 'logged user');
    prefs.setString('user', jsonEncode(state.toJson()));
  }

  Future<UserModel?> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedUser = prefs.getString('user') ?? '';
    if (encodedUser.isNotEmpty) {
      UserModel user = UserModel.fromJson(jsonDecode(encodedUser));
      state = user;
      Log.i(user.toJson(), label: 'user session');
      return user;
    }

    Log.i(null, label: 'user session');
    return null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    state = UserRepository.dummy;
  }
}

final authStateProvider = StateNotifierProvider<AuthProvider, UserModel>((ref) {
  return AuthProvider();
});
