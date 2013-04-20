dep 'playonlinux.managed' do
    installs {
        via :apt, 'playonlinux'
    }
    provides []
end

dep 'steam' do
    requires 'playonlinux.managed'
end
