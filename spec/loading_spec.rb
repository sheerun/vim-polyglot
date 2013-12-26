require 'spec_helper'
require 'timeout'

describe "My Vim plugin" do

  extensions = `cat ftdetect/polyglot.vim | grep '^au' | tr "\t" ' ' | cut -d ' ' -f 3 | grep -v / | grep -v '^\*$' | grep -v '^$'`.strip

  extensions.gsub!(/\[(.).+\]/) { $1 }.gsub!('*', 'test')

  extensions = extensions.split(/[\n,]/)

  extensions.each do |ext|
    it "should parse #{ext} file" do
      Timeout::timeout(5) do
        write_file "#{ext}", ""
        vim.edit "#{ext}"
        vim.insert "sample"
        vim.write
      end
    end
  end
end
