# bindgencr

Little program to generate crystal binding file for C libraries.

## Installation

Install CastXML : https://github.com/CastXML/CastXML

Clone this repository
crystal compile src/bindgencr.cr


## Usage

castxml --castxml-gccxml spec/input/basic_struct.h -o spec/input/basic_struct.xml
crystal run src/bindgencr.cr -- spec/input/basic_struct.xml

## Development

TODO: 
[x] Generate basic structure
[x] Generate simple types, pointers and struct
[ ] Render functions declarations in context
[ ] Add function pointer
[ ] Add pointer of function pointer :p
[ ] More and more

## Contributing

1. Fork it ( https://github.com/TechMagister/bindgencr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- TechMagister(https://github.com/TechMagister) Arnaud Fernandés - creator, maintainer
