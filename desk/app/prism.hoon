/-  *prism
/+  default-agent, dbug, *prism, view=prism-view, server, schooner, verb
|%
+$  card  card:agent:gall
+$  versioned-state
  $%  state-0
      state-1
  ==
+$  state-1
  $:  %1
      =paths
      =steps
      =brats
      =snoop
  ==
+$  state-0
  $:  %0
      =paths  :: redirects, fragment to full URL
      =brats  :: set of all disabled wrights
      =snoop  :: statistics about redirects
      :: slate=@ta  :: next randomly generated URL fragment
  ==
--
=|  state-1
=*  state  -
%-  agent:dbug
%+  verb  |
^-  agent:gall
=<
  |_  =bowl:gall
  +*  this  .
      hc    ~(. ^hc bowl)
      def   ~(. (default-agent this %|) bowl)
  ++  on-init
    ^-  (quip card _this)
    :_  this
    :~  :*  %pass  /eyre/connect  %arvo  %e
            %connect  [~ /apps/prism]  %prism
    ==  ==
  ::
  ++  on-save
    ^-  vase
    !>(state)
  ::
  ++  on-load
    |=  old-state=vase
    ^-  (quip card _this)
    =/  old  !<(versioned-state old-state)
    ?-    -.old
        %1
      [~ this(state old)]
    ::
        %0
      ::  we don't have order info for the old paths, so we have to start by
      ::  just assigning an order arbitrarily. the UI must allow the
      ::  user to reorder.
      =/  spout=(pair (list [wright @ud]) @ud)
        %^  spin  ~(tap in ~(key by paths.old))
          1
        |=([=wright ord=@ud] [[wright ord] (add 2 ord)])
      ::  spin produces a pair of a list and a noun, and we only want
      ::  the former.
      =/  order=^steps  (malt p.spout)
      =/  new=state-1
        :*  %1
            paths.old
            order
            brats.old
            snoop.old
        ==
      [~ this(state new)]
    ==
  ::
  ++  on-poke
    |=  [=mark =vase]
    ^-  (quip card _this)
    ?+    mark  (on-poke:def mark vase)
      ::
        %prism-action
      ?>  =(src.bowl our.bowl)
      =^  cards  state
        (handle-action:hc !<(prism-action vase))
      [cards this]
      ::
        %handle-http-request
      ?>  =(src.bowl our.bowl)
      =/  req  !<([eyre-id=@ta =inbound-request:eyre] vase)
      ::  ehh. is it worth feeding this into handle-http?
      :: or is that pointless?
      =*  dump
        :_  state
        (response:schooner eyre-id.req 404 ~ [%none ~])
      =^  cards  state
        ^-  (quip card _state)
        ::  unauthenticated requests are all handled by the pub arm.
        ?.  authenticated.inbound-request.req
          ~(pub handle-http:hc req)
        ::  authenticated requests are handled by the arm matching
        ::  the request method.
        ?+    method.request.inbound-request.req  dump
            %'GET'
          ~(get handle-http:hc req)
          ::
            %'POST'
          ~(pot handle-http:hc req)
        ==
      [cards this]
    ==
  ::
  ++  on-peek  on-peek:def
  ::
  ++  on-watch
    |=  =path
    ^-  (quip card _this)
    ?+    path  (on-watch:def path)
        [%http-response *]
      [~ this]
    ==
  ::
  ++  on-leave  on-leave:def
  ++  on-agent  on-agent:def
  ++  on-arvo  on-arvo:def
  ++  on-fail  on-fail:def
  --
