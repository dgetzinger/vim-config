# Dave's `vimrc` and Related `vim` Config Files

This repository contains current versions of my `.vimrc` and related `vim` configuration files.


## Install ##

To copy the configuration files to `$HOME`, simply execute `make` or `make install` from inside the repository's root directory.

To install the files to a root directory other than `$HOME`, set the command-line variable `INSTALL_DIR` to the desired install directory, e.g.:

    make INSTALL_DIR=/path/to/wherever

By default, `make` will save backup copies of any configuration files found in the destination directory that will be overwritten under the name `<filename>-00000000000000`, where `00000000000000` is a 14-digit timestamp in the format YYYYMMDDHHMMSS (UTC time).

If backup files are not needed, skip the backup step by executing `make clobber`, `make nobackup` or `make skipbackup`, e.g.:

    make clobber

WARNING: skipping the backup will result in any existing files in the install directory being irrevocably *overwritten*.

Delete any unwanted backup files from the install directory by executing

    make clean


## Use ##

`make` copies two files to the install directory: `vimrc` and `vimrc_common.vim`. A single dot (`.`) is prefixed to each file name to that the files are copied as dotfiles.

`.vimrc`, which is `vim` normally sources during startup, does nothing but source `.vimrc_common.vim`, where the actual configuration code is found.