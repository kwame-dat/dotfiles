### Usage

Install

    git clone https://github.com/gilbertw1/emacs-literate-starter.git ~/.emacs.d

Compile (not required, but recommended)

    cd ~/.emacs.d
    make compile

Run

    emacs


### Make Commands

**clean**: Delete compiled files

    make clean

**compile**: Byte compile for performance (Recompile required when new changes are made)

    make compile

### Notes

* Configuration can be run without being byte compiled first, but will load slower as a result.
* If configuration has been byte compiled then recompilation is required to pick up new config changes.
