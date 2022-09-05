#!/bin/sh

set -xe

export IMPORTERS_VALIDATE_LOCALE="--validate_label_locale $HOME/${MODEL_LANGUAGE}/validate_label.py"

export CV_RELEASE_FILENAME="cv-corpus-10.0-2022-07-04-rm-sursilv.tar.gz"
export CV_RELEASE_SHA256="e3bfa984c4cd61b2b9cf3dca1051ae64e49815b5e5786acfbf9a56242bfc9f1a"

export LM_ICONV_LOCALE="rm_CH.UTF-8"

export MODEL_EXPORT_ZIP_LANG="rm-sursilv"
