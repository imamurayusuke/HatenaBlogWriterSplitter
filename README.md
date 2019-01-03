# HatenaBlogWriterSplitter(v0.1.0)

## 概要
これは「はてダラスプリッタ」を「はてなブログライター」で使えるようにforkしたものです。

### リンク
- はてダラスプリッタ（はてなダイアリーライタースプリッタ）…http://www.hyuki.com/techinfo/hatena_diary_writer.html#hws
- はてなブログライター…https://github.com/rnanba/HatenaBlogWriter

## 必要なもの
- Perl

## 使い方
``diary.txt``に、はてなブログにアップロードしたい内容を書きます。**``diary.txt``は文字コードをUTF-8にして保存してください。**

``diary.txt``と``hdws.pl``を同じディレクトリに置き、``perl hdws.pl``を実行すると、はてなブログライター向けの日付＋連番に分割されたテキストファイルが出力されます。``hdws.pl``の実行によって``diary.txt``の内容が変化することはありません。

## ``diary.txt``の書式

``diary.txt``はたとえば以下のように書いてください。

```
2019-01-01_01:1つめのタイトル
date: 2019-01-01 12:00:00 +0900
category: test
draft: no
本文

2019-01-01_02:2つめのタイトル
date: 2019-01-01 12:00:00 +0900
category: test
draft: no
本文

2019-01-02_01:3つめのタイトル
date: 2019-01-02 12:00:00 +0900
category: test
draft: no
本文
```

上のような``diary.txt``を用意して``hdws.pl``を実行すると、``2019-01-01_01``、``2019-01-01_02``、``2019-01-02_01``が作られます。内容の例として、``2019-01-01_01``は以下のようになります。

```
title: 1つめのタイトル
date: 2019-01-01 12:00:00 +0900
category: test
draft: no
本文

```

## 仕様や制限について

``diary.txt``内の「日付_連番:タイトル」という行から次の「日付_連番:タイトル」までが、はてなブログの1エントリファイルになります。

「日付_連番:タイトル」に書かれた日付と``date:``に書かれた日付が異なる場合、エントリの日付やURL、エントリの投稿日時（エントリ末尾の「×日前」などの算出に使われる）は``date:``の日時が使われます（これははてなブログライターの仕様に従います。左の説明はv0.8.1の仕様に基づきます）。``日付_連番``と``date:``は同じにしておくのが好ましいと思いますが、過去のエントリ（``date:``）をいつ書いたか（``日付_連番``）を記録しておくといった使い方もあります。

``diary.txt``内に「日付_連番」が同じものがあった場合、``ERROR: Duplicate yyyy-mm-dd_nn. (エントリのタイトル)``というメッセージが出ますが、Windowsのコマンドプロンプトではエントリのタイトルが文字化けします。これはエントリのタイトルの文字コードがUTF-8であるのに対し、コマンドプロンプトの文字コードがShift_JIS（のcp932）であるためです。

エントリのタイトルに``delete``を書いてエントリを削除する仕様は実装されておらず、「detete」というタイトルのエントリが投稿されます。エントリを削除したい場合は、``draft: no``の下あたりに``delete: yes``と書いて``hdws.pl``を実行した上で、はてなブログライターを実行してください。（``delete: yes``と書いてエントリを削除するのははてなブログライターの機能です。この機能について詳しくは https://github.com/rnanba/HatenaBlogWriter/blob/master/README.md#%E5%89%8A%E9%99%A4 を参照してください）

## 履歴
- 2019-01-03(v0.1.0): 公開
