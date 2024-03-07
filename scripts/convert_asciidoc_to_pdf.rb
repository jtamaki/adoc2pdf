require 'optparse'
opt = OptionParser.new
option = {}
opt.on('-i VAL', 'description:input asciidoc dir') {|v| option[:input] = v }
opt.on('-t VAL', 'description:themes dir') {|v| option[:themes] = v }
opt.on('-f VAL', 'description:fonts dir') {|v| option[:fonts] = v }
opt.on('-c VAL', 'description:converter dir') {|v| option[:converter] = v }
opt.on('-o VAL', 'description:output pdf dir') {|v| option[:output] = v }
opt.parse!(ARGV)

docs = Dir.glob("#{option[:input]}/**/*.adoc")
args = [
  "-a pdf-theme=specification",
  "-a pdf-themesdir=#{option[:themes]}",
  "-a pdf-fontsdir=#{option[:fonts]}",
  "-a scripts=cjk",
  "-r #{option[:converter]/extended-pdf-converter.rb}",
  "-D #{option[:output]}"
]

cmds = docs.map{|doc| "asciidoctor-pdf #{args.join(" ")} \"#{doc}\""}
cmds.each do |cmd|
  puts cmd
  system(cmd)
end
