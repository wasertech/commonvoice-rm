#!/bin/bash

set -xe

if [ ! -f "wiki_rm_lower.txt" ]; then
	curl -sSL https://github.com/wasertech/commonvoice-rm/releases/download/lm-0.1/wiki.txt.xz | pixz -d | tr '[:upper:]' '[:lower:]' > wiki_rm_lower.txt
fi;


if [ "${ENGLISH_COMPATIBLE}" = "1" ]; then
	mv wiki_rm_lower.txt wiki_rm_lower_accents.txt
	# Locally force LANG= to make iconv happy and avoid errors like:
	# iconv: illegal input sequence at position 4468
	# Also required locales and locales-all to be installed
	head -n 5 wiki_rm_lower_accents.txt
	iconv -f UTF-8 -t ASCII//TRANSLIT//IGNORE < wiki_rm_lower_accents.txt > wiki_rm_lower.txt
	head -n 5 wiki_rm_lower.txt
	> wiki_rm_lower_accents.txt
fi;

# Use leftovers transcription as indirect natural context for the lm to prepare for testing.
# You can quickly add new sentences to the scorer by creating a file named `_*_lm.txt`. Where * can be anything.
# All text files which name start with underscore and end with `_lm.txt` will be normalized and added to the scorer.
if [ "${LM_ADD_EXCLUDED_MAX_SEC}" = "1" ] && [ ! -f "excluded_max_sec_lm.txt" ]; then
	cat _*_lm.txt | tr '[:upper:]' '[:lower:]' > excluded_max_sec_lm.txt
	EXCLUDED_LM_SOURCE="excluded_max_sec_lm.txt"
fi;

# Remove special-char <s> that will make KenLM tools choke:
# kenlm/lm/builder/corpus_count.cc:179 in void lm::builder::{anonymous}::ComplainDisallowed(StringPiece, lm::WarningAction&) threw FormatLoadException.
# Special word <s> is not allowed in the corpus.  I plan to support models containing <unk> in the future.  Pass --skip_symbols to convert these symbols to whitespace.
if [ ! -f "sources_lm.txt" ]; then
	cat wiki_rm_lower.txt ${EXCLUDED_LM_SOURCE} | sed -e 's/<s>/ /g' > sources_lm.txt
fi;
