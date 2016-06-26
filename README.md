# bindgencr

Little program to generate crystal binding file for C libraries.

## Installation

Install CastXML : https://github.com/CastXML/CastXML

Clone this repository
crystal compile src/bindgencr.cr


## Usage

Not yet complete, but can still generate the binding for sqlite3.h ( without enumerations for now, see samples/sqlite3 ).

castxml --castxml-gccxml [HEADER] -o [OUTPUT XML FILE]
crystal run src/bindgencr.cr -- [OUTPUT XML FILE] -l[library name] -n [name to put after "lib" keyword]

It will print the result to stdout for now

See spec and samples folder to see what can be done for now.

## Development

TODO: 
[x] Generate basic structure
[x] Generate simple types, pointers and struct
[x] Render functions declarations in context
[x] Add function pointer
[x] Add arrays
[x] Add CvQualifiedType
[x] Add Union
[ ] Add Enumeration
[x] Add pointer of callback
[ ] More and more

## Contributing

1. Fork it ( https://github.com/TechMagister/bindgencr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- TechMagister(https://github.com/TechMagister) Arnaud Fernandés - creator, maintainer
