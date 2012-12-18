require File.expand_path('test_helper.rb', File.dirname(__FILE__))

Gtk.init []
$ok = false
describe WebKit::DOMEventTarget do
  describe "#add_event_listener" do
    it "adds event listener and the listener responds" do
      wv = WebKit::WebView.new
      wv.load_html_string("<html><body></body></html>",'')
      wv.signal_connect 'load-finished' do
        de = wv.get_dom_document.get_document_element
      
        assert_kind_of(WebKit::DOMEventTarget,de)
      
        de.add_event_listener "click" do
          $ok = true
        end
      
        de.click() 
      
        assert $ok
      
        Gtk.main_quit
      end
      Gtk.main
    end
  end
end
