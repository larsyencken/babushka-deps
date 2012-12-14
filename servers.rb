meta :custom_apt_source, :for => :ubuntu do
    accepts_value_for :key_cmd
    accepts_value_for :source_line

    template {
        met? {
            File.exists? "/etc/apt/sources.list.d/#{name.split('.')[0]}.list"
        }

        meet {
            shell "#{key_cmd}"
            shell "sudo bash -c 'echo #{source_line} >/etc/apt/sources.list.d/#{name.split('.')[0]}.list'"
            shell "sudo apt-get update"
        }
    }
end

dep 'varnish', :template => 'managed' do
    requires 'varnish.custom_apt_source'
    installs {
        via :apt, 'varnish'
    }
end

dep 'varnish.custom_apt_source' do
    key_cmd 'curl http://repo.varnish-cache.org/debian/GPG-key.txt | sudo apt-key add -'
    source_line "deb http://repo.varnish-cache.org/ubuntu/ #{shell 'lsb_release -cs'} varnish-3.0"
end

dep 'mongodb', :template => 'managed' do
    requires 'mongodb.custom_apt_source'
    installs {
        via :apt, 'mongodb-10gen'
    }
end

dep 'mongodb.custom_apt_source' do
    key_cmd 'sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10'
    source_line 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen'
end

dep 'sysadmin base' do
    requires ['vim', 'screen', 'htop']
end

dep 'vim', :template => 'managed' do
    installs {
        via :apt, 'vim-nox'
        via :brew, 'vim'
    }
    provides ['vim']
end

dep 'screen', :template => 'managed' do
end

dep 'htop', :template => 'managed' do
end
