#!/bin/bash
set -e
cd $( dirname "${BASH_SOURCE[0]}" )
source ./settings
set -x

[ -d ~/.rbenv ] \
    || git clone https://github.com/rbenv/rbenv.git ~/.rbenv
[ -x ~/.rbenv/libexec/rbenv-realpath.dylib ] \
    || ( cd ~/.rbenv && src/configure && make -C src )
[ -d ~/.rbenv/plugins/ruby-build ] \
    || git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
[ -d ~/.rbenv/versions/"${RUBY_VERSION}" ] \
    || {
      source profile_additions_ruby.bash
      rbenv install "${RUBY_VERSION}"
    }
rbenv global "${RUBY_VERSION}"
grep -q '^# Profile additions for ruby$' ~/.bash_profile \
    || cat profile_additions_ruby.bash >> ~/.bash_profile
echo Exit shell and sign in again to get proper settings
