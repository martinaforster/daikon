#!/bin/bash

sed 's/\@\@ //g' < test.translated > test.translated.nobpe

perl ../moses_software/moses-scripts/scripts/recaser/detruecase.perl < test.translated.nobpe > test.translated.ntc

perl ../moses_software/moses-scripts/scripts/tokenizer/detokenizer.perl -l en -q < test.translated.ntc > test.translated.detok
