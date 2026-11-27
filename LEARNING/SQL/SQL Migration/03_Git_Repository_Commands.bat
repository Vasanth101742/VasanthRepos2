cd C:\SQLDBScripts

git init
git add .
git status
git commit -m "Initial SQL database source extraction"
git remote set-url origin https://dev.azure.com/ELGi-DATATeam/SQLProjects/_git/SQLRepository

git branch -M main
git fetch origin
git pull origin main --rebase

git push -u origin main

git status

