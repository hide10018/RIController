//MIT License
// Copyright (c) 2022 snova301
// https://github.com/snova301/counter_firebase/blob/main/LICENSE

/// Flutter
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Firebase関係のインポート
import 'package:firebase_auth/firebase_auth.dart';

/// Authのサインイン状態のprovider
final signInStateProvider = StateProvider((ref) => 'サインインまたはアカウントを作成してください');

/// サインインユーザーの情報プロバイダー
final userProvider = StateProvider<User?>((ref) => null);
final userEmailProvider = StateProvider<String>((ref) => 'ログインしていません');

/// ページ設定
class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  AuthPageState createState() => AuthPageState();
}

class AuthPageState extends ConsumerState<AuthPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final singInStatus = ref.watch(signInStateProvider);
    final idController = TextEditingController();
    final passController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth Page'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: <Widget>[
          /// メールアドレス入力
          TextField(
            decoration: const InputDecoration(
              label: Text('E-mail'),
              icon: Icon(Icons.mail),
            ),
            controller: idController,
          ),

          /// パスワード入力
          TextField(
            decoration: const InputDecoration(
              label: Text('Password'),
              icon: Icon(Icons.key),
            ),
            controller: passController,
            obscureText: true,
          ),

          /// サインイン
          Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                /// ログインの場合
                _signIn(ref, idController.text, passController.text);
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey)),
              child: const Text('サインイン'),
            ),
          ),

          /// サインインのメッセージ表示
          Container(
            padding: const EdgeInsets.all(10),
            child: Text('メッセージ : $singInStatus'),
          ),

          /// サインアウト
          TextButton(
              onPressed: () {
                _signOut(ref);
              },
              child: const Text('SIGN OUT'))
        ],
      ),
    );
  }
}

/// サインイン処理
void _signIn(WidgetRef ref, String id, String pass) async {
  try {
    /// credential にはアカウント情報が記録される
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: id,
      password: pass,
    );

    /// ユーザ情報の更新
    ref.watch(userProvider.state).state = credential.user;

    /// 画面に表示
    ref.read(signInStateProvider.state).state = 'サインインできました!';
  }

  /// サインインに失敗した場合のエラー処理
  on FirebaseAuthException catch (e) {
    /// メールアドレスが無効の場合
    if (e.code == 'invalid-email') {
      ref.read(signInStateProvider.state).state = 'メールアドレスが無効です';
    }

    /// ユーザーが存在しない場合
    else if (e.code == 'user-not-found') {
      ref.read(signInStateProvider.state).state = 'ユーザーが存在しません';
    }

    /// パスワードが間違っている場合
    else if (e.code == 'wrong-password') {
      ref.read(signInStateProvider.state).state = 'パスワードが間違っています';
    }

    /// その他エラー
    else {
      ref.read(signInStateProvider.state).state = 'サインインエラー';
    }
  }
}

/// サインアウト
void _signOut(WidgetRef ref) async {
  await FirebaseAuth.instance.signOut();
  ref.read(signInStateProvider.state).state = 'サインインまたはアカウントを作成してください';
}
