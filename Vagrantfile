Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. For a detailed explanation
  # and listing of configuration options, please view the documentation
  # online.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "base"

  config.vm.customize do |vm|
    vm.memory_size = 1536
  end
  config.vm.network("33.33.33.10")
  config.vm.share_folder("v-root", "/vagrant", ".", :nfs => true)

  config.vm.provision :chef_solo do |chef|
    # This path will be expanded relative to the project directory
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe("vagrant_main")

    # this could be submoduled into (this is really just getting merged into) node.json
    chef.json.merge!({
      :php5 => {
        :resource_limits => {
          :max_execution_time => "80",
          :memory_limit => "384M",
        }
      },
      :mysql => {
        :server_root_password => "root",
        :bind_address => "127.0.0.1"
      },
      :apache => {
        :listen_ports => [ "8080", "443" ],
        :keepaliverequests => 10,
        :prefork => {
          :startservers => 2,
          :minspareservers => 1,
          :maxspareservers => 3,
          :serverlimit => 40,
          :maxclients => 40,
          :maxrequestsperchild => 1000
        },
        :worker => {
          :startservers => 2,
          :maxclients => 128,
          :minsparethreads => 16,
          :maxsparethreads => 128,
          :threadsperchild => 16,
          :maxrequestsperchild => 0
        }
      },
      :hosts => {
        :localhost_aliases => ["dev-site.vbox.local", "dev-site2.vbox.local"]
        # :entries => {
        #   # "pub.lic.ip" => "name"
        # }
      }
    })
  end
end
