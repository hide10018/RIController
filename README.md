:beginner:ポートフォリオとして作品全体について記載します。

## :house:目次

- [RIControllerとは](#RIControllerとは)
- [企画背景](#企画背景)
- [機能一覧](#機能一覧)
- [アーキテクチャ](#アーキテクチャ)
- [ライセンス](#ライセンス)

# :stars:RIControllerとは
初めにRI Controllerとは何かを簡単に説明します。<br>
RI Controllerはセンサーを搭載したIoTデバイスで取得した室内の情報(センサーデータ)を元に<br>
*モバイルアプリで室内情報の可視化<br>
*センサーの値に応じた家電の自動操作<br>
*モバイルアプリから家電の手動操作<br>
の3つを行うことができるIoT×モバイルアプリの製作物となっています。  
この3つの機能によって、様々な要因によって在宅時間が長くなっている中でも、家で快適に過ごそうというのがコンセプトとなっています。


参考
<img width="1096" alt="スクリーンショット 2023-02-17 6 34 03" src="https://user-images.githubusercontent.com/103611012/219497948-703997f5-7340-43d6-bec5-54b483a14674.png">

# :car:企画背景
このテーマに決めた背景は2点あります。<br>
1点目はコロナ禍による在宅時間の増加、2点目はスマートフォンの普及によるアプリ需要の増加です。<br>
<br>
1点目のコロナ禍による在宅時間の増加ですが、<br>
ここ数年、新型コロナウイルスの蔓延によって家で過ごす機会は以前と比較して多くなりました。<br>
具体的には流行前と比較して在宅時間が1日あたり緊急事態宣言下では2時間24分、7月末では30分増加しています。緊急事態宣言外では一見あまり変わらないようにも見えますが、  
月換算すると15時間程度在宅時間が増えているのは大きな変化だと考えています。<br>
そこで、自分が過ごす家の中の状態をスマートフォンのアプリで確認できれば健康管理などに利用できそうだと考えたのが1点目の理由です。<br>
<br>
2点目のスマートフォンの普及によるアプリ需要の増加では<br>
現代社会でのスマートフォンの普及率に着目し、今後サービスをリリースしていくと考えた際に1番ユーザーの手に渡りやすいのがモバイルアプリだと考えました。  
実際に2020年時点で90%弱の人がスマートフォンを手にしており、モバイルアプリの需要は大きいと踏んでいます。<br>
参考:
<img width="871" alt="スクリーンショット 2023-02-17 6 54 40" src="https://user-images.githubusercontent.com/103611012/219495981-8d7d45b4-8ed1-4fe8-89aa-d60cebd1e89b.png">  
<img width="441" alt="スクリーンショット 2023-02-17 6 54 52" src="https://user-images.githubusercontent.com/103611012/219495960-b5083969-e925-4f46-8ddd-05503f7806dc.png">

# :airplane:機能一覧
1.bleを活用したwifiとログイン情報の送信
2.現在のデータ、グラフの表示
3.AIによる異常判定
4.異常判定を元に家電操作(IoTデバイス側)
5.家電の手動操作
6.ユーザー切り替え

# システム構成
以下の図のシステム構成で進めました。  
<img width="973" alt="image" src="https://user-images.githubusercontent.com/103611012/219497501-af417f82-3f11-431a-9bf7-822104cc5844.png">

# :repeat_one:アーキテクチャ
MVVMを意識して作りました。

# :zap:使用技術
* IoT
    * MicroPython
    * ESP32
    * 温湿度センサー
    * 埃センサー
    * 気圧センサー
* AI
    * Python
        * scikit-learn
        * pandas
        * numpy
    * 手法:one-class SVM
* API
    * Python
        * Flask
    * AWS
    * Gunicorn
* モバイル
    * Flutter
* データベース
    * Firebase