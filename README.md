# idris-new.sh

**Tested with Idris 0.11**

Create a new, slightly customized, mostly blank [Idris](http://idris-lang.org) project to use as a starting point for your application or library.

## requirements

Running the script doesn't require anything but Bash 4.0 or greater, which you should have installed already if you're not on OS X.
If you are, you may want to install a more recent version of Bash using [homebrew](http://brew.sh).

## usage

Put the `idris-new.sh` script somewhere on your path and make sure it's executable. Unless you're on Windows, that will probably look a little something like this:

```
cp idris-new.sh /usr/local/bin/idris-new
chmod +x /usr/local/bin/idris-new
```

Then call it with the name of your project as the first and only argument.
The name should consist of only alphanumeric characters and start with a lowercase letter. For example:

```
idris-new myCoolProject
```

Feel free to try out your project by typing `make` in the new directory, then running the new `myCoolProject` executable.

## what it does

The command above will do the following:

* create a new `myCoolProject` directory
* create a reasonably common project structure with a couple of modules that amount to little more than a classic "Hello, world" example
* create `myCoolProject.ipkg` and `Makefile` so that you can immediately build an executable with the `make` command
* create a small readme
* add a basic `.gitignore` file
* add a `.dir-locals.el` file so that Emacs will load the right libraries when it starts the Idris REPL

## what it doesn't do

* initialize the git repo. Your choice of VCS is up to you.
* add a LICENSE or CONTRIBUTING document, because those are also entirely up to you.
* clean up your project name if it has hyphens or emoji or whatever. Don't do that.
