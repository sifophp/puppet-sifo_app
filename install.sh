yum install -y git
git clone --recursive https://github.com/sifophp/sifo-provisioning.git

# Install librarian-puppet:
gem install librarian-puppet

# Install puppet and replace with repo
rpm -ivh http://yum.puppetlabs.com/el/7/products/x86_64/puppetlabs-release-7-11.noarch.rpm
yum install -y puppet
mv /etc/puppet/ /etc/puppet_original
mv sifo-provisioning /etc/puppet

# Install puppet dependencies:
source install-puppet-modules.sh

# cron task to regularly run puppet apply on a main manifest
# sudo puppet resource cron puppet-apply ensure=present user=root minute=30 command='/usr/bin/puppet apply /etc/puppet/manifests/site.pp'

/usr/bin/puppet apply /etc/puppet/manifests/site.pp

