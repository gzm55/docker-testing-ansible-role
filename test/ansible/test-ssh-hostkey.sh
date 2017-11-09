echo
echo "Check public ssh host keys."

for h in github.com \
         bitbucket.com bitbucket.org \
         gitlab.com gitlab.org \
         git.code.sf.net
do
  echo "testing for nobody@$h..."
  rm -f $HOME/.ssh/known_hosts || true
  ssh-keygen -F $h -f /etc/ssh/ssh_known_hosts
  ssh -o StrictHostKeyChecking=yes -o PreferredAuthentications=publickey nobody@$h 2>&1 | grep -q 'Permission denied'
  ! ssh-keygen -F $h -f $HOME/.ssh/known_hosts
done
