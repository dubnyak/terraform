# Check network
until ping -c1 www.google.com &>/dev/null; do
  echo "Waiting for network ..."
  sleep 1
done
 apt-get update
# Install required Python libs and pip
 apt-get install -y  python3-pip libssl-dev libffi-dev build-essential supervisor python python-dev
[ -n "$( apt-cache search python-keyczar )" ] && apt-get install -y  python-keyczar
if ! apt-get install -y git ; then
   apt-get install -y git-core
fi
# If python-pip install failed and setuptools exists, try that
if [ -z "$(which pip)" -a -z "$(which easy_install)" ]; then
   apt-get -y install python-setuptools
   easy_install pip
elif [ -z "$(which pip)" -a -n "$(which easy_install)" ]; then
  easy_install pip
fi
# If python-keyczar apt package does not exist, use pi
[ -z "$( apt-cache search python-keyczar )" ] && sudo pip install python-keyczar

# Install Ansible module dependencies
apt-get install -y bzip2 file findutils git gzip mercurial procps subversion sudo tar debianutils unzip xz-utils zip python-selinux 

echo -e '[local]\nlocalhost\n' > /etc/ansible/hosts
pip install ansible

mkdir /tmp/ansible
# Clone remote repo
git clone https://${token}:${token_pass}@${url_git_repo} /tmp/ansible/

# Run ansible-playbook
ansible-playbook /tmp/ansible/${path_to_playbook} --extra-vars "cloud_user=${cloud_user} cloud_connection_name=${cloud_connection_name} 
cloud_password=${cloud_password} cloud_database=${cloud_database} cloud_storage=${cloud_storage} 
project=${project_id}"



