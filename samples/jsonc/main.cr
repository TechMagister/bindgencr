require "./lib_jsonc"

json_str= File.read "samples/jsonc/sample.json"

new_obj = LibJsonC.json_tokener_parse(json_str)
obj_tostr = LibJsonC.json_object_to_json_string(new_obj)
puts "json to string = " + String.new(obj_tostr) + "\n"

test = LibJsonC.json_object_object_get(new_obj, "test")
puts "test to string = " + String.new(LibJsonC.json_object_to_json_string(test)) +"\n"

new_obj = LibJsonC.json_object_object_get(test, "count")
count = LibJsonC.json_object_get_int(new_obj)

sub = LibJsonC.json_object_object_get(test, "sub")

puts "sub = " + String.new(LibJsonC.json_object_to_json_string(sub)) +"\n"
puts "count = " + count.to_s + "\n"

LibJsonC.json_object_put(new_obj)
