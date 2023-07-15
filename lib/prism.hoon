/-  *prism
/+  mip, server
|%
::
++  utm-parameters
  ^~
  ^-  (set @t)
  %-  silt
  :~  'utm_source'
      'utm_medium'
      'utm_campaign'
      'utm_term'
      'utm_content'
  ==
::
::  +gasp: increment a particular value in a breath.
++  gasp
  |=  [=breath gas=(pair @t @t)]
  ::  get the previous count for this k/v pair, or 0 if there
  :: was nothing there before. either way we increment, so
  :: by default we put in a 1.
  =/  count  (~(gut bi breath) p.gas q.gas 0)
  (~(put bi breath) p.gas q.gas +(count))
::
::  +update-breath: given a breath and an inbound-request,
:: produce an updated breath, incrementing the counts for
:: any utm parameters or 'Referer' header in the request.
++  update-breath
  |=  [req=inbound-request:eyre spyr=breath]
  ^-  breath
  ::  parse url to unit, unwrap unit or crash, get query
  :: parameters at wing r of the result
  =/  params  r:(need (de-purl:html url.request.req))
  ::  find utm parameters. +murn is "maybe turn," where the
  :: output of the transform function is a unit, and the
  :: list yielded at the end is composed only of the
  :: results that are not ~.
  =/  hits=(list brite)
    %+  murn
      params
    |=  [key=@t value=@t]
    ^-  (unit brite)
    ?:  (~(has in utm-parameters) key)
      (some [p=key q=value])
    ~
  ::  for each pair in the list of hits, increment the
  :: associated value in breath.
  ::  it would make more sense to do this with +roll, but
  :: that gate bunts its sample (so we'd be starting from an
  :: empty breath every time). it's possible to get around
  :: this by customizing the sample with |:, but I'm trying
  :: to stick to relatively common runes here.
  ::  the next suggested alternative is +spin,
  :: and its product is a tuple of a modified list and an
  :: accumulator.
  =/  out-tup=(pair (list brite) breath)
    %^    spin
        hits
      spyr
    ::  this transformer gate produces a cell of a modified
    :: list item and a modified accumulator. we do nothing
    :: to the list, so the head of the returned cell is
    :: the unchanged input.
    |=  [hit=brite spyr=breath]
    ^-  [brite breath]
    :-  hit
    (gasp spyr hit)
  ::  we're nearly done. the last thing we need to do is
  :: account for the famously misspelled 'Referer' header,
  :: which tells us where the request came from, if present.
  =/  spyr=breath  q.out-tup
  ::  first we're going to find the index of the header
  :: we're looking for.
  =/  ref-index
    %+  find
      ['Referer']~
  ::  we'll do it by dropping the values from the list and
  :: looking for just 'Referer.' (we can't use +find on the
  :: header list directly, because we don't know what the
  :: value part of the k/v pair is.)
    %+  turn
      header-list.request.req
    |=([key=@t value=@t] key)
  ::  if we didn't find the 'Referer' header, we're set.
  ?~  ref-index  spyr
  ::  if we did, then we'll pull the pair at that index
  :: from the original list.
  =/  ref
    (snag `@`(need ref-index) header-list.request.req)
  ::  finally we increment that value and return the result.
  (gasp spyr `brite`ref)
::
:: ++  dejs-action
--
