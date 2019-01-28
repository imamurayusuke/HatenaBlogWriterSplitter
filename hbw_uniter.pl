#! /usr/local/bin/perl

$outfilename = "united.txt"; #出力ファイル名
$backupfilename = "united_bak.txt"; #出力ファイルのバックアップファイル名
if (-f $outfilename) {
	if (-f $backupfilename) {
		unlink $backupfilename;
	}
	rename $outfilename , $backupfilename;
}

@dirlist = glob("./????-??-??_??.txt");

foreach $infilename ( @dirlist ){
	open(IN,"< $infilename");
	open(OUT,">> $outfilename");
	while (<IN>) {
		$out = $out . $_; #いったん全部の行をまとめて入れる（改行を含む置換をするため）
	}
	$day = $infilename;
	$day =~ s/.*(\d{4}\-\d\d\-\d\d_\d\d)\.txt/$1/;

	$out =~ s|(.+)\n*$|$1\n\n|; #ファイル末尾の改行の数を調整
	$out =~ s|^title: ([^\n]+)|$1|;
	$out = $day . ":" . $out;
	print "Text of date added to " . $day . ".txt and united.\n";
	print OUT $out;
	$out = "";

	close IN;
	close OUT;
}
