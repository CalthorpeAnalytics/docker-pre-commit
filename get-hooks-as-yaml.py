#!/usr/bin/env python
import json
import time
import urllib
import yaml

# HTML version of Supported Hooks @ http://pre-commit.com/hooks.html
SOURCE_URL = 'http://pre-commit.com/all-hooks.json'
# Some hooks specified in all-hooks.json don't install cleanly, so
# we whitelist known-working hooks.
TRUSTED_REPOS = [
  'github.com/asottile',
  'github.com/detailyang/pre-commit-shell',
  'github.com/jstewmon/check-swagger',
  'github.com/pre-commit',
]

def is_trusted_repo(repo):
  for trusted_repo in TRUSTED_REPOS:
    if trusted_repo in repo:
      return True
  return False

response = urllib.urlopen(SOURCE_URL)
json_dict = json.loads(response.read())

yaml_list = []
for repo, hooks in json_dict.iteritems():
  if not is_trusted_repo(repo):
    continue

  d = {}
  d['repo'] = repo
  d['sha'] = 'master'
  d['hooks'] = []
  for hook in hooks:
    d['hooks'].append({ 'id': hook['id'] })

  yaml_list.append(d)

# Add comment to top of generate yaml file
print("# Generated via get-hooks-as-yaml.py on {}").format(time.strftime("%Y-%m-%j %H:%M:%S %Z"))
# Output generated yaml to stdout
print(yaml.safe_dump(yaml_list))
