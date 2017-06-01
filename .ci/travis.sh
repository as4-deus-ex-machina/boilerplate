#!/bin/bash -x

# Build documents
cd $TRAVIS_BUILD_DIR/document
make

# Push to GitHub
if [ -n "$GITHUB_API_KEY" ]; then
  cd $TRAVIS_BUILD_DIR
  git checkout --orphan $TRAVIS_BRANCH-pdf
  git rm -rf .
  git add -f document/*.pdf
  git -c user.name='travis' -c user.email='travis' commit -m "Compiling PDFs"
  git push -q -f https://$GITHUB_USER:$GITHUB_API_KEY@github.com/$TRAVIS_REPO_SLUG $TRAVIS_BRANCH-pdf
fi
