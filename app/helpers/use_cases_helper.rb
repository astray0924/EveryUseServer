module UseCasesHelper
  require 'enumerator'
  
  def display_usecase_list(use_cases, span_width)
    if use_cases.blank?
      return nil
    end
    
    content_tag(:ul, :class => "use_cases thumbnails") do
      use_cases.collect.with_index do |use_case, index|
        content_tag(:li, :class => "span" + span_width.to_s) do 
          user_wow_id = get_wow_id(use_case, current_user)
          user_metoo_id = get_metoo_id(use_case, current_user)
          
          content_tag(:div, {
            :class => "thumbnail", 
            'data-usecase-id' => use_case.id,
            'data-user-id' => current_user ? current_user.id : 0,
            'data-user-wow-id' => user_wow_id,
            'data-user-metoo-id' => user_metoo_id}) do
              
              content_tag(:div, :class => 'usecase-photo-container') do
                # content_tag(:span, index + 1, :style => 'font-style: bold; font-size: 1.2em; color: #0099cc; display: block;') + 
                image_tag(use_case.photo.url(:large), :class => 'usecase-photo')
              end + 
              
              content_tag(:div, :class => 'caption') do
                
                # comments count
                content_tag(:p, :style => 'text-align: right;') do
                  # Wow count
                  content_tag(:span, :class => 'usecase-keyword wows-count') do
                    use_case.wows_count.to_s
                  end + 
                  " Wow " +
                   
                  # Metoo count
                  content_tag(:span, :class => 'usecase-keyword metoos-count') do
                    use_case.metoos_count.to_s
                  end + 
                  " Metoo"
                end.html_safe + 
                
                # description
                # I used ~ 
                content_tag(:p, :style => 'text-align: left; font-size: 14pt') do
                  "I used ".html_safe + 
                  content_tag(:span, :class => 'usecase-keyword') do
                    use_case.item.to_s
                  end.html_safe
                end.html_safe + 
                
                # As ~
                content_tag(:p, :style => 'text-align: right; font-size: 14pt') do
                  " As ".html_safe + 
                  content_tag(:span, :class => 'usecase-keyword') do
                    use_case.purpose.to_s
                  end.html_safe
                end.html_safe +
                
                # comment buttons
                if current_user
                  content_tag(:div, :class => 'btn-panel') do
                    # wow button
                    content_tag(:button, :class => 'btn wow btn-danger ' + (user_wow_id == 0 ? '' : 'active'), 
                    'data-toggle' => 'button') do
                      content_tag(:i, "", :class => 'icon-thumbs-up').html_safe + 
                      " Wow"
                    end.html_safe + 
                    
                    # metoo button
                    content_tag(:button, :class => 'btn metoo btn-primary ' + (user_metoo_id == 0 ? '' : 'active'), 
                    'data-toggle' => 'button', 
                    :style => "margin-left: 5px;") do
                      content_tag(:i, "", :class => 'icon-thumbs-up').html_safe + 
                      " Me, too"
                    end.html_safe
                  end
                end
              end
            end
        end
      end.join.html_safe
    end
  end
  
  def get_wow_id(use_case, current_user)
    if current_user and use_case.wow.where('user_id = ?', current_user.id).exists?
      id = use_case.wow.where('user_id = ?', current_user.id).first.id
    else
      id = 0
    end
  end
  
  def get_metoo_id(use_case, current_user)
    if current_user and use_case.metoo.where('user_id = ?', current_user.id).exists? 
      id = use_case.metoo.where('user_id = ?', current_user.id).first.id
    else
      id = 0
    end
  end
end
