#!/usr/bin/env bash
git status -s | grep ' M' | sed 's/^ M //' | xargs -I_ git add _
