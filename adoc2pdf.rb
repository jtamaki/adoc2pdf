require 'optparse'
options = {}
opt = OptionParser.new do |opt|
  opt.on('-i DIR', 'input asciidoc directory path')
  opt.on('-o DIR', 'output pdf directory path')
  opt.parse(ARGV, into: options)
end

docs = Dir.glob("#{options[:i]}/**/*.adoc")
args = [
  "-a pdf-theme=specification",
  "-a pdf-themesdir=#{__dir__}/themes",
  "-a pdf-fontsdir=#{__dir__}/fonts",
  "-a scripts=cjk",
  "-r #{__dir__}/converters/extended-pdf-converter.rb",
  "-D #{options[:o]}"
]

cmds = docs.map{|doc| "asciidoctor-pdf #{args.join(" ")} \"#{doc}\""}
cmds.each do |cmd|
  puts cmd
  system(cmd)
end
