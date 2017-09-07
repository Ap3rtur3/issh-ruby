#!/bin/bash
shopt -s expand_aliases

# Dir of this script
CUR_DIR=$(pwd)
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
BASHRC=$HOME/.bashrc
FUNC="issh() ( ruby $DIR/lib/issh.rb )"

# Add function to .bashrc
grep -q -F "$FUNC" $BASHRC || echo $FUNC >> $BASHRC

cd $DIR

gem install bundler
bundle install

cd $CUR_DIR

echo "Setup finished!"
echo "Now run:   source $HOME/.bashrc"