dep 'python for statistics' do
    requires \
        'python',
        'numpy.pip',
        'scipy.pip',
        'ipython.pip',
        'matplotlib.pip',
        'pandas.pip'
end

dep 'python', :template => :managed do
    installs {
        via :apt, 'python'
        via :macports, 'python27'
        via :brew, 'python'
    }
    provides ['python']
end

dep 'numpy.managed' do
    installs {
        via :apt, 'python-numpy'
        via :macports, 'py27-numpy'
    }
    provides []
end

dep 'scipy.managed' do
    installs {
        via :apt, 'python-scipy'
        via :macports, 'py27-scipy'
    }
    provides []
end

dep 'ipython.managed' do
    installs {
        via :apt, 'ipython'
        via :macports, 'py27-ipython'
    }
    provides ['ipython']
end

dep 'matplotlib.managed' do
    installs {
        via :apt, 'python-matplotlib'
        via :macports, 'py27-matplotlib'
    }
    provides []
end

dep 'pandas.managed' do
    installs {
        via :apt, 'python-pandas'
        via :macports, 'py27-pandas'
    }
    provides []
end

