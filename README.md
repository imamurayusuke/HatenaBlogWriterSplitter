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

``diary.txt``と``hbws.pl``を同じディレクトリに置き、``perl hbws.pl``を実行すると、はてなブログライター向けの日付＋連番に分割されたテキストファイルが出力されます。``hbws.pl``の実行によって``diary.txt``の内容が変化することはありません。

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

上のような``diary.txt``を用意して``hbws.pl``を実行すると、``2019-01-01_01.txt``、``2019-01-01_02.txt``、``2019-01-02_01.txt``が作られます。内容の例として、``2019-01-01_01.txt``は以下のようになります。

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

``diary.txt``内に「日付_連番」が同じものがあった場合、``ERROR: Duplicate yyyy-mm-dd_nn. (エントリのタイトル)``というメッセージが出ますが、Windowsのコマンドプロンプトではエントリのタイトル内の日本語が文字化けします。これはエントリのタイトルの文字コードがUTF-8であるのに対し、コマンドプロンプトの文字コードがShift_JIS（のcp932）であるためです。

「はてなダイアリーライター」における、エントリのタイトルに``delete``を書いてエントリを削除する仕様は実装されておらず、「detete」というタイトルのエントリが投稿されます。エントリを削除したい場合は、``draft: no``の下あたりに``delete: yes``と書いて``hbws.pl``を実行した上で、はてなブログライターを実行してください。（``delete: yes``と書いてエントリを削除するのははてなブログライターの機能です。この機能について詳しくは https://github.com/rnanba/HatenaBlogWriter/blob/master/README.md#%E5%89%8A%E9%99%A4 を参照してください）

## 今までにはてなブログライターで登録したエントリを``diary.txt``に追加する方法

1. はてなブログライターのあるディレクトリで``hbw_uniter.pl``を実行する
	- ディレクトリ内の「yyyy-mm-dd_nn.txt」というすべてのテキストファイルの冒頭に日付が挿入された上ですべて連結され``united.txt``に出力される。ディレクトリ内にすでに``united.txt``があった場合、それは``united_bak.txt``にリネームされる
1. ``diary.txt``を別の名前に変更し``united.txt``を``diary.txt``にリネームする

## 履歴
- 2019-01-28(v0.1.2): ``add_blog_header.pl``に代わって``hbw_uniter.pl``を提供開始
- 2019-01-05(v0.1.1): ``add_blog_header.pl``を提供開始
- 2019-01-03(v0.1.0): 公開
