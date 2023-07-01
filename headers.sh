for file in *.tsv
do
  sed -i -e '1s/^/qseqid	seqid	qlen	slen	qcovs	pident	length	mismatch	gapopen	qstart	qend	  sstart	send	evalue	bitscore\n/g' $file
done