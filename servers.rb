dep 'varnish' do
    requires 'varnish.managed'
end

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

dep 'varnish.managed' do
    requires 'varnish.custom_apt_source'
    installs {
        via :apt, 'varnish'
    }
    provides []
end

dep 'varnish.custom_apt_source' do
    key_cmd 'curl http://repo.varnish-cache.org/debian/GPG-key.txt | sudo apt-key add -'
    source_line "deb http://repo.varnish-cache.org/ubuntu/ #{shell 'lsb_release -cs'} varnish-3.0"
end

dep 'mongodb' do
    requires 'mongodb.managed'
end


dep 'mongodb.managed' do
    requires 'mongodb.custom_apt_source'
    installs {
        via :apt, 'mongodb-10gen'
    }
    provides []
end

dep 'mongodb.custom_apt_source' do
    key_cmd 'sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10'
    source_line 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen'
end

