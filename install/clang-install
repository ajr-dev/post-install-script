#!/bin/bash

# shellcheck disable=SC2034
declare -f assertConfirmation &>/dev/null ||  source "$HOME/.dotfiles/install/declarations"

if ! grep "llvm" /etc/apt/sources.list; then
  [ ! -f /etc/apt/sources.list.bak ]  &&  sudo mv /etc/apt/sources.list /etc/apt.sources.list.bak
  echo  "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial main
  deb-src http://apt.llvm.org/xenial/ llvm-toolchain-xenial main
  deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-4.0 main
  deb-src http://apt.llvm.org/xenial/ llvm-toolchain-xenial-4.0 main
  " | sudo tee -a /etc/apt/sources.list
  sudo apt-get -y update
fi

wget -O - http://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add -
# Fingerprint: 6084 F3CF 814B 57C1 CF12 EFD5 15CF 4D18 AF4F 7421
sudo apt-get -y install clang
#clang-4.0-doc libclang-common-4.0-dev\
  #libclang-4.0-dev libclang1-4.0 libclang1-4.0-dbg libllvm-4.0-ocaml-dev\
  #libllvm4.0 libllvm4.0-dbg lldb-4.0 llvm-4.0 llvm-4.0-dev llvm-4.0-doc\
  #llvm-4.0-examples llvm-4.0-runtime clang-format-4.0 python-clang-4.0\
  #liblldb-4.0-dev lld-4.0 libfuzzer-4.0-dev

[ -f /etc/apt/sources.list.bak ]  &&  sudo mv /etc/apt/sources.list.bak /etc/apt/sources.list
