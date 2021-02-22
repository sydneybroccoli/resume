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
            div class: 'proj-item project item' do
              # TITLE
              p class: 'proj-title' do
                proj['title']
              end
              # ABOUT
              p class: 'proj-about' do
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
                      span { "#{link['anchor'].upcase}: " }
                      span do
                        a link['url'], href: link['url']
                      end
                    end
                  end
                end           
              end
            end # END OF PROJECT ITEM
          end # END OF PROJ LOOP

          # PUBLICATIONS
          data['projects']['publications'].each do |pub|
            div class: 'proj-item publication item' do
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
            div class: 'exp-item experience item' do
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
            div class: 'exp-item volunteer item' do
              # TITLE
              p class: 'vol-title' do
                vol['title']
              end
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
              # # CAUSE
              # p class: 'vol-cause' do
              #   vol['cause']
              # end
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

          data['education'].each do |edu|
            div class: 'edu-item item' do
              # DEGREE (TYPE / TOPIC)
              if edu['degree']['topic'].nil?
                p class: 'edu-degree' do
                  "#{edu['degree']['type'].upcase}"
                end
              else
                p class: 'edu-degree' do
                  "#{edu['degree']['type'].upcase}: #{edu['degree']['topic']}"
                end
              end

              # SCHOOL
              p class: 'edu-school' do
                edu['school']
              end
              # DATE
              p class: 'edu-grad_date' do
                edu['date']['grad_year']
              end
              # LOCATION
              p class: 'edu-location' do
                "(#{edu['location']})"
              end
              div class: 'edu-content' do
                # DUTIES
                ul class: 'edu-duties bullet-list' do
                  if !edu['duties'].nil?
                    edu['duties'].each do |duty|
                      li class: 'edu-duty' do
                        duty
                      end
                    end
                  end
                end
                # ORGS
                ul class: 'edu-orgs bullet-list' do
                  if !edu['orgs'].nil?
                    li class: 'edu-org' do
                      "ORGANIZATIONS: #{edu['orgs'].join('; ')}"
                    end
                  end
                end
              end
            end # END OF EDU-ITEM
          end
        end # END OF EDUCATION

        # SKILLS/INTERESTS
        div class: 'resume-content', id: 'skills_interests' do
          h1 class: 'section-header' do
            'SKILLS/INTERESTS'
          end

          skills = data['skills_interests']['skills']
          interests = data['skills_interests']['interests']

          # SKILLS
          div class: 'skills-content' do
            # ROW: FRONT-END
            div class: 'si-row', id: 'skills-front-end' do
              p class: 'row-title', id: 'title_front-end' do 
                'FRONT-END'
              end
              ul class: 'skills-list row-list bubble-list', id: 'list_front-end' do
                skills['technical']['front_end'].each do |skill|
                  li class: 'skill-item' do
                    skill
                  end
                end
              end
            end
            # ROW: BACK-END
            div class: 'si-row', id: 'skills-back-end' do
              p class: 'row-title', id: 'title_back-end' do 
                'BACK-END'
              end
              ul class: 'skills-list row-list bubble-list', id: 'list_back-end' do
                skills['technical']['back_end'].each do |skill|
                  li class: 'skill-item' do
                    skill
                  end
                end
              end
            end
            # ROW: TOOLS
            div class: 'si-row', id: 'skills-tools' do
              p class: 'row-title', id: 'title_tools' do 
                'TOOLS'
              end
              ul class: 'skills-list row-list bubble-list', id: 'list_tools' do
                skills['technical']['tools'].each do |skill|
                  li class: 'skill-item' do
                    skill
                  end
                end
              end
            end
            # ROW: OTHER
            div class: 'si-row', id: 'skills-other' do
              p class: 'row-title', id: 'title_other' do 
                'OTHER'
              end
              ul class: 'skills-list row-list bubble-list', id: 'list_other' do
                skills['technical']['other'].each do |skill|
                  li class: 'skill-item' do
                    skill
                  end
                end
                skills['non_technical'].each do |skill|
                  li class: 'skill-item' do
                    skill
                  end
                end
              end
            end
          end

          # INTERESTS
          div class: 'interests-content' do
            div class: 'si-row', id: 'interests' do
              p class: 'row-title', id: 'title_interests' do 
                'INTERESTS'
              end
              ul class: 'interests-list row-list bubble-list', id: 'list_interests' do
                interests['technical'].each do |interest|
                  li class: 'interest-item' do
                    interest
                  end
                end
                interests['non_technical'].each do |interest|
                  li class: 'interest-item' do
                    interest
                  end
                end
              end
            end
          end          
        end # END OF SKILLS/INTERESTS
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