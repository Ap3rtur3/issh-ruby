# ISSH - A simple ssh cli

Start, add or remove ssh connections!

[![ezgif.com-crop23f56aeb26f8f484.gif](https://gifyu.com/images/ezgif.com-crop23f56aeb26f8f484.gif)](https://gifyu.com/image/MPl6)

## Prerequisites
* ruby (tested on ruby-2.4.0)
* bash (or compatible)

## Installation

Clone this repository
```bash
git clone https://github.com/Ap3rtur3/issh.git
```

Add this function to your .bashrc (or .zshrc). 
__Edit "path/to/issh" accordingly!__
```bash
issh() { (cd path/to/issh && ruby lib/issh.rb) }
```

Reload .bashrc (or .zshrc)
```bash
source $HOME/.bashrc
```

Install dependencies. 
__Edit "path/to/issh" accordingly!__
```bash
cd path/to/issh 
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
