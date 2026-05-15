#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Save original working directory so we can restore it when the script finishes.
ORIG_PWD="$PWD"

# Cleanup function: restore original working directory. Install trap for both
# EXIT (script executed) and RETURN (script sourced) so the caller's cwd
# isn't changed after the script completes.
cleanup() {
  cd "$ORIG_PWD" || true
}
trap cleanup EXIT RETURN

if [[ $1 ]]
  then
    if [[ -r $PWD/$1 ]]
      then
        SRC_PATH=$PWD/$1
    else
        if [[ -r $1 ]]
          then
            echo "Please enter a relative file path."
        else
            echo "File does not exist or is not readable."
        fi
        exit 1
    fi
else
    SRC_PATH=$SCRIPT_DIR/tex/main.tex
fi

NUM_PASSES=2
if [[ $SRC_PATH -ef $SCRIPT_DIR/tex/main.tex ]]
  then
    NUM_PASSES=3
fi

cd $SCRIPT_DIR
mkdir _build
cd tex
for (( counter=$NUM_PASSES; counter>0; counter-- ))
do
    pdflatex -interaction=nonstopmode -output-directory=../_build $SRC_PATH
done

if [[ $SRC_PATH -ef $SCRIPT_DIR/tex/main.tex ]]
  then
    cp ../_build/main.pdf ../cookbook_for_my_hamster.pdf
fi