#!/bin/sh

set -e

SUPPORT_DIR=~/swork/browser-support

cd $SUPPORT_DIR

echo "Updating qtbase..."
cd qtbase && git pull --rebase && git submodule update --init && cd ..

echo "Updating qtxmlpatterns..."
cd qtxmlpatterns && git pull --rebase && cd ..

echo "Updating qtdeclarative..."
cd qtdeclarative && git pull --rebase && cd ..

echo "Updating qtscript..."
cd qtscript && git pull --rebase && cd ..

echo "Updating webkit..."
cd webkit && git pull --rebase && cd ..

echo "Done"


