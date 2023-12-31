# ruby-vips

[![Gem Version](https://badge.fury.io/rb/ruby-vips.svg)](https://badge.fury.io/rb/ruby-vips)
[![Test](https://github.com/libvips/ruby-vips/workflows/Test/badge.svg)](https://github.com/libvips/ruby-vips/actions?query=workflow%3ATest)

This gem is a Ruby binding for the [libvips image processing
library](https://libvips.github.io/libvips). It has been tested on
Linux, macOS and Windows, and with ruby 2, ruby 3 and jruby. It uses
[ruby-ffi](https://github.com/ffi/ffi) to call functions in the libvips
library.

libvips is a [demand-driven, horizontally
threaded](https://github.com/libvips/libvips/wiki/Why-is-libvips-quick)
image processing library. Compared to similar
libraries, [libvips runs quickly and uses little
memory](https://github.com/libvips/libvips/wiki/Speed-and-memory-use).
libvips is licensed under the [LGPL
2.1+](https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html).

## Install on linux and macOS

Install the libvips binary with your package manager (eg. `apt install
libvips42` or perhaps `brew install vips`, see the [libvips install
instructions](https://libvips.github.io/libvips/install.html)) then install
this gem with:

```
gem install ruby-vips
```

Or include `gem "ruby-vips"` in your gemfile.

## Install on Windows

The gemspec will pull in the msys libvips for you, so all you need is:

```
gem install ruby-vips
```

Or include `gem "ruby-vips"` in your gemfile.

Tested with the ruby and msys from choco, but others may work.

## Example

```ruby
require "vips"

im = Vips::Image.new_from_file filename

# put im at position (100, 100) in a 3000 x 3000 pixel image, 
# make the other pixels in the image by mirroring im up / down / 
# left / right, see
# https://libvips.github.io/libvips/API/current/libvips-conversion.html#vips-embed
im = im.embed 100, 100, 3000, 3000, extend: :mirror

# multiply the green (middle) band by 2, leave the other two alone
im *= [1, 2, 1]

# make an image from an array constant, convolve with it
mask = Vips::Image.new_from_array [
    [-1, -1, -1],
    [-1, 16, -1],
    [-1, -1, -1]], 8
im = im.conv mask, precision: :integer

# finally, write the result back to a file on disk
im.write_to_file output_filename
```

## Documentation

There are [full API docs for ruby-vips on
rubydoc](https://www.rubydoc.info/gems/ruby-vips). This sometimes has issues
updating, so we have a [copy on the gh-pages for this site as
well](http://libvips.github.io/ruby-vips), which
should always work.

See the `Vips` section in the docs for a [tutorial introduction with
examples](https://www.rubydoc.info/gems/ruby-vips/Vips).

The [libvips reference manual](https://libvips.github.io/libvips/API/current/)
has a complete explanation of every method.

The [`example/`](https://github.com/libvips/ruby-vips/tree/master/example)
directory has some simple example programs.

## Benchmarks

The benchmark at [vips-benchmarks](https://github.com/jcupitt/vips-benchmarks)
loads a large image, crops, shrinks, sharpens and saves again, and repeats
10 times.

```text
real time in seconds, fastest of five runs
benchmark       tiff    jpeg
ruby-vips.rb	0.85	0.78	
image-magick	2.03	2.44	
rmagick.rb	3.87	3.89	

peak memory use in kb
benchmark	peak RES
ruby-vips.rb	43864
rmagick.rb	788768
```

See also [benchmarks at the official libvips
website](https://github.com/libvips/libvips/wiki/Speed-and-memory-use).
