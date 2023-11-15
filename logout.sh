cd ~/notes/
git add .
git commit -m "`date`"
git push
cd ~/dotfiles/
cp ~/.bashrc .
./copy.sh
