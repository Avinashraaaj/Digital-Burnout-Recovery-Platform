import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  User? get currentUser => _supabase.auth.currentUser;

  AuthProvider() {
    _supabase.auth.onAuthStateChange.listen((data) {
      notifyListeners();
    });
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _setLoading(true);
      await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      _setLoading(false);
      return true;
    } on AuthException catch (e) {
      _setError(e.message);
      return false;
    } catch (e) {
      _setError('An unexpected error occurred.');
      return false;
    }
  }

  Future<bool> signUp(String email, String password) async {
    try {
      _setLoading(true);
      await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      _setLoading(false);
      return true;
    } on AuthException catch (e) {
      _setError(e.message);
      return false;
    } catch (e) {
      _setError('An unexpected error occurred.');
      return false;
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    _errorMessage = null;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    _isLoading = false;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
