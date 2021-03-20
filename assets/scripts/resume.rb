# if !data['tmp'].nil?
# else
# end

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
      div class: 'header container item', id: 'resume-header' do
        # NAME
        if !data['name'].nil?
          h1 class: 'header-item', id: 'header-name' do
            data['name'].upcase
          end
        # else
        #   'UNNAMED RESUME'
        end # END OF HEADER-NAME

        # HEADLINE(S)
        if !data['headline'].nil?
          case data['headline'].class.to_s
          # SINGLE HEADLINE
          when 'String'
            p class: 'header-item', id: 'header-headline' do
              data['headline']
            end
          # MULTIPLE HEADLINES
          when 'Array'
            ul class: 'header-item', id: 'header-headline' do
              data['headline'].each do |head|
                li class: '' do
                  head
                end
              end
            end
          else
            'UNKNOWN HEADLINE(S)'
          end # END OF CASE
        end  # END OF HEADER-HEADLINE(S)

        # ABOUT
        if !data['about'].nil?
          p class: 'header-item', id: 'header-about' do
            data['about']
          end
        # else
        #   'UNKNOWN ABOUT'
        end  # END OF HEADER-ABOUT

        # CONTACT
        if !data['contact'].nil?
          ul class: 'header-item', id: 'header-contact' do
            data['contact'].each do |item|
              li class: 'contact-item', id: "contact-#{item['type']}" do
                # CONTACT TEXT
                span class: 'contact-item-text' do
                  if item['url'].nil?
                    item['text']
                  else
                    a class: 'link', href: item['url'] do
                      item['text']
                    end
                  end
                end
                # CONTACT ICON
                span class: 'contact-item-icon' do
                  item['icon']
                end
              end
            end
          end
        else
          'NO CONTACT INFORMATION'
        end  # END OF HEADER-CONTACT

      end  # END OF HEADER

      # RESUME CONTENT
      div class: 'content container', id: 'resume-content' do
        # PROJECTS & PUBLICATIONS
        div class: 'resume-content', id: 'projects' do
          h1 class: 'section-header' do
            'PROJECTS & PUBLICATIONS'
          end

          data['portfolio'].each do |port|
            case port['type']
            # PROJECTS
            when 'PROJECT'
              div class: 'port-item project item' do
                # TITLE
                p class: 'port-title' do
                  if !port['title'].nil?
                    port['title']
                  else
                    'UNTITLED PROJECT'
                  end  
                end  # END OF PROJ-TITLE

                # ABOUT
                if !port['about'].nil?
                  p class: 'port-about' do
                    port['about']
                  end
                # else
                #   'NO ABOUT'
                end  # END OF PROJ-ABOUT

                # SKILLS
                if !port['skills'].nil?
                  ul class: 'port-skills bubble-list' do
                    port['skills'].each do |skill|
                      li class: 'port-skill' do
                        skill
                      end
                    end
                  end
                # else
                #   'NO SKILLS'
                end  # END OF PROJ-SKILLS

                # DUTIES
                if !port['duties'].nil?
                  ul class: 'port-duties bullet-list' do
                    port['duties'].each do |skill|
                      li class: 'port-duty' do
                        skill
                      end
                    end
                  end
                # else
                #   'NO DUTIES'
                end  # END OF PROJ-DUTIES

                # LINKS
                if !port['links'].nil?
                  ul class: 'port-links proj-links' do
                    port['links'].each do |link|
                      li class: 'port-link' do
                        span class: 'port-link-text' do
                          "#{link['anchor'].upcase}:"
                        end
                        span class: 'port-link-link' do
                          a class: 'link', href: link['url'] do
                            link['url']
                          end
                        end
                      end
                    end
                  end   
                # else
                #   'NO LINKS'
                end  # END OF PROJ-LINKS
              end # END OF PROJ-ITEM

            # PUBLICATIONS
            when 'PUBLICATION'
              div class: 'port-item pub-item publication item' do
                # TITLE
                if !port['title'].nil?
                  p class: 'port-title' do
                    port['title']
                  end
                # else
                #   'NO TITLE'
                end  # END OF PUB-TITLE

                # ABOUT
                if !port['about'].nil?
                  p class: 'port-about' do
                    port['about']
                  end
                # else
                #   'NO ABOUT'
                end  # END OF PUB-ABOUT

                # SKILLS
                if !port['skills'].nil?
                  ul class: 'port-skills bubble-list' do
                    port['skills'].each do |skill|
                      li class: 'port-skill' do
                        skill
                      end
                    end
                  end
                # else
                #   'NO SKILLS'
                end  # END OF PUB-SKILLS
                
                # DUTIES
                if !port['duties'].nil?
                  ul class: 'port-duties bullet-list' do
                    port['duties'].each do |skill|
                      li class: 'port-duty' do
                        skill
                      end
                    end
                  end
                # else
                #   'NO DUTIES'
                end  # END OF PUB-DUTIES
                
                # CITATION
                if !port['citation'].nil?
                  div class: 'port-citation' do
                    span class: 'citation-authors' do
                      "#{port['citation']['authors']} " 
                    end
                    span class: 'citation-date' do
                      "(#{port['citation']['date']}). "
                    end
                    span class: 'citation-title' do
                      "#{port['citation']['title']}. "
                    end
                    span class: 'citation-publisher' do
                      "#{port['citation']['publisher']}."
                    end
                  end
                # else
                #   'NO CITATION'
                end  # END OF PUB-CITATION

                # LINK(S)
                if !port['links'].nil?
                  ul class: 'port-links pub-links' do
                    port['links'].each do |link|
                      li class: 'port-link' do
                        span class: 'port-link-text' do
                          " "
                        end

                        span class: 'port-link-link' do
                          a class: 'link', href: link['url'] do
                            link['anchor']
                          end
                        end
                      end
                    end
                  end 
                # else
                #   'NO LINK'
                end  # END OF PUB-LINK(S)
              end  # END OF PUB-ITEM
            else
              'UNKNOWN PROJECT TYPE'
            end  # END OF PORTFOLIO-CASE
          end 
        end  # END OF PROJECTS & PUBLICATIONS

        # EXPERIENCE
        div class: 'resume-content', id: 'experience' do
          # HEADER
          h1 class: 'section-header' do
            'EXPERIENCE'
          end

          data['experience'].each do |exp|
            case exp['type']

            # PROFESSIONAL
            when 'PROFESSIONAL'
              div class: 'exp-item professional item' do
                # TITLE
                if !exp['title'].nil?
                  p class: 'exp-title' do
                    exp['title']
                  end
                # else
                #   'NO TITLE'
                end

                # COMPANY
                if !exp['company'].nil?
                  p class: 'exp-company' do
                    exp['company']
                  end
                # else
                #   'NO COMPANY'
                end  # END OF EXP-COMPANY

                # LOCATION
                if !exp['location'].nil?
                  p class: 'exp-location' do
                    "(#{exp['location']})"
                  end
                # else
                #   'NO LOCATION'
                end  # END OF EXP-LOCATION

                # DATES_RANGE
                if !exp['date'].nil?
                  p class: 'exp-date_range' do
                    "#{exp['date']['start']} - #{exp['date']['end']}"
                  end
                # else
                #   'NO DATE(S)'
                end  # END OF EXP-DATES

                # SKILLS
                if !exp['skills'].nil?
                  ul class: 'exp-skills bubble-list' do
                    exp['skills'].each do |skill|
                      li class: 'exp-skill' do
                        skill
                      end
                    end
                  end
                # else
                #   'NO SKILLS'
                end  # END OF EXP-SKILLS

                # DUTIES
                if !exp['duties'].nil?
                  ul class: 'exp-duties bullet-list' do
                    exp['duties'].each do |duty|
                      li class: 'exp-duty' do
                        duty
                      end
                    end
                  end
                # else
                #   'NO DUTIES'
                end  # END OF EXP-DUTIES
              end  # END OF EXP-ITEM/PROFESSIONAL

            # VOLUNTEER
            when 'VOLUNTEER'
              div class: 'exp-item volunteer item' do
                # TITLE
                if !exp['title'].nil?
                  p class: 'exp-title' do
                    exp['title']
                  end
                # else
                #   'NO TITLE'
                end  # END OF EXP-TITLE

                # ORGANIZATION
                if !exp['organization'].nil?
                  p class: 'exp-organization' do
                    exp['organization']
                  end
                # else
                #   'NO ORGANIZATION'
                end  # END OF EXP-ORGANIZATION

                # LOCATION
                if !exp['location'].nil?
                  p class: 'exp-location' do
                    "(#{exp['location']})"
                  end
                # else
                #   'NO LOCATION'
                end  # END OF EXP-LOCATION

                # DATE(S)
                if !exp['date'].nil?
                  p class: 'exp-date_range' do
                    if !exp['date']['start'].nil? && exp['date']['end'].nil?
                      exp['date']['start']
                    elsif !exp['date']['start'].nil? && !exp['date']['end'].nil?
                      "#{exp['date']['start']} - #{exp['date']['end']}"
                    end
                  end
                # else
                #   'NO DATES'
                end  # END OF EXP-DATE

                # ABOUT
                if !exp['about'].nil?
                  p class: 'exp-about' do
                    exp['about']
                  end
                # else
                #   'NO ABOUT'
                end  # END OF EXP-ABOUT

                # # CAUSE
                # if !exp['cause'].nil?
                # else
                # end  # END OF EXP-CAUSE

                # DUTIES
                if !exp['duties'].nil?
                  ul class: 'exp-duties bullet-list' do
                    exp['duties'].each do |duty|
                      li class: 'exp-duty' do
                        duty
                      end
                    end
                  end
                # else
                #   'NO DUTIES'
                end  # END OF EXP-DUTIES

              end  # END OF EXP-ITEM/VOLUNTEER

            # ORGANIZATION
            when 'ORGANIZATION'
              div class: 'exp-item organization item' do
                # TITLE
                if !exp['title'].nil?
                  p class: 'exp-title' do
                    exp['title']
                  end
                # else
                #   'NO TITLE'
                end  # END OF EXP-TITLE
                
                # DATE(S)
                if !exp['date'].nil?
                  p class: 'exp-date_range' do
                    "#{exp['date']['start']} - #{exp['date']['end']}"
                  end
                # else
                #   'NO DATE(S)'
                end  # END OF EXP-DATES

                # ORGANIZATION
                if !exp['organization'].nil?
                  p class: 'exp-organization' do
                    exp['organization']
                  end
                # else
                #   'NO ORGANIZATION'
                end  # END OF EXP-ORGANIZATION

                # LOCATION
                if !exp['location'].nil?
                  p class: 'exp-location' do
                    "(#{exp['location']})"
                  end
                # else
                #   'NO LOCATION'
              end  # END OF EXP-LOCATION

              end  # END OF EXP-ITEM/ORGANIZATION

            else
              'UNKNOWN EXPERIENCE TYPE'
            end  # END OF EXP-CASE
          end  # END OF EXP-ITEM LOOP  
        end  # END OF EXPERIENCE

        # EDUCATION
        div class: 'resume-content', id: 'education' do
          # HEADER
          h1 class: 'section-header' do
            'EDUCATION'
          end

          data['education'].each do |edu|
            div class: 'edu-item education item' do
              # DEGREE (TYPE/TOPIC)
              if !edu['degree'].nil?
                if edu['degree']['topic'].nil?
                  p class: 'edu-degree' do
                    "#{edu['degree']['type'].upcase}"
                  end
                else
                  p class: 'edu-degree' do
                    "#{edu['degree']['type'].upcase}: #{edu['degree']['topic']}"
                  end
                end
              # else
              #   'NO DEGREE'
              end  # END OF EDU-DEGREE

              # SCHOOL
              if !edu['school'].nil?
                p class: 'edu-school' do
                  edu['school']
                end
              # else
              #   'NO SCHOOL'
              end  # END OF EDU-school

              # LOCATION
              if !edu['location'].nil?
                p class: 'edu-location' do
                  "(#{edu['location']})"
                end
              else
              end  # END OF EDU-LOCATION

              # DATE
              if !edu['date']['grad_year'].nil?
                p class: 'edu-grad_date' do
                  edu['date']['grad_year']
                end
              else
                p class: 'edu-grad_date' do
                  'CURRENTLY ENROLLED'
                end
              end  # END OF EDU-GRAD_DATE

              # CONTENT
              div class: 'edu-content' do
                ul class: 'edu-content-items bullet-list' do
                  # DUTIES
                  if !edu['duties'].nil?
                    edu['duties'].each do |item|
                      li class: 'edu-duty' do
                        item
                      end
                    end
                  # else
                  #   'NO DUTIES'
                  end  # END OF EDU-CONTENT-DUTIES

                  # ORGS
                  if !edu['orgs'].nil?
                    li class: 'edu-org' do
                      "#{edu['orgs'].join('; ')}"
                    end
                  # else
                  #   'NO ORGS'
                  end  # END OF EDU-CONTENT-ORGS

                  # ORGS
                end  # END OF CONTENT-LIST
              end  # END OF EDU-CONTENT
            end  # END OF EDU-ITEM
          end  # END OF EDU-ITEM LOOP
        end  # END OF EDUCATION

        # SKILLS/INTERESTS
        div class: 'resume-content', id: 'skills_interests' do
          # HEADER
          h1 class: 'section-header' do
            'SKILLS & INTERESTS'
          end

          div class: 'skin-content' do
            data['skills_interests'].each do |skin|
              case skin['type']
              when 'SKILLS'
                div class: 'skin-row skin-skills print-nobreak item' do
                  # ROW LEFT: TITLE
                  p class: 'skin-row-title' do
                    skin['title']
                  end
                  # ROW RIGHT: ITEMS
                  ul class: 'skin-row-items bubble-list' do
                    skin['items'].each do |item|
                      li class: 'skin-row-item' do
                        item
                      end
                    end
                  end
                end
              when 'INTERESTS'
                div class: 'skin-row skin-interests print-nobreak item' do
                  # ROW LEFT: TITLE
                  p class: 'skin-row-title' do
                    skin['title']
                  end
                  # ROW RIGHT: ITEMS
                  ul class: 'skin-row-items bubble-list' do
                    skin['items'].each do |item|
                      li class: 'skin-row-item' do
                        item
                      end
                    end
                  end
                end
              else
                'NO MATCHING SKILL/INTEREST TYPE'
              end  # END OF SKILLS_INTEREST CASE
            end  # END OF SKILLS_INTERESTS LOOP
          end  # END OF SKILLS_INTEREST-CONTENT

        end  # END OF SKILLS_INTERESTS

      end  # END OF RESUME CONTENT

    end  # END OF BODY
  end  # END OF HTML
end


