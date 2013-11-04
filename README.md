amici
=====
Autonomous Multi-Instance Continuous Integration

## Description

Continuous integration testing suite for evaluating forks.


## Usage

`amici init`

Generates: Amicifile

account: github user or organization name


## Reports:

http://manu3569.github.io/amici/

- fork amici
- run amici
  - get all non-fork repos with Amicifile
  - listen to callbacks from github for changes
  - listen to callbacks from github for fork changes
  - evaluate new/changed forks
  - generate results html, and push to gh-pages

classes: Server, CallbackServer, (Hookables), Project, Fork, Account, ReportBuilder, *Tester


## Steps to publish test results to GH Pages

git co master
mkdir .generated_html
echo "<h1>Hello World</h1>" > .generated_html/index.html
git co gh-pages
mv .generated_html/* .
rmdir .generated_html
git add -A
git commit -m "Updating static website."
git push
git co master

- Generate HTML, json

projects/index.html
projects/:project_name/index.html
projects/:project_name/forks/index.html
projects/:project_name/forks/:github_username/index.html
users/index.html
users/:github_username/index.html


## Github API Hooks

### Projects:

* fork - Any time a Repository is forked.
-> POST /projects/fork

* push  - Any git push to a Repository.
-> POST /projects/push

Forks:
* issues - Any time an Issue is opened or closed.
-> POST /forks/issues

* push  - Any git push to a Repository.
-> POST /forks/push



