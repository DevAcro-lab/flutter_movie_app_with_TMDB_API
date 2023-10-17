import 'package:flutter/material.dart';
import 'package:movies_app/provider/save_get_account_id_notifier.dart';
import 'package:movies_app/provider/save_get_session_id_notifier.dart';
import '../services/get_api_services/get_request_token.dart';
import '../services/get_api_services/get_session_id.dart';
import '../services/get_api_services/get_user_account_id.dart';
import '../services/get_api_services/validate_email_and_password.dart';

class GetAccountIdNotifier extends ChangeNotifier {
  bool isLoading = false;
  Token token = Token();
  GetUserID getUserID = GetUserID();
  ValidateUserEmailAndPassword validateUserEmailAndPassword =
      ValidateUserEmailAndPassword();
  SessionId sessionId = SessionId();
  SaveAndGetAccountID saveAndGetAccountID = SaveAndGetAccountID();
  SaveAndGetSessionID saveAndGetSessionID = SaveAndGetSessionID();

  Future<void> getAccountIdNotifier(String username, String password) async {
    final requestToken = await token.createRequestToken();
    final validatedRequestToken = await validateUserEmailAndPassword
        .validateEmailAndPassword(requestToken, username, password);
    final session = await sessionId.createSession(validatedRequestToken!);
    saveAndGetSessionID.saveSessionId(session);
    print(session);
    final userAccountId = await getUserID.getUserId(session);
    saveAndGetAccountID.saveAccountId(userAccountId);
  }
}
