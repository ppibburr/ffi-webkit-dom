require 'rubygems'
require 'webkit-dom'


Gtk.init []
v = WebKit::WebView.new
v.load_html_string("<html><body></body></html>",'')
v.signal_connect("load-finished") do
  document = (d=v.get_dom_document).get_document_element
  body = document.get_elements_by_tag_name("body").item(0)
  div = d.create_element("div")
  div.set_attribute("tokenid","14")
  body.append_child(div)
  p d.query_selector('[tokenid="14"]').to_ptr.address,div.to_ptr.address
  Gtk.main_quit
end
Gtk.main
