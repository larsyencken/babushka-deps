dep 'trash.managed' do
    installs {
        via :apt, 'trash-cli'
    }
    provides []
end

dep 'synergy.managed' do
    installs {
        via :apt, 'synergy'
        via :macports, 'synergy'
    }
    provides []
end