|%
::
++  hc
  |_  =bowl:gall
  ::
  ++  handle-http
    |_  [eyre-id=@ta =inbound-request:eyre]
    +*  req   (parse-request-line:server url.request.inbound-request)
        body  body.request.inbound-request
        send  (cury response:schooner eyre-id)
        beth  (cury update-breath inbound-request)
        dump  [(send [404 ~ [%none ~]]) state]
        derp  [(send [500 ~ [%stock ~]]) state]
    ::  all public requests
    ++  pub
      ^-  (quip card _state)
      =/  site  site.req
      ?+    site  dump
      ::
          [%apps %prism @t ~]  :: /apps/prism/{path in paths.state}
        ::  it has to be a valid @ta or it won't go in paths.state
        ?.  ((sane %ta) i.t.t.site)  dump
        ::  "M-path", maybe path
        =/  empath  `@ta`i.t.t.site
        ::  dump if it doesn't exist
        ?.  (~(has by paths.state) empath)  dump
        ::  dump if it's disabled
        ?:  (~(has in brats.state) empath)  dump
        ::  get the breath for this wright, pull relevant
        :: parameters, update snoop.state with new breath, and
        :: redirect the request.
        =/  new-snoop
          (~(jab by snoop.state) empath beth)
        :_  state(snoop new-snoop)
        (send [302 ~ [%redirect (~(got by paths.state) empath)]])
      ==
    ::  authenticated GET
    ++  get
      ^-  (quip card _state)
      =/  site  site.req
      ?+    site  pub
      ::
          [%apps %prism ~]
        :_  state
        (send [200 ~ [%manx ~(shortlinks view state)]])
      ::
          [%apps %prism %shortlinks ~]
        :_  state
        (send [303 ~ [%redirect '/apps/prism']])
      ::
          [%apps %prism %direct ~]
        :_  state
        (send [200 ~ [%manx ~(direct view state)]])
      ::
          [%apps %prism %divert ~]
        :_  state
        (send [200 ~ [%manx ~(divert view state)]])
      ::
          [%apps %prism %about ~]
        :_  state
        (send [200 ~ [%manx ~(about view state)]])
      ::
          [%apps %prism %updates ~]
        :_  state
        (send [200 ~ [%manx ~(updates view state)]])
      ==
    ::  authenticated POST
    ++  pot
      ^-  (quip card _state)
      =/  site  site.req
      ?+    site  dump
        ::
          [%apps %prism %direct ~]
        ?~  body.request.inbound-request  derp
        =/  jon=(unit json)
          (de:json:html q.u.body.request.inbound-request)
        ?~  jon  derp
        =/  act=prism-action  (dejs-direct +.jon)
        =/  scat=(unit (quip card _state))
          %-  mole
          |.  (handle-action act)
        ?~  scat  derp
        :_  +.u.scat
        %+  weld
          -.u.scat
        (send [303 ~ [%redirect '/apps/prism']])
        ::
          [%apps %prism %validate %unique ~]
        ::  check whether the shortlink is unique
        ?~  body.request.inbound-request  derp
        =/  jon=(unit json)
          (de:json:html q.u.body.request.inbound-request)
        ?~  jon  derp
        ::  same inputs as the direct action, just use dejs-direct
        =/  act=prism-action  (dejs-direct +.jon)
        ::  satisfy the type checker by insisting that this is a %direct
        ?.  ?=([%direct *] act)  derp
        :_  state
        ?.  (~(has by paths) wright.act)
          (send [200 ~ [%none ~]])
        (send [200 ~ [%plain "{(trip wright.act)} is already bound!"]])
        ::
          [%apps %prism %divert ~]
        ?~  body.request.inbound-request  derp
        =/  jon=(unit json)
          (de:json:html q.u.body.request.inbound-request)
        ?~  jon  derp
        =/  act=prism-action  (dejs-divert +.jon)
        =/  scat=(unit (quip card _state))
          %-  mole
          |.  (handle-action act)
        ?~  scat  derp
        :_  +.u.scat
        %+  weld
          -.u.scat
        (send [303 ~ [%redirect '/apps/prism']])
        ::
          [%apps %prism @t %defect ~]
        ::  attempt to handle the %defect action
        =/  scat=(unit (quip card _state))
          %-  mole
          |.  (handle-action `prism-action`[%defect i.t.t.site])
        ::  if applying the defect action failed, send 500
        ?~  scat  derp
        ::  otherwise add our response card to the list of effects.
        :_  +.u.scat
        %+  weld
          -.u.scat
        (send [303 ~ [%redirect '/apps/prism']])
      ::
          [%apps %prism @t %renege ~]
        =/  scat=(unit (quip card _state))
          %-  mole
          |.  (handle-action `prism-action`[%renege i.t.t.site])
        ?~  scat  derp
        :_  +.u.scat
        %+  weld
          -.u.scat
        (send [303 ~ [%redirect '/apps/prism']])
      ::
          [%apps %prism @t %delete ~]
        =/  scat=(unit (quip card _state))
          %-  mole
          |.  (handle-action `prism-action`[%delete i.t.t.site])
        ?~  scat  derp
        :_  +.u.scat
        %+  weld
          -.u.scat
        (send [303 ~ [%redirect '/apps/prism']])
      ==
    --
  ::
  ++  handle-action
    |=  act=prism-action
    ^-  (quip card _state)
    ::  the last number we added to $steps is the highest number. we
    ::  don't always minimize the keys in steps (when deleting, for
    ::  instance), so it makes sense to derive this on demand rather
    ::  than keeping it in state.
    =/  max-step=@ud
      (~(rep by steps) |=([[* ord=@ud] acc=@ud] (max ord acc)))
    ::  the next step is the next odd integer.
    =/  next-step=@ud  (add 2 max-step)
    ?-    -.act
        %direct
      ::  ensure we got a valid @ta in the action (this will
      ::  be a url segment, so we have to be strict)
      ?.  ((sane %ta) wright.act)
        ~|("Invalid path segment {<wright.act>}" !!)
      ::  ensure we don't already have a redirect at this path
      ?:  (~(has by paths) wright.act)
        ~|("Path /apps/prism/{<wright.act>} already assigned" !!)
      ::  ensure toward is a properly formed URL
      ?~  (de-purl:html toward.act)
        ~|('URL is invalid' !!)
      :-  ~
      ::  add the path, initialize its entry in our snoop.state
      %=  state
        paths  (~(put by paths) wright.act toward.act)
        steps  (~(put by steps) wright.act next-step)
        snoop  (~(put by snoop) wright.act *breath)
      ==
    ::
        %divert
      ::  generate a random path segment for this redirect
      ?~  (de-purl:html toward.act)
        ~|('URL is invalid' !!)
      ::  random number generation starts from 0, so we need to
      ::  find the largest two-segment @p, i.e. `@p`(pow 2 16),
      ::  and then subtract the smallest two-segment patp,
      ::  which is (pow 2 8, then add one less again.
      ::  this gives us a random four-segment patp.
      =/  scope=@ud  (sub (pow 2 16) (pow 2 8))
      =/  shift=@ud  (sub (pow 2 8) 1)
      ::  generate a segment we don't already have
      =/  segment=@ta
        ::  start with some random patp
        =/  pat=@p  `@p`(add (~(rad og eny.bowl) scope) shift)
        |-
        ::  strip the sig from the front of our random patp
        =/  strip=@ta
          ^-  @ta
          %-  crip
          ::  interpolate pat into a string, and take its tail,
          ::  which doesn't include the sig
          =<  +..  "{<pat>}"
        ::  if we already have a path like this, add 1 until we find a
        ::  unique path. there are 64.000 stars, so we will never
        ::  do this, but still, better safe than sorry!
        ?:  (~(has by paths) strip)
          %=  $
            pat  `@p`(add pat 1)
          ==
        strip
      ::
      ~&  "/apps/prism/{(trip `@t`segment)} -> {(trip toward.act)}"
      :-  ~
      %=  state
        paths  (~(put by paths) segment toward.act)
        steps  (~(put by steps) segment next-step)
        snoop  (~(put by snoop) segment *breath)
      ==
    ::
        %defect
      ?.  (~(has by paths) wright.act)
        ~|("There is no forward from /apps/prism/{<wright.act>}" !!)
      ?:  (~(has in brats) wright.act)
        ~|("Path /apps/prism/{<wright.act>} is already disabled" !!)
      [~ state(brats (~(put in brats) wright.act))]
    ::
        %renege
      ?.  (~(has by paths) wright.act)
        ~|("There is no forward from /apps/prism/{<wright.act>}" !!)
      ?.  (~(has in brats) wright.act)
        ~|("Path /apps/prism/{<wright.act>} is already enabled" !!)
      [~ state(brats (~(del in brats) wright.act))]
    ::
        %delete
      ?.  (~(has by paths) wright.act)
        ~|("There is no forward from /apps/prism/{<wright.act>}" !!)
      ?>  (~(has by snoop) wright.act)
      ::  remove the deleted entry from brats, if it was there.
      =/  clean-brats
        ?:  (~(has in brats) wright.act)
          (~(del in brats) wright.act)
        brats
      :-  ~
      %=  state
        paths  (~(del by paths) wright.act)
        steps  (~(del by steps) wright.act)
        snoop  (~(del by snoop) wright.act)
        brats  clean-brats
      ==
    ==
  --
::
--
