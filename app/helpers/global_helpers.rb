module Merb
  module GlobalHelpers
  
    def page_title title
        throw_content :title,title
    end
    
    def include_wysywig
      uses_tiny_mce
      #throw_content :wyswig do
      # js_include_tag( :nicEdit) +
       #tag( :script,'bkLib.onDomLoaded(nicEditors.allTextAreas);',:language=>'JavaScript')
      #end
    end
    
    def uses_tiny_mce
      throw_content :tiny_mce do
        js_include_tag "tiny_mce/tiny_mce"
      end
      
      throw_content :tiny_mce_init do
        js_include_tag "tiny_mce/mce_editor"
      end
  end
    
    def jquery
      throw_content :jquery, js_include_tag( :jquery,:application)
    end

    # displays a message from the message method if it exists and wraps it
    # in a content tag 
    def message_display
      if message[:notice]
        tag :div ,message[:notice] , :class=>'notice'
      elsif message[:error]
        tag :div, message[:error], :class=>'error'
      end
    end

    def authenticated?
      return true if session[:user]
    end
    
    def auth?
      authenticated?
    end

    # TODO jak będzie już poprawienie zrobione tłumaczenie to przywrócić to wszystko
    # TODO zrobic wyrażenie regularne z tego syfu
    # FIXME nie działa poprawnie wyświetlanie sćieżki '/(język)'
    def menu_item options
      link = link_to(options.key?(:name) ? options[:name] : 'no name given',
    		     #options.key?(:route) ? "/#{language}#{options[:route]}" : "#{language}/",
    		     options.key?(:route) ? options[:route] : '/',
 		     options.key?(:id) ? {:id=>options[:id]} : '')
      
      if request.path =~ /^#{options[:route]}/
 	tag 'li',link ,:class=>'current'
      else
	tag 'li', link
      end
    end
  end
end