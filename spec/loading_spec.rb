require 'spec_helper'
require 'tempfile'

describe "My Vim plugin" do

  extensions = `cat ftdetect/polyglot.vim | grep '^au' | tr "\t" ' ' | cut -d ' ' -f 3 | grep -v / | grep -v '^\*$' | grep -v '^$'`.strip

  extensions.gsub!(/\[(.).+\]/) { $1 }.gsub!('*', 'test')

  extensions = extensions.split(/[\n,]/)

  extensions.each do |ext|
    unless ext.match(/styl(us)?$/)
      it "should parse #{ext} file" do
        write_file "#{ext}", ""
        vim.edit "#{ext}"
        vim.insert "sample"
        vim.write
      end
    end
  end
end
