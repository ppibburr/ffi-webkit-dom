module WebKit
  # Set up dom event target methods and include them in DOMElement
  Lib.attach_function :webkit_dom_event_target_add_event_listener,[:pointer,:string,GObject::Callback,:bool,:pointer],:void

  load_class :DOMEventTarget
  module DOMEventTarget
    def add_event_listener s,&b
      WebKit::Lib.webkit_dom_event_target_add_event_listener(self,s,b,false,nil)
    end  
  end

  load_class :DOMElement  
  class WebKit::DOMElement
    include WebKit::DOMEventTarget
  end
end
    p WebKit::WebView.instance_methods.sort
__END__
# Program is below
# Usage is near idential to ruby-js
Gtk.init []

w = Gtk::Window.new 0
v = WebKit::WebView.new
w.add v
v.load_html_string("<html><body><div id='test'>hi</div></body></html>","")

v.signal_connect "load-finished" do
  puts (de=(d=v.get_dom_document).get_document_element).methods.sort.join("\n")
  td = d.get_element_by_id("test")
  td.add_event_listener "click" do p :lick end
  td.set_attribute("foo","bar")
  v.execute_script("alert(document.getElementById('test').attributes['foo'].nodeValue);")
end

w.signal_connect "delete-event" do
  Gtk.main_quit
end 

w.show_all
Gtk.main

__END__
One could use ruby-js with WebKit::DOM api
Just that its redundant.
However maybe, only using RubyJS to access JS-land and not the DOM
May be a performane improvement, though a pain in the arse to follow.
Perhaps a DOMElement.to_js method???  (surely would abuse ID's or Attributes)
