/-  *prism
/+  mip, server
|%
::
++  dejs-direct
  |=  jon=json
  =,  dejs:format
  ^-  prism-action
  :-  %direct
  %.  jon
  (ot ~[wright+so toward+so])
::
++  dejs-divert
  |=  jon=json
  =,  dejs:format
  ^-  prism-action
  :-  %divert
  %.  jon
  (ot ~[toward+so])
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
::  +gasp: increment a series of values in a breath.
++  gasp
  |=  [spyr=breath gas=(list brite)]
  ^-  breath
  |-
  ::  if no more values, done.
  ?~  gas  spyr
  ::  get the previous count for this k/v pair, or 0 if there
  :: was nothing there before. either way we increment, so
  :: by default we put in a 1.
  =/  count  (~(gut bi spyr) p.i.gas q.i.gas 0)
  ::  recurse on the tail of gas with an updated breath.
  %=  $
    gas   t.gas
    spyr  (~(put bi spyr) p.i.gas q.i.gas +(count))
  ==
::  +gasp-hit: increment the value at ['' ''] as a hit counter.
++  gasp-hit
  |=  spyr=breath
  ^-  breath
  (gasp spyr ~[`brite`[p='' q='']])
::
++  gasp-referer
  |=  [req=inbound-request:eyre spyr=breath]
  ^-  breath
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
    (snag `@`u.ref-index header-list.request.req)
  ::  finally we increment that value and return the result.
  (gasp spyr ~[`brite`ref])
::
++  gasp-utms
  |=  [req=inbound-request:eyre spyr=breath]
  ^-  breath
  ::  get all query parameters.
  =/  parsed
    =+  %-  trip  url.request.req
    ~&  -
    %-  de-purl:html
    %-  crip
    "http://urbit.local{-}"
  ~&  parsed+parsed
  ::  if parsing failed, give up.
  ?~  parsed 
    ~|("Parsing the URL failed" !!)
  =/  params  r:(need parsed)
  ::  if there are no query parameters, return the original.
  ?~  params  spyr
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
  ::  if there are no utm parameters, return the original.
  ?~  hits  spyr
  ::  for each pair in the list of hits, increment the
  :: associated value in breath.
  (gasp spyr hits)
::
::  +update-breath: given a breath and an inbound-request,
:: produce an updated breath, incrementing the counts for
:: any utm parameters or 'Referer' header in the request.
++  update-breath
  |=  [req=inbound-request:eyre spyr=breath]
  ^-  breath
  %-  gasp-hit
  %+  gasp-utms
    req
  %+  gasp-referer
    req
  spyr
::
--
