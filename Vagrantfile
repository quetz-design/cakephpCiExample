Vagrant.configure(2) do |config|
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  config.vm.define :develop do |develop|
    develop.vm.hostname = "develop"
    develop.vm.box = "opscode-ubuntu-14.04"
    develop.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"
    develop.vm.network :private_network, ip:"192.168.33.10"

    develop.vm.synced_folder "application", "/var/www/application/current",
      id: "vagrant_root", :nfs => false,
      :owner => "vagrant",
      :group => "www-data",
      :mount_options => ["dmode=775,fmode=775"]
  end

  config.vm.define :ci do |ci|
    ci.vm.hostname = "ci"
    ci.vm.box = "opscode-ubuntu-14.04"
    ci.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"
    ci.vm.network :private_network, ip:"192.168.33.100"
  end

  config.vm.define :deploy do |deploy|
    deploy.vm.hostname = "deploy"
    deploy.vm.box = "opscode-ubuntu-14.04"
    deploy.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"
    deploy.vm.network :private_network, ip:"192.168.33.200"
  end
end
