require "./bindgencr/*"

require "option_parser"
require "colorize"
require "file"
require "xml"

BANNER = %q{
bindgencr filename.xml [-n LibName] [-l linkedlib ] [--no-prefix=prefix_]

  Usage:
    bindgencr [argument] [flags]

  Example:
    bindgencr json.xml -l json-c -n LibJsonC

  Flags:
}

libname = ""
link = ""
noprefix = ""

parser = OptionParser.parse! do |parser|
  parser.banner = BANNER

  parser.on("-h", "--help", "Show this help"){ puts parser; exit 0   }
  parser.on("-n", "--name=NAME", "The module name ( lib [name] )")                      { |ln| libname = ln     }
  parser.on("-l", "--link=LINK", "The library to link with (@[Link([link]) directive")  { |lk| link = lk        }
  parser.on("--no-prefix", "Remove the functions prefix")                               { |npf| noprefix = npf  }

  parser.invalid_option{ |opt| puts "Invalid option: #{opt}\n\n"; puts parser; exit 1 }

  # parser.missing_option{ |opt| puts "Missing option for #{opt}\n\n"; puts parser; exit 1 }
  # parser.unknown_args{ |opt| puts "Unkown arguments: #{opt}\n\n"; puts ARGV; exit 1 }
end

(puts "\nERROR: No lib --name given!".colorize(:red); puts parser; exit 1) if libname.empty?
(puts "\nERROR: No --link given!".colorize(:red); puts parser; exit 1) if link.empty?

filename : String
if ARGV.empty?
  (puts "No filename given"; exit 1)
else
  if File.exists? ARGV[0]
    filename = ARGV[0]
  else
    (puts "The file #{ARGV[0]} does not exist."; exit 1)
  end
end

xml = XML.parse(File.read(filename))
context = Bindgencr::Context.new xml

context.lib_info.libname = libname
context.lib_info.link = link
context.lib_info.prefix = noprefix

generator = Bindgencr::Generator.new context
puts generator.render
