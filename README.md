# bindgencr

Little program to generate crystal binding file for C libraries.

see also [crystal-lang/crystal_lib](https://github.com/crystal-lang/crystal_lib)

## Installation

- Install CastXML : https://github.com/CastXML/CastXML
- Clone this repository and enter the project folder
- `$ crystal build --release src/bindgencr.cr`


## Usage

Not yet complete, but can still generate the binding for sqlite3 and json-c ( perhaps some others )

```castxml --castxml-gccxml [HEADER] -o [OUTPUT XML FILE]```

```
bindgencr filename.xml [-n LibName] [-l linkedlib ] [--no-prefix=prefix_]

  Usage:
    bindgencr [argument] [flags]

  Example:
    bindgencr json.xml -l json-c -n LibJsonC

  Flags:

    -h, --help                       Show this help
    -n, --name=NAME                  The module name ( lib [name] )
    -l, --link=LINK                  The library to link with (@[Link([link]) directive
    --no-prefix                      Remove the functions prefix
```

It will print the result to stdout for now

See spec and samples folder to see what can be done for now.

## Development

TODO:

- [x] Generate basic structure
- [x] Generate simple types, pointers and struct
- [x] Render functions declarations in context
- [x] Add function pointer
- [x] Add arrays
- [x] Add CvQualifiedType
- [x] Add Union
- [x] Add Enumeration
- [x] Add pointer of callback
- [ ] More and more

### Samples

Samples are generated and used using those lines :

#### Sqlite3
```
castxml --castxml-gccxml /usr/include/sqlite3.h -o samples/sqlite3/libsqlite3.xml
crystal run src/bindgencr.cr -- samples/sqlite3/libsqlite3.xml -l sqlite3 -n LibSqlite3 > samples/sqlite3/lib_sqlite3.cr
crystal run samples/sqlite3/main.cr
```

#### Json-c
```
castxml --castxml-gccxml /usr/include/json-c/json.h -o samples/jsonc/json.xml
crystal run src/bindgencr.cr -- samples/jsonc/json.xml -l json-c -n LibJsonC > samples/jsonc/lib_jsonc.cr
crystal run samples/jsonc/main.cr
```

## Contributing

1. Fork it ( https://github.com/TechMagister/bindgencr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- TechMagister(https://github.com/TechMagister) Arnaud Fernandés - creator, maintainer
- [tzekid](https://github.com/tzekid) Mircea Ilie Ploscaru - maintainer