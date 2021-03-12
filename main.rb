# frozen_string_literal: true
require 'yaml'
require 'fileutils'
require 'markaby'

# IMPORT FUNCTIONS
require_relative './assets/scripts/resume.rb'       # create_resume_full
require_relative './assets/scripts/resume_slim.rb'  # create_resume_slim
require_relative './assets/scripts/resume_tech.rb'  # create_resume_tech
require_relative './assets/scripts/resume_serv.rb'  # create_resume_serv

# VARIABLES
mab_full = Markaby::Builder.new({ 
  data: YAML.load_file('./assets/data/resume.yaml') 
})
mab_slim = Markaby::Builder.new({ 
  data: YAML.load_file('./assets/data/resume_slim.yaml') 
})
mab_tech = Markaby::Builder.new({ 
  data: YAML.load_file('./assets/data/resume_tech.yaml') 
})
mab_serv = Markaby::Builder.new({ 
  data: YAML.load_file('./assets/data/resume_serv.yaml') 
})

# UPDATE STYLESHEET
%x(sass ./assets/stylesheets/index.scss ./style.css)

# HTML OUTPUTS
resume_full = File.new('./assets/outputs/resume_full.html', 'w+')
resume_full.puts create_resume_full(mab_full).to_s
resume_full.close()

resume_slim = File.new('./assets/outputs/resume_slim.html', 'w+')
resume_slim.puts create_resume_slim(mab_slim).to_s
resume_slim.close()

resume_tech = File.new('./assets/outputs/resume_tech.html', 'w+')
resume_tech.puts create_resume_tech(mab_tech).to_s
resume_tech.close()

resume_serv = File.new('./assets/outputs/resume_serv.html', 'w+')
resume_serv.puts create_resume_serv(mab_serv).to_s
resume_serv.close()

# SET INDEX
FileUtils.cp('./assets/outputs/resume_tech.html',
              './index.html')