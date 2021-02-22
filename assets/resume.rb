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
          # TECHNICAL PROJECTS
          data['projects']['technical'].each do |proj|
            div class: 'proj-item project' do
              # TITLE
              p class: 'proj-title' do
                proj['title']
              end
              # ABOUT
              p class: 'proj-title' do
                proj['about']
              end
              # SKILLS
              ul class: 'proj-skills bubble-list' do
                proj['skills'].each do |skill|
                  li class: 'proj-skill' do
                    skill
                  end
                end
              end
              # DUTIES
              ul class: 'proj-duties bullet-list' do
                proj['duties'].each do |skill|
                  li class: 'proj-duty' do
                    skill
                  end
                end
              end
              # LINKS
              if !proj['links'].nil?
                ul class: 'proj-links' do
                  proj['links'].each do |link|
                    li class: 'proj-link' do
                      a link['anchor'], href: link['url']
                    end
                  end
                end           
              end
            end # END OF PROJECT ITEM
          end # END OF PROJ LOOP

          # PUBLICATIONS
          data['projects']['publications'].each do |pub|
            div class: 'proj-item publication' do
              # CITATION
              div class: 'pub-citation' do
                span class: 'pub-authors' do
                  "#{pub['authors']} " 
                end
                span class: 'pub-date' do
                  "(#{pub['date']}). "
                end
                span class: 'pub-title' do
                  "#{pub['title']}. "
                end
                span class: 'pub-publisher' do
                  "#{pub['publisher']}."
                end
              end
              # LINK
              a pub['link']['anchor'], href: pub['link']['url']
            end
          end
        end

        # EXPERIENCE
        div class: 'resume-content', id: 'experience' do
          h1 class: 'section-header' do
            'EXPERIENCE'
          end

          # PROFESSIONAL
          data['experience']['professional'].each do |exp|
            div class: 'exp-item experience' do
              # TITLE
              p class: 'exp-title' do
                exp['title']
              end

              # COMPANY
              p class: 'exp-company' do
                exp['company']
              end

              # LOCATION
              p class: 'exp-location' do
                "(#{exp['location']})"
              end
              
              # DATE
              p class: 'exp-date_range' do
                "#{exp['date']['start']} - #{exp['date']['end']}"
              end
              
              # SKILLS
              ul class: 'exp-skills bubble-list' do
                exp['skills'].each do |skill|
                  li class: 'exp-skill' do
                    skill
                  end
                end
              end
              
              # DUTIES
              ul class: 'exp-duties bullet-list' do
                exp['duties'].each do |duty|
                  li class: 'exp-duty' do
                    duty
                  end
                end
              end
            
            end
          end

          # VOLUNTEER
          data['experience']['volunteer'].each do |vol|
            div class: 'exp-item volunteer' do
              # ORGANIZATION
              p class: 'vol-organization' do
                vol['organization']
              end
              # LOCATION
              p class: 'vol-location' do
                "(#{vol['location']})"
              end
              # DATE
              p class: 'vol-date_range' do
                if !vol['date']['start'].nil? && vol['date']['end'].nil?
                  vol['date']['start']
                elsif !vol['date']['start'].nil? && !vol['date']['end'].nil?
                  "#{vol['date']['start']} - #{vol['date']['end']}"
                end
              end
              # CAUSE
              p class: 'vol-cause' do
                vol['cause']
              end
              # ABOUT
              p class: 'vol-about' do
                vol['about']
              end
              # DUTIES
              ul class: 'vol-duties bullet-list' do
                vol['duties'].each do |duty|
                  li class: 'vol-duty' do
                    duty
                  end
                end
              end
            end
          end

          # ORGANIZATIONS
          data['experience']['organizations'].each do |org|
            div class: 'exp-item organization' do
              # ORGANIZATION
              p class: 'org-organization' do
                org['organization']
              end
              # POSITION
              p class: 'org-position' do
                org['position']
              end
              # DATE_RANGE
              p class: 'org-date_range' do
                "#{org['date']['start']} - #{org['date']['end']}"
              end
            end
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