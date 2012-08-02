#!/usr/bin/env bash

DIR="./Git-Depend"
FILE="$DIR/script.rb"
BIN_DIR="./.git/bin/"
BIN_FILE="gitdepend"
DEPEND_FILE="./.gitdepend"

if [ ! -d ./.git ]; then
  echo "Git-Depend: Git repo in this directory is non existant."
  exit 0
fi

mkdir -p $BIN_DIR

git clone git://github.com/yearofmoo/Git-Depend.git $DIR

if [ ! -f $FILE ]; then
  echo "Git-Depend: Git pull operation failed."
  exit 0
fi

chmod +x ./$FILE
mv ./$FILE "$BIN_DIR/$BIN_FILE"

rm -fr $DIR

if [ ! -f $FINAL ]; then
  echo "Git-Depend: Unable to movie script file to $BIN_DIR."
  exit 0
fi

echo "Git-Depend: Installation successful."

if [ ! -f $DEPEND_FILE ]; then
  touch $DEPEND_FILE
  echo "Git-Depend: .gitdepend file created."
fi
