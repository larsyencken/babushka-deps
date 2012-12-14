dep 'python for statistics' do
    requires {
        on :osx, [
            'python',
            'numpy',
            'scipy',
            'ipython',
            'matplotlib',
            'pandas'
        ]
        on :ubuntu, [
            'python',
            'python-dev.managed',
            'numpy',
            'scipy',
            'ipython',
            'matplotlib',
            'pandas'
        ]
    }
end

dep 'python', :template => 'managed' do
    installs {
        via :apt, 'python'
        via :brew, 'python'
    }
    provides ['python']
end

dep 'python-dev.managed' do
    provides []
end

dep 'numpy.pip' do
    provides []
end

dep 'scipy' do
    requires {
        on :osx, 'python', 'scipy.pip'
        on :ubuntu, 'python', 'scipy.managed'
    }
end

dep 'scipy.managed' do
    installs {
        on :ubuntu, 'python-scipy'
    }
    provides []
end

dep 'scipy.pip' do
    provides []
end

dep 'ipython', :template => 'pip' do
end

dep 'matplotlib' do
    requires {
        on :osx, 'python', 'matplotlib.pip'
        on :ubuntu, 'python', 'matplotlib.managed'
    }
end

dep 'matplotlib.managed' do
    installs {
        on :ubuntu, 'python-matplotlib'
    }
    provides []
end

dep 'matplotlib.pip' do
    provides []
end

dep 'pandas', :template => 'pip' do
    provides []
end

dep 'numpy' do
    requires {
        on :osx, 'numpy.pip'
        on :ubuntu, 'numpy.managed'
    }
end

dep 'numpy.managed' do
    installs {
        via :apt, 'python-numpy'
    }
    provides []
end

dep 'scipy.managed' do
    installs {
        via :apt, 'python-scipy'
    }
    provides []
end

dep 'ipython.managed' do
    installs {
        via :apt, 'ipython'
    }
    provides ['ipython']
end

dep 'matplotlib.managed' do
    installs {
        via :apt, 'python-matplotlib'
    }
end

dep 'pandas.managed' do
    installs {
        via :apt, 'python-pandas'
    }
end

