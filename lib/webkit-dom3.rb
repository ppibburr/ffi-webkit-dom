if !defined?(WebKit)
  begin
    require "gir_ffi"
  rescue LoadError
    require "rubygems"  
    require 'gir_ffi'
  end
  
  GirFFI.setup :WebKit,"3.0"    
end

require File.join(File.dirname(__FILE__),"webkit-dom","common","hard_code.rb")
