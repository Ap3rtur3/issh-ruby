# ISSH - A simple ssh cli

Start, add or remove ssh connections!

[![ezgif.com-crop23f56aeb26f8f484.gif](https://gifyu.com/images/ezgif.com-crop23f56aeb26f8f484.gif)](https://gifyu.com/image/MPl6)

## Prerequisites
* ruby
* bash (or compatible)

## Installation

```bash
git clone https://github.com/Ap3rtur3/issh.git
echo "issh() { (cd path/to/issh && ruby lib/issh.rb) }" >> $HOME/.bashrc    # Edit repository path accordingly
source $HOME/.bashrc
cd path/to/issh    # Edit repository path accordingly
gem install bundler
bundle install
```

__Note:__ The installation script _install.sh_ may not work properly at the moment. Use at own risk!

## Usage

```bash
issh
```

You can add, delete and start ssh connections.

## Misc

* Why "issh"?

`issh` stands for Interactive SSH.
Mostly because that's what it is, but I'm also not really creative at naming things

* Want to contribute?

Go ahead :rocket:

## TODO

* Menu point to edit ssh endpoint
* Better documentation/comments
* More ssh config options

## License

MIT
