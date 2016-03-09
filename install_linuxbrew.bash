#!/bin/bash
set -e
cd $( dirname "${BASH_SOURCE[0]}" )
source ./settings
set -x

[ -d ~/.linuxbrew ] \
    || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/linuxbrew/go/install)"
source profile_additions_linuxbrew.bash
brew install git
brew doctor
grep -q '^# Profile additions for linuxbrew$' ~/.bash_profile \
    || cat profile_additions_linuxbrew.bash >> ~/.bash_profile
echo Exit shell and sign in again to get proper settings
