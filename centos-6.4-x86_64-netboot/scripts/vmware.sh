# Bail if we are not running inside VMWare.
[ `facter virtual` == "vmware" ] || {
  exit 0
}

# Install the VMWare Tools from a linux ISO.

# probably need to do this eventually.
# the catch22 is that in a true hosted environment (eg rackspace?) we may
# not have access to the host system to install the VMware tools
#wget http://192.168.0.185/linux.iso -P /tmp
mkdir -p /mnt/vmware
# use the mount command to mount the iso stored in the the vagrant synced folder
# set with config.vm.synced_folder command in vagrantfile
# on the Mac, the VMWare Tools are stored under: Volumes:Macintosh HD:Applications:VMware Fusion.app:Contents:Library:isoimages
# linux.iso is the tools
# symlync to vagrant directory on the Mac (host system)
mount -o loop /home/vagrant/linux.iso /mnt/vmware

cd /tmp
tar xzf /mnt/vmware/VMwareTools-*.tar.gz

umount /mnt/vmware
rm -fr /home/vagrant/linux.iso

/tmp/vmware-tools-distrib/vmware-install.pl -d
rm -fr /tmp/vmware-tools-distrib
