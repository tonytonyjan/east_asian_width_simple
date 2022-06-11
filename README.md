# east_asian_width_simple

east_asian_width_simple is a Ruby gem that calculates the visual width of strings by parsing and looking up East Asian Width Property Data File, aka [EastAsianWidth.txt](https://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt), which is defined in [Unicode Standard Annex #11: East Asian Width](https://www.unicode.org/reports/tr11/).

It aims to be time-performant and easy to use.

## Installation

```
gem install east_asian_width_simple
```

## Prerequisite

Download the latest data file from unicode.org:

```sh
curl https://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt >EastAsianWidth.txt
```

## Usage

```ruby
require 'east_asian_width_simple'
eaw = EastAsianWidthSimple.new(File.open('EastAsianWidth.txt'))
eaw.string_width('台灣 No.1') # => 9

eaw.lookup_width('a'.ord) # => 1
eaw.lookup_width('🐞'.ord) # => 2

eaw.lookup('兜'.ord) # => :W
eaw.lookup('Ａ'.ord) # => :F
```

## Benchmark

east_asian_width_simple is faster than other pure Ruby implementations. Below is the comparison table of time cost:

| Name                    | Width Calculation | Property Lookup |
| ----------------------- | ----------------- | --------------- |
| east_asian_width_simple | 1x                | 1x              |
| east_asian_width        | 8.78x             | 4.57x           |
| reline                  | 10.25x            | -               |
| unicode-display_width   | 4.45x             | -               |
| unicode-eaw             | -                 | 10.60x          |
| visual_width            | 2.03x             | -               |

[east_asian_width]: https://github.com/zhangkaizhao/east_asian_width
[reline]: https://github.com/ruby/reline/blob/master/lib/reline/unicode.rb
[unicode-display_width]: https://github.com/janlelis/unicode-display_width
[unicode]: https://github.com/takahashim/unicode-eaw
[visual_width]: https://github.com/gfx/visual_width.rb

```
λ ruby -Ilib benchmark/compare_string_width.rb
Warming up --------------------------------------
east_asian_width_simple
                        64.173k i/100ms
east_asian_width v0.0.2
                         7.685k i/100ms
       reline v0.3.1     6.482k i/100ms
unicode-display_width v2.1.0
                        14.647k i/100ms
 visual_width v0.0.6    32.497k i/100ms
Calculating -------------------------------------
east_asian_width_simple
                        639.876k (± 3.0%) i/s -      3.209M in   5.019358s
east_asian_width v0.0.2
                         72.856k (± 6.1%) i/s -    368.880k in   5.085280s
       reline v0.3.1     62.413k (± 2.8%) i/s -    317.618k in   5.093141s
unicode-display_width v2.1.0
                        143.900k (± 3.4%) i/s -    732.350k in   5.095958s
 visual_width v0.0.6    315.919k (± 3.3%) i/s -      1.592M in   5.046671s

Comparison:
east_asian_width_simple:   639876.0 i/s
 visual_width v0.0.6:   315918.9 i/s - 2.03x  (± 0.00) slower
unicode-display_width v2.1.0:   143899.9 i/s - 4.45x  (± 0.00) slower
east_asian_width v0.0.2:    72855.6 i/s - 8.78x  (± 0.00) slower
       reline v0.3.1:    62412.8 i/s - 10.25x  (± 0.00) slower
```

```
λ ruby -Ilib benchmark/compare_lookup.rb
Warming up --------------------------------------
east_asian_width_simple
                       983.574k i/100ms
east_asian_width v0.0.2
                       203.189k i/100ms
  unicode-eaw v2.2.0    91.347k i/100ms
Calculating -------------------------------------
east_asian_width_simple
                          9.421M (± 3.0%) i/s -     47.212M in   5.016159s
east_asian_width v0.0.2
                          2.062M (± 3.6%) i/s -     10.363M in   5.032867s
  unicode-eaw v2.2.0    888.856k (± 6.4%) i/s -      4.476M in   5.057569s

Comparison:
east_asian_width_simple:  9420660.8 i/s
east_asian_width v0.0.2:  2061830.5 i/s - 4.57x  (± 0.00) slower
  unicode-eaw v2.2.0:   888855.8 i/s - 10.60x  (± 0.00) slower
```
