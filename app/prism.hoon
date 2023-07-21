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
        (handle-action !<(prism-action vase))
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
          ~(pub handle-http req)
        ::  authenticated requests are handled by the arm matching
        ::  the request method.
        ?+    method.request.inbound-request.req  dump
            %'GET'
          ~(get handle-http req)
          ::
            %'POST'
          ~(pot handle-http req)
          ::
            %'DELETE'
          ~(del handle-http req)
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
++  handle-http
  |_  [eyre-id=@ta =inbound-request:eyre]
  +*  req   (parse-request-line:server url.request.inbound-request)
      send  (cury response:schooner eyre-id)
      beth  (cury update-breath inbound-request)
      dump  [(send [404 ~ [%none ~]]) state]
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
      (send [200 ~ [%manx ~(home view state)]])
    ::
        [%apps %prism %shortlinks ~]
      :_  state
      (send [200 ~ [%manx ~(shortlinks view state)]])
    ::
        [%apps %prism %stats ~]
      :_  state
      (send [200 ~ [%manx ~(stats view state)]])
    ==
  ::++  old-get
  ::  ^-  (quip card _state)
  ::  ?+    site  dump
  ::      ::  snoop on this link
  ::      [%snoop @t ~]
  ::    ?>  ((sane %ta) ->.site)
  ::    =/  empath  `@ta`->.site
  ::    ?>  (~(has by paths.state) empath)
  ::    ::  build UI with snoop.viz
  ::    :_  state
  ::    (send [200 ~ [%manx (~(snoop viz snoop.state) empath)]])
  ::    ::
  ::      [@t ~]
  ::    ?>  ((sane %ta) -.site)
  ::    =/  empath  `@ta`-.site
  ::    ?>  (~(has by paths.state) empath)
  ::    ::  we're authenticated, so don't bother tracking this one
  ::    [(send [302 ~ [%redirect (~(got by paths.state) empath)]]) state]
  ::    --
  ::  authenticated POST
  ++  pot
    ^-  (quip card _state)
    dump
  ::  authenticated DELETE
  ++  del
    ^-  (quip card _state)
    dump
  --
::
++  handle-action
  |=  act=prism-action
  ^-  (quip card _state)
  ?-    -.act
      %direct
    ::  ensure we got a valid @ta in the action (this will
    ::  be a url segment, so we have to be strict)
    ~|  "Invalid path segment {<wright.act>}"
    ?>  ((sane %ta) wright.act)
    ::  ensure we don't already have a redirect at this path
    ~|  "Path /apps/prism/{<wright.act>} already assigned"
    ?<  (~(has by paths) wright.act)
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
    ~|  "There is no forward from /apps/prism/{<wright.act>}"
    ?>  (~(has by paths) wright.act)
    ~|  "Path /apps/prism/{<wright.act>} is already disabled"
    ?<  (~(has in brats) wright.act)
    [~ state(brats (~(put in brats) wright.act))]
  ::
      %renege
    ~|  "There is no forward from /apps/prism/{<wright.act>}"
    ?>  (~(has by paths) wright.act)
    ~|  "Path /apps/prism/{<wright.act>} is already enabled"
    ?>  (~(has in brats) wright.act)
    [~ state(brats (~(del in brats) wright.act))]
  ::
      %delete
    ~|  "There is no forward from /apps/prism/{<wright.act>}"
    ?>  (~(has by paths) wright.act)
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
