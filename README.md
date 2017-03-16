# BuildScript [![Build Status](https://travis-ci.org/StarbotDiscord/BuildScript.svg?branch=master)](https://travis-ci.org/StarbotDiscord/BuildScript)

## What is this script?
This is a script for creating a runtime envoironment for Starbot. Probably not useful if you
just want to tinker with the bot, this is more useful for production where quick deployments
are useful. You can also use prebuilt copies of this envoironment if you are too lazy to
setup all the Starbot dependancies.

## How do I run it?

`./build.sh` will run a build with 1 thread and place the output in your home directory.

`MAKEARGS=-j4 ./build.sh` will run a build with 4 threads and place the output in your home directory.

`HOME=/opt` will run a build with 1 thread and place the output in `/opt`

You can use any mix of these variables.