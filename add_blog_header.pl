#! /usr/local/bin/perl
#
# 引数に書かれたファイル名のファイルを読み込んで処理し出力する（改行をまたぐ置換をするためにすべての行を読み込んで一括処理）
foreach $infilename ( @ARGV ){ #コマンドラインで指定された複数の引数をすべて処理する（引数は@ARGVを通して$infilenameに入る）
	$day = $infilename;
	$outfilename="a" . $infilename; #「a元ファイル名」というファイルに出力

	open(IN,"< $infilename");
	open(OUT,"> $outfilename");
		while (<IN>) { #<IN>に入力されたファイルを処理する
			$out = $out . $_; #いったん全部の行をまとめて入れる（改行を含む置換をしたいから）
		}
		$out = $day . $out;
		$out =~ s|^(\d\d\d\d\-\d\d\-\d\d_\d\d)\.txttitle: ([^\n]+)|$1:$2|;
		$out =~ s|(.+)\n*$|$1\n\n|; #各テキストファイルの末尾に改行を2つ入れて統一
		print OUT $out;
	close IN;
	close OUT;
}
