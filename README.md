# must.cr [![Build Status](https://travis-ci.org/maiha/must.cr.svg?branch=master)](https://travis-ci.org/maiha/must.cr)

Library for dynamic typing in [Crystal](http://crystal-lang.org/).

#### Core class pollution
- `Object#must`

#### Features

- **Checking Types** : Dynamically guarantee object types
- **Casting Types** : Dynamically cast object types
- **Matching Features** : Object matching and data extraction

```crystal
# checking
1.must(Int32) # => 1
1.must(Bool)  # raises Must::TypeError

# casting
1.must.cast(String) # => "1"
1.must.cast(Bool)   # raises Must::CastError

# matching
708.must.match(/0/)          # => 708
708.must.match(/0(.)/, "$1") # => "8"
```

- crystal: 0.31.1

## Why not use `as` for casting?

- `as` checks types at **compile time**
- `must` checks type at **runtime**

```crystal
json = JSON.parse(%|{"a": 1}|)
json["a"].as_f                   # Unhandled exception: cast from Int64 to Float64 failed (runtime)
json["a"].raw.to_f               # undefined method 'to_f' for Array(JSON::Any) (compile time)
json["a"].raw.must.cast(Float64) # => 1.0
```

## Installation

1. Add the dependency to your `shard.yml`:

```yaml
dependencies:
  must:
    github: maiha/must
    version: 0.1.0
```

2. Run `shards install`

## Usage

```crystal
require "must"
```

## API

### any?, any
Checks `empty?` or not. It returns `true` if the class doesn't have `empty?` method.
```crystal
1.must.any?  # => true
1.must.any   # => 1
"".must.any? # => false
"".must.any  # raises Must::Error
```

## Development

## Contributing

1. Fork it (<https://github.com/maiha/must.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [maiha](https://github.com/maiha) - creator and maintainer
