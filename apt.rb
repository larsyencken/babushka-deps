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

