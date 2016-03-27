#!/usr/bin/env bash

# Version 0.0.1

set -euo pipefail
IFS=$'\n\t'

PROGRAM_NAME=$1
MODULE_NAME="${PROGRAM_NAME^}" # might fail on Bash < 4.0
MAIN_FILE="${MODULE_NAME}.idr"
IPKG_FILE="${PROGRAM_NAME}.ipkg"

echo "Creating a directory for ${PROGRAM_NAME}."
mkdir $PROGRAM_NAME

echo "Entering the ${PROGRAM_NAME} directory."
cd $PROGRAM_NAME

echo "Creating the src directory."
mkdir src

echo "Creating the src/${MODULE_NAME} directory."
mkdir src/${MODULE_NAME}

echo "Creating src/${MODULE_NAME}/Actions.idr from the 'Hello, world' template."
cat <<-HERE > src/${MODULE_NAME}/Actions.idr
module ${MODULE_NAME}.Actions

import Effects
import Effect.StdIO

||| Defining this in another file using the STDIO effect is not that practical,
||| but it should help illustrate the project structure.
public export
sayHello : Eff () [STDIO]
sayHello = putStrLn "Hello, world!"
HERE

echo "Creating src/${MAIN_FILE} from 'Hello, world' template."
cat <<-HERE > src/$MAIN_FILE
module Main

import Effects
import Effect.StdIO

import ${MODULE_NAME}.Actions -- defines \`sayHello\`

main : IO ()
main = run sayHello
HERE

echo "Creating the ${PROGRAM_NAME}.ipkg file."
cat <<- HERE > $IPKG_FILE
package ${PROGRAM_NAME}

modules = ${MODULE_NAME}, ${MODULE_NAME}.Actions
sourcedir = src

opts = "-p effects"

main = ${MODULE_NAME}
executable = ${PROGRAM_NAME}
HERE

echo "Creating the Makefile."
cat << HERE > Makefile
DEFAULT:
	idris --build ${IPKG_FILE}

clean:
	idris --clean ${IPKG_FILE}
HERE

echo "Creating a basic .gitignore file."
cat <<-HERE > .gitignore
*.ibc
/${PROGRAM_NAME}
HERE

echo "Creating the Emacs .dir-locals.el file."
cat <<-HERE > .dir-locals.el
;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

((idris-mode
  (idris-load-packages .
                       ("effects"))))
HERE

echo "Creating a basic README.md file."
cat <<-HERE > README.md
# ${PROGRAM_NAME}

What this program does is up to you!

## building

Run \`make\` from this directory to generate the ${PROGRAM_NAME} executable.

## adding dependencies

Once the library you'd like to use is installed, you can add it to the \`opts\` line in ${IPKG_FILE}. Remember to include a leading \`-p\` for each library, so adding the \`contrib\` library would result in:
\`\`\`
opts = "-p effects -p contrib"
\`\`\`

If you use [idris-mode](https://github.com/idris-hackers/idris-mode) for Emacs, then you'll also want to add the library name to .dir-locals.el so that it will be loaded with the REPL process.
HERE
