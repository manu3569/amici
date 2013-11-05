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

# LIST
curl -H 'Authorization: token 5fccefe0e2a3944bfd65b030eb2140de3338f3fd' -H "Content-Type: application/json" -X GET  https://api.github.com/repos/manu3569/pollywog-ranch-rails-ruby-003/hooks

# SET
curl -H 'Authorization: token 5fccefe0e2a3944bfd65b030eb2140de3338f3fd' -H "Content-Type: application/json" -X POST -d '{"name": "web", "active": true, "events": ["push"], "config": {"url": "http://162.243.77.173/", "content_type": "json"}}' https://api.github.com/repos/manu3569/pollywog-ranch-rails-ruby-003/hooks

# DELETE
curl -H 'Authorization: token 5fccefe0e2a3944bfd65b030eb2140de3338f3fd' -H "Content-Type: application/json" -X DELETE https://api.github.com/repos/manu3569/pollywog-ranch-rails-ruby-003/hooks/1440633


# "ref":"refs/heads/<branch_name>"
# "head_commit"["id"] = <commit_id>
# "head_commit"["timestamp"] = <UTC Timestring>
# "repository"["name"] = <repo_name>
# "repository"["owner"]["name"] = <github_username>
# "repository"["owner"]["email"] = <email>
# "repository"["open_issues"] = <issue_count>


{
            "ref" => "refs/heads/test-branch",
          "after" => "d972455f48bcb2527c342027695a98ef71a48105",
         "before" => "0000000000000000000000000000000000000000",
        "created" => true,
        "deleted" => false,
         "forced" => true,
        "compare" => "https://github.com/loganhasson/pollywog-ranch-associations-ruby-003/compare/9863cdba1826^...d972455f48bc",
        "commits" => [
        [0] {
                   "id" => "9863cdba18263a2a63b387c3e4a1a365f0a1b19e",
             "distinct" => true,
              "message" => "Updating time",
            "timestamp" => "2013-11-04T13:37:15-08:00",
                  "url" => "https://github.com/loganhasson/pollywog-ranch-associations-ruby-003/commit/9863cdba18263a2a63b387c3e4a1a365f0a1b19e",
               "author" => {
                    "name" => "Logan Hasson",
                   "email" => "logan.hasson@gmail.com",
                "username" => "loganhasson"
            },
            "committer" => {
                    "name" => "Logan Hasson",
                   "email" => "logan.hasson@gmail.com",
                "username" => "loganhasson"
            },
                "added" => [],
              "removed" => [],
             "modified" => [
                [0] "random.file"
            ]
        },
        [1] {
                   "id" => "d972455f48bcb2527c342027695a98ef71a48105",
             "distinct" => true,
              "message" => "Updating time",
            "timestamp" => "2013-11-04T13:38:04-08:00",
                  "url" => "https://github.com/loganhasson/pollywog-ranch-associations-ruby-003/commit/d972455f48bcb2527c342027695a98ef71a48105",
               "author" => {
                    "name" => "Logan Hasson",
                   "email" => "logan.hasson@gmail.com",
                "username" => "loganhasson"
            },
            "committer" => {
                    "name" => "Logan Hasson",
                   "email" => "logan.hasson@gmail.com",
                "username" => "loganhasson"
            },
                "added" => [],
              "removed" => [],
             "modified" => [
                [0] "random.file"
            ]
        }
    ],
    "head_commit" => {
               "id" => "d972455f48bcb2527c342027695a98ef71a48105",
         "distinct" => true,
          "message" => "Updating time",
        "timestamp" => "2013-11-04T13:38:04-08:00",
              "url" => "https://github.com/loganhasson/pollywog-ranch-associations-ruby-003/commit/d972455f48bcb2527c342027695a98ef71a48105",
           "author" => {
                "name" => "Logan Hasson",
               "email" => "logan.hasson@gmail.com",
            "username" => "loganhasson"
        },
        "committer" => {
                "name" => "Logan Hasson",
               "email" => "logan.hasson@gmail.com",
            "username" => "loganhasson"
        },
            "added" => [],
          "removed" => [],
         "modified" => [
            [0] "random.file"
        ]
    },
     "repository" => {
                   "id" => 14098236,
                 "name" => "pollywog-ranch-associations-ruby-003",
                  "url" => "https://github.com/loganhasson/pollywog-ranch-associations-ruby-003",
          "description" => "Pollywog Ranch",
             "watchers" => 0,
           "stargazers" => 0,
                "forks" => 0,
                 "fork" => true,
                 "size" => 112,
                "owner" => {
             "name" => "loganhasson",
            "email" => "logan.hasson@gmail.com"
        },
              "private" => true,
          "open_issues" => 0,
           "has_issues" => false,
        "has_downloads" => true,
             "has_wiki" => true,
             "language" => "Ruby",
           "created_at" => 1383531032,
            "pushed_at" => 1383601087,
        "master_branch" => "master",
         "organization" => "flatiron-school"
    },
         "pusher" => {
         "name" => "loganhasson",
        "email" => "logan.hasson@gmail.com"
    }
}
