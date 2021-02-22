# frozen_string_literal: true
require 'yaml'
require 'fileutils'
require 'markaby'

# style_uri = path()
# output_uri = path()

data_full = YAML.load_file('./data/resume.yaml')
mab_full = Markaby::Builder.new( { data: data_full } )

def create_resume_full( resume )
  resume.html do
    # HTML HEADER
    head do
      title 'SYDNEY BAROVSKY RESUME (FULL)'
      link rel: 'stylesheet', href: './style.css'
      link rel: 'stylesheet', href: 'https://use.fontawesome.com/releases/v5.0.10/css/all.css'
    end

    # HTML BODY
    body do
      # RESUME HEADER
      div class: 'container', id: 'resume-header' do
        # HEADER MAIN
        div class: 'header-content col-left', id: 'header-main' do
          # NAME
          h1 id: 'header-name' do
            data['name'].upcase
          end

          # HEADLINE
          case data['headline']
            when String
              p class: 'headline-item', id: 'header-headline' do
                data['headline']
              end
            when Array
              ul class: '', id: 'header-headlines' do
                data['headline'].each do |headline|
                  li class: 'headline-item' do
                    headline
                  end
                end
              end
          end

          # ABOUT
          p class: '', id: 'header-about' do
            data['about']
          end
        end

        # HEADER CONTACT
        div class: 'header-content col-right', id: 'header-contact' do
          # CONTACT LIST
          ul class: '', id: 'contact-items' do
            data['contact'].each do |item|
              li class: 'contact-item', id: "contact-#{item['type']}" do
                # CONTACT TEXT
                span class: 'contact-text' do
                  if item['url'].nil?
                    item['text']
                  else
                    a item['text'], href: item['url']
                  end
                end
                # CONTACT ICON
                span class: 'contact-icon' do
                  item['icon']
                end
              end
            end
          end
        end
      end # END OF RESUME-HEADER

      # RESUME CONTENT
      div class: 'content container', id: 'resume-content' do
        # PROJECTS
        div class: 'resume-content', id: 'projects' do
          h1 class: 'section-header' do
            'PROJECTS'
          end
        end
        # EXPERIENCE
        div class: 'resume-content', id: 'experience' do
          h1 class: 'section-header' do
            'EXPERIENCE'
          end
        end
        # EDUCATION
        div class: 'resume-content', id: 'education' do
          h1 class: 'section-header' do
            'EDUCATION'
          end
        end
        # SKILLS/INTERESTS
        div class: 'resume-content', id: 'skills_interests' do
          h1 class: 'section-header' do
            'SKILLS'
          end
        end
      end  # END OF RESUME CONTENT

    end  # END OF BODY
  end  # END OF HTML
end

# UPDATE STYLESHEET
%x(sass ../assets/stylesheets/index.scss ../style.css)

# SAVE HTML OUTPUTS
resume = File.new('./outputs/resume.html', 'w+')
resume.puts create_resume_full(mab_full).to_s
resume.close()

# SET INDEX
FileUtils.cp('../assets/outputs/resume.html',
              '../index.html')