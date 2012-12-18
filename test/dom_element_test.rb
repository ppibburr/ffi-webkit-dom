require File.expand_path('test_helper.rb', File.dirname(__FILE__))

Gtk.init []
$ok = false
wv = WebKit::WebView.new
wv.load_html_string("<html><body></body></html>",'')
wv.signal_connect 'load-finished' do
  de = (d=wv.get_dom_document).get_document_element
  div = d.create_element("div")
  body = de.get_elements_by_tag_name("body").item(0)
  body.append_child(div)
  div.set_attribute("tokenid","14")
  
  describe WebKit::DOMElement do
    describe "#add_event_listener" do
      it "adds event listener and the listener responds" do
        de.add_event_listener "click" do
          $ok = true
        end
        
        de.click() 
        assert $ok
      end
    end
  end
  list = de.get_elements_by_tag_name("body")
  
  describe WebKit::DOMNodeList do
    describe "#length" do
      it "should retuen integer" do
        assert_kind_of Integer,list.length
      end
    end
    
    describe "#each" do
      it "should accept block and iter over elements" do
        list.each do |e|
          assert_kind_of(WebKit::DOMElement,e)
        end
      end
    end
    
    describe "#[]" do
      it "should accept index and return value at index" do
        assert_kind_of(WebKit::DOMElement,list[0])  
      end
    end
  end

  describe WebKit::DOMDocument do
    describe "#query_selector" do
      it "should return object with same pointer address as div" do
        assert(d.query_selector('[tokenid="14"]').to_ptr.address == div.to_ptr.address)
      end
    end
  end
        
  Gtk.main_quit
end

Gtk.main
