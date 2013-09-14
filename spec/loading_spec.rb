require 'spec_helper'

describe "My Vim plugin" do
  languages = Dir["#{$plugin_path}/syntax/*.vim"].map { |f| f.split('/').last.gsub('.vim', '') }

  languages.each do |lang|
    it "should parse .#{lang} file" do
      write_file "test.#{lang}", ""
      vim.edit "test.#{lang}"
      vim.insert "sample"
      vim.write
    end
  end
end
