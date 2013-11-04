amici
=====

## Description

Continuous integration testing suite for evaluating forks.


## Usage

`amici init`

Generates: Amicifile

account: github user or organization name



- fork amici
- run amici
  - get all non-fork repos with Amicifile
  - listen to callbacks from github for changes
  - listen to callbacks from github for fork changes
  - evaluate new/changed forks
  - generate results html, and push to gh-pages

classes: Project, Fork, Account, *Tester







