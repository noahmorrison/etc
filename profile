export EDITOR=neovim
export VISUAL=neovim

export SCALA_HOME=/usr/share/scala

export LD_LIBRARY_PATH=/usr/local/lib


# Normal bin folders
PATH=/bin
PATH=$PATH:/usr/bin
PATH=$PATH:/usr/local/bin

# User bin folders
PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/usr/bin

# Program bin folders
PATH=$PATH:`gem env path`
PATH=$PATH:/usr/bin/core_perl
PATH=$PATH:$SCALA_HOME/bin

export PATH
