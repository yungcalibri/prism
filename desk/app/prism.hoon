/-  *prism
/+  default-agent, dbug, *prism, view=prism-view, server, schooner, verb
|%
+$  card  card:agent:gall
+$  versioned-state
  $%  state-0
  ==
+$  state-0
  $:  %0
      =paths  :: redirects, fragment to full URL
      =brats  :: set of all disabled wrights
      =snoop  :: statistics about redirects
      :: slate=@ta  :: next randomly generated URL fragment
  ==
--
=|  state-0
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
    ?-  -.old
      %0  [~ this(state old)]
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
          [%apps %prism %about ~]
        :_  state
        (send [200 ~ [%manx ~(about view state)]])
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
        snoop  (~(put by snoop) wright.act *breath)
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
      =/  clean-brats
        ?:  (~(has in brats) wright.act)
          (~(del in brats) wright.act)
        brats
      :-  ~
      %=  state
        paths  (~(del by paths) wright.act)
        snoop  (~(del by snoop) wright.act)
        brats  clean-brats
      ==
    ==
  --
::
--