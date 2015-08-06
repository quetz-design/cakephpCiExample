Vagrant.configure(2) do |config|
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  config.vm.define :develop do |develop|
    develop.omnibus.chef_version = :latest
    develop.vm.hostname = "develop"
    develop.vm.box = "opscode-ubuntu-14.04"
    develop.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"
    develop.vm.network :private_network, ip:"192.168.33.10"

    develop.vm.synced_folder "application", "/var/www/application/current",
      id: "vagrant_root", :nfs => false,
      :owner => "vagrant",
      :group => "www-data",
      :mount_options => ["dmode=775,fmode=775"]

    develop.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "./chef-repo/cookbooks"
      chef.json = {
        nginx: {
          docroot: {
            owner: "vagrant",
            group: "vagrant",
            path: "/var/www/application/current/app/webroot",
            force_create: true
          },
          default: {
            fastcgi_params: { CAKE_ENV: "development" }
          },
          test: {
            available: true,
            fastcgi_params: { CAKE_ENV: "test" }
          }
        }
      }
      chef.run_list = %w[
        recipe[apt]
        recipe[phpenv]
      ]
    end
  end

  config.vm.define :ci do |ci|
    ci.omnibus.chef_version = :latest
    ci.vm.hostname = "ci"
    ci.vm.box = "opscode-ubuntu-14.04"
    ci.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"
    ci.vm.network :private_network, ip:"192.168.33.100"
  end

  config.vm.define :deploy do |deploy|
    deploy.omnibus.chef_version = :latest
    deploy.vm.hostname = "deploy"
    deploy.vm.box = "opscode-ubuntu-14.04"
    deploy.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"
    deploy.vm.network :private_network, ip:"192.168.33.200"
  end
end
