echo
echo "Check installing roles from galaxy server and github."

ansible-galaxy install mrlesmithjr.bootstrap
ansible-galaxy install git+https://github.com/geerlingguy/ansible-role-composer.git
