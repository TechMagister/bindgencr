require "./bindgencr/*"

require "commander"
require "file"
require "xml"

COMMAND_NAME = "bindgencr"

def parse_file(filename, libname, link, noprefix)
  xml = XML.parse(File.read(filename))
  context = Bindgencr::Context.new xml
  context.lib_info.libname = libname
  context.lib_info.link = link
  context.lib_info.prefix = noprefix if noprefix
  generator = Bindgencr::Generator.new context
  puts generator.render
end

def main(options, arguments : Array(String))
  if arguments.size == 1 && File.exists?(arguments[0])
    parse_file(arguments[0], options.string["libname"], options.string["link"], options.string["no-prefix"])
  elsif arguments.size == 0
    puts "Please provide the file to parse."
  elsif arguments.size > 1
    puts "Too many arguments given."
  else
    puts "The file " + arguments[0] + " does not exists."
  end
end

cli = Commander::Command.new do |cmd|
  cmd.use = COMMAND_NAME
  cmd.long = COMMAND_NAME + " [-n LibName] [-l linkedlib ] [--no-prefix=prefix_] filename.xml"

  cmd.flags.add do |flag|
    flag.name = "libname"
    flag.short = "-n"
    flag.long = "--name"
    flag.default = "LibNoName"
    flag.description = "The module name ( lib [name] )"
  end

  cmd.flags.add do |flag|
    flag.name = "no-prefix"
    #flag.short = "-r"
    flag.long = "--no-prefix"
    flag.default = ""
    flag.description = "Remove the functions prefix"
  end

  cmd.flags.add do |flag|
    flag.name = "link"
    flag.short = "-l"
    flag.long = "--link"
    flag.default = "lib-so"
    flag.description = "The library to link with (@[Link([link])] directive)"
  end

  cmd.run do |options, arguments|
    # options.string["env"]    # => "development"
    # options.int["port"]      # => 8080
    # options.float["timeout"] # => 29.5
    # options.bool["verbose"]  # => false
    # arguments                # => Array(String)
    main(options, arguments)
  end
end

Commander.run(cli, ARGV)
