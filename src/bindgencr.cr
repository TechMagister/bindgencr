require "./bindgencr/*"

require "commander"
require "file"

COMMAND_NAME = "bindgencr"

def parse_file(filename)

end

def main(options, arguments : Array(String))

  if arguments.size == 1 && File.exists?(arguments[0])
    parse_file(arguments[0])
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
  cmd.long = COMMAND_NAME + " filename"

  #cmd.flags.add do |flag|
  #  flag.name = "env"
  ##  flag.short = "-e"
  #  flag.long = "--env"
   # flag.default = "development"
  #  flag.description = "The environment to run in."
  #end

  cmd.run do |options, arguments|
    #options.string["env"]    # => "development"
    #options.int["port"]      # => 8080
    #options.float["timeout"] # => 29.5
    #options.bool["verbose"]  # => false
    #arguments                # => Array(String)
    main(options, arguments)
  end
end

Commander.run(cli, ARGV)