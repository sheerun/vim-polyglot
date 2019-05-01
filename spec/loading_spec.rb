require 'spec_helper'
require 'timeout'

describe "My Vim plugin" do

  extensions = `cat ftdetect/polyglot.vim | grep '^au' | tr "\t" ' ' | cut -d ' ' -f 3 | grep -v / | grep -v '^\*$' | grep -v '^$'`.strip

  extensions.gsub!(/\[(.).+\]/) { $1 }.gsub!('*', 'test')

  extensions = extensions.split(/[\n,]/)

  extensions.sort!.uniq!.each do |ext|
    if ext.match?(/^[a-z\.]+$/i)
      it "should parse #{ext} file" do
        Timeout::timeout(20) do
          write_file "#{ext}", ""
          vim.edit "#{ext}"
          vim.insert "sample"
          vim.write
        end
      end
    end
  end

  after(:all) do
    vim.kill
  end
end
