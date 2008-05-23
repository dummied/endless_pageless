module EndlessPagelessHelper #nodoc
  
  # Adds the hooks needed for our javascript to work. Just add this method to your views beneath the id-labeled element you're planning to fill and pass it the paginating_find object. As in:
  # <%= index_tags(@items) %>
  # This will also guess a name for the items you're filling based on the model. For instance, if you're loading Users, the more loading message will be "More users are being loaded". If this isn't the behavior you're looking for, you can also pass it a label. As in:
  # <%= index_tags(@items, "items") %>
  def index_tags(pages, items, label=nil)
    string = ""
    string << "#{hidden_field_tag :items_index, ""}\n" 
  	string << "#{hidden_field_tag :total_pages, pages.page_count}\n"
  	string << "#{hidden_field_tag :page_id, Time.now.to_i}\n"
    string <<	"<div style=\"display:none;\" id=\"more_loading\"><strong>More #{(label ? label : stringify(items))} are being loaded...</strong><br />If you are using the scroll bar, release your mouse to see more.</div>\n"
  	string << "<div style=\"display:none;\" id=\"page_end\"></div>\n"
  	string << "<div style=\"display:none;\" id=\"no_results\"></div>\n"
  	string << "<div style=\"position:absolute;top:0px;left:0px;visibility:hidden;\" id=\"spacer\">&nsbp;</div>\n"
    return string
  end
  
  # Outputs the navigation for the non-JS fallback. Add this method above (or above and below) your to-be-filled div and pass it a paginating_find object. As in:
  # <%= pageless_navigation(@items) %>
  # If you want to add classes other than the required "pageless_navigation," you can pass them as a string along with your object. As in:
  # <%= pageless_navigation(@items, "my_class clearfix your_class") %> 
  def pageless_navigation(pages, items, extra_classes=nil)
    string = ""
    string << "<div class=\"pageless_navigation#{(extra_classes ? " " + extra_classes : "")}\">\n"
    string <<	"#{(pages.previous_page? ? link_to("Previous page", :page => pages.previous_page) : "")}&nbsp;&nbsp;&nbsp;"
    string <<	"#{(pages.next_page? ? link_to("Next page", :page => pages.next_page) : "")}\n"
    string << "</div>\n"
    return string
  end
  
  # Can be used to generalize your views if you're sneaky. Basically, if all your to-be-filled elements have the same id, you can use this to set partial names and symbols to send to those partials. As in: :partial => "#{stringify(@items)}list", :locals => {stringify(@items).to_sym => @items} ... then all your controllers can use filler.rjs to fill their divs (as long as you name your partials and their variables properly).
  def stringify(items, pluralize='yes')
    classage = items.first.class.to_s.downcase
    if pluralize == 'yes'
      classage = classage.pluralize
    end
    return classage
  end
    
end