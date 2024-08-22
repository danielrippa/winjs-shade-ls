
  do ->

    { Num } = dependency 'primitive.Type'
    { string-from-code-point, camel-case } = dependency 'native.String'
    { block-chars } = dependency 'console.Block'
    { floor } = dependency 'native.Number'
    { NumRange } = dependency 'primitive.NumRange'

    shade-names = <[ light medium dark ]>

    shade-code = -> 0x2591 + Num it

    shade-chars = { [ (camel-case "#{ name }-shade"), (string-from-code-point shade-code index) ] for name, index in shade-names }

    { empty-block, full-block } = block-chars

    shade-chars <<< no-shade: empty-block, full-shade: full-block

    shades = <[ no light medium dark full ]>

    Percent = -> NumRange 0, 100, it

    shade-from-percent = (percent) ->

      Percent percent

      index = floor percent / 20

      key = camel-case "#{ shades[index] }-shade"

      shade-chars[ key ]

    {
      shade-chars,
      shade-from-percent
    }