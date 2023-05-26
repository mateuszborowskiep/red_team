#!/bin/sh
ORG_NAME="NAME_OF_ORGANIZATION"

# before that you must get authentication from github 'gh auth login' and semgrep 'semgrep login'

#download all repos from organization
gh repo list $ORG_NAME --limit 1000 | while read -r repo _; do
  gh repo clone "$repo" "$repo"
done

cd $ORG_NAME
for d in */ ; do
    cd $d
    echo "Processing $d"
    # run gitleaks
    gitleaks detect -v --repo-path=. --report=../$d-gitleaks-report.json
    # run checkov
    checkov --directory . --output json --output-file ../$d-checkov-report.json
    # run semgrep
    semgrep --config auto --output ../$d-semgrep-report.json .
done
