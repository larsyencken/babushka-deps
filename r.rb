# -*- coding: utf-8 -*-
#
#  r.rb
#  babushka-deps
#

R_CRAN_MIRROR="http://cran.ms.unimelb.edu.au/"

dep 'R', :template => 'managed' do
  installs {
    via :apt, 'r-base'
    via :brew, 'R'
  }
  provides ['R', 'Rscript']
end

meta 'r' do
  accepts_value_for :name, :basename
  template {
    requires 'R'
    met? {
      shell? %[Rscript -e 'library("#{name}")']
    }
    meet {
      shell %[Rscript -e 'install.packages("#{name}", repos="#{R_CRAN_MIRROR}")'], :sudo => (! File.writable? "/usr/local/lib")
    }
  }
end

dep 'r for statistics' do
  requires 'ggplot2.r',
    'caret.r',
    'reshape.r',
    'randomForest.r',
    'RColorBrewer.r',
    'boot.r',
    'tree.r',
    'e1071.r',
    'medley.r'
end

dep 'medley.r' do
  requires 'devtools.r'
  meet {
      shell %[echo "library(devtools); install_github('medley', 'mewo2')" | R CMD BATCH --no-save --no-restore /dev/stdin /dev/stdout], :sudo => (! File.writable? "/usr/local/lib")
  }
end

dep 'devtools.r'
dep 'ggplot2.r'
dep 'caret.r'
dep 'reshape.r'
dep 'randomForest.r'
dep 'RColorBrewer.r'
dep 'boot.r'
dep 'tree.r'
dep 'e1071.r'
dep 'RMySQL.r'
