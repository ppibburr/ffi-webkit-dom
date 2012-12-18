require File.expand_path('test_helper.rb', File.dirname(__FILE__))

describe "Upon load" do
  it "WebKit should be loaded" do
    WebKit
  end
  
  it "WebKit::WebView should have instance_method :get_dom_document"  do
    assert !!WebKit::WebView.instance_methods.index(:get_dom_document)
  end  
end
