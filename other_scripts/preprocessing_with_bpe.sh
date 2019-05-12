#!/bin/bash

for lang in de en; do
	for corpus in train dev test; do
		cat $corpus.$lang | sed -e "s/\r//g" | perl ../moses_software/moses-scripts/scripts/tokenizer/normalize-punctuation.perl > $corpus.normalized.$lang
	done
done

for lang in de en; do
	for corpus in train dev test; do
		cat $corpus.normalized.$lang | perl ../moses_software/moses-scripts/scripts/tokenizer/tokenizer.perl -a -q -l $lang > $corpus.tokenized.$lang
	done
done

perl ../moses_software/moses-scripts/scripts/training/clean-corpus-n.perl train.tokenized de en train.tokenized.clean 1 80

for lang in de en; do
	perl ../moses_software/moses-scripts/scripts/recaser/train-truecaser.perl -corpus train.tokenized.clean.$lang -model truecase_model.$lang
	for corpus in train; do
		perl ../moses_software/moses-scripts/scripts/recaser/truecase.perl -model truecase_model.$lang < $corpus.tokenized.clean.$lang > $corpus.truecased.$lang
	done
	for corpus in dev test; do
		perl ../moses_software/moses-scripts/scripts/recaser/truecase.perl -model truecase_model.$lang < $corpus.tokenized.$lang > $corpus.truecased.$lang
	done
done

subword-nmt learn-joint-bpe-and-vocab -i train.truecased.de train.truecased.en --write-vocabulary vocab.de vocab.en -s 30000 -o deen.bpe
for lang in de en; do
	for corpus in train dev test; do
		subword-nmt apply-bpe -i $corpus.truecased.$lang -o $corpus.bpe.$lang -c deen.bpe --vocabulary vocab.$lang --vocabulary-threshold 50
	done
done

