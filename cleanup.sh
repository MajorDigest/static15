 #!/usr/bin/bash

export LAST_COMMIT="$(git rev-parse HEAD)"
export TEMP_BRANCH="temp$RANDOM"
git config --global user.name 'Valentin Podkamennyi'
git config --global user.email 'vpodk@users.noreply.github.com'
echo "[DEBUG] Run checkout:"
git checkout --orphan $TEMP_BRANCH $LAST_COMMIT
echo "[DEBUG] Run commit:"
git commit --allow-empty -m "Truncated history"
echo "[DEBUG] Run rebase:"
git rebase --onto $TEMP_BRANCH $LAST_COMMIT main
echo "[DEBUG] Delete $TEMP_BRANCH branch:"
git branch -D $TEMP_BRANCH
echo "[DEBUG] Delete all the objects w/o references:"
git prune --progress
echo "[DEBUG] Run git status:"
git status
echo "[DEBUG] Run aggressively collect garbage:"
git gc --aggressive
echo "[DEBUG] Run git push:"
git push -f
