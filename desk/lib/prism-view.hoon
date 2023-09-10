/-  *prism
|_  [%0 =paths =brats =snoop]
::
++  page
  |=  kid=marl
  ^-  manx
  %-  document
  %-  frame
    kid
::  +document: HTML document with head content including all styles and scripts
++  document
  |=  kid=marl
  ^-  manx
  ;html
    ;head
      ;title: Prism ◈
      ;meta(charset "utf-8");
      ;link
        =rel   "stylesheet"
        =href  "https://unpkg.com/@yungcalibri/layout@0.1.5/dist/bundle.css";
      ;link
        =rel   "stylesheet"
        =href  "https://unpkg.com/@fontsource/castoro@5.0.5/index.css";
      ;link
        =rel   "stylesheet"
        =href  "https://unpkg.com/@fontsource/cousine@5.0.5/index.css";
      ;link
        =rel   "stylesheet"
        =href  "https://unpkg.com/@fontsource/anybody@5.0.5/index.css";
      ;script
        =type  "module"
        =src   "https://unpkg.com/@yungcalibri/layout@0.1.5/umd/bundle.js";
      ;script
        =nomodule  ""
        =src       "https://unpkg.com/@yungcalibri/layout@0.1.5/dist/bundle.js";
      ;script(src "https://unpkg.com/htmx.org@1.9.0");
      ;script(src "https://unpkg.com/htmx.org@1.9.0/dist/ext/json-enc.js");
      ;script(src "https://unpkg.com/htmx.org@1.9.0/dist/ext/include-vals.js");
      ;script:"htmx.logAll();"
      ;style: {style}
    ==
    ;body(hx-ext "json-enc,include-vals")
    ::
    ;*  kid
    ::
    ==
  ==
::  +frame: layout frame with navigation and title placard
++  frame
  |=  kid=marl
  ^-  marl
  ;*  ;=
  ::  begin content
  ;sidebar-l(space "var(--s2)", sideWidth "15ch")
    :: sidebar left side
    ;stack-l(splitAfter "3", class "text-align:right", style "min-height: 50vh")
      ;center-l()
        ;h1: Prism ◈ 
        ;span
          ;small:"By "
          ;a/"https://twitter.com/yung_calibri"
            ;small: calibri
          ==
        ==
      ==
      ;hr;
      ;nav(class "justify-content:end")
        ;stack-l(space "var(--s0)", style "align-items: stretch;")
          ;a/"/apps/prism": Shortlinks
          ;a/"/apps/prism/about": About Prism
        ==
      ==
      ;hr;
      ;footer(class "position:sticky bottom:0")
        ;cluster-l(class "justify-content:end")
          ;a/"https://github.com/yungcalibri/prism": Prism on Github
        ==
      ==
    ==
    ::  sidebar right side
    ;center-l
      ;section#content
      ::
        ;*  kid
        ::
      ==
    ==
  ==
  ;center-l(style "max-inline-size: calc(100vw - var(--s1));")
    ;sidebar-l
      =sideWidth   "20rem"
      =style       "max-inline-size: 100%;"
      ;+  usage
      ;iframe
        =src        "/apps/webterm"
        =style      "min-block-size: 20lh;"
        =scrolling  "no";
    ==
  ==
  ::  end content
  ==
::  +about: details about Prism
++  about
  ^-  manx
  %-  page
  ;*  ;=
  ::  begin content
  ;p
    ; This is Prism, a small app for getting people where they need to go.
  ==
  ;p
    ; The UI, such as it is, will be updated regularly until it
    ; satisfies me. All functionality is accessible via
    ; the terminal or webterm: check the Usage placard below for details.
    ; The more I learn about how people use Prism, the more functionality
    ; will become available in the UI. 
  ==
  ;p
    ; Prism has two major functions: first, it redirects people from a
    ; shortlink on your ship—for example,
    ;code:"/apps/prism/fragment"
    ; —to a longer URL you specify.
  ==
  ;p
    ; Second, when someone follows one of these redirects, Prism will
    ; increment a hit counter and make a note of the details of the request
    ; they made. Specifically, Prism will examine an inbound request for its
    ;code:"'Referer'"
    ; header, and any
    ;code:"utm_*"
    ; query parameters attached to the request.
  ==
  ;p
    ; By tailoring your shortlink URLs, and examining the app state with
    ;code:":prism +dbug"
    ; , you can track the effectiveness of your campaigns.
    ; This data is tracked in aggregate: you might see that twenty
    ; visitors followed a shortlink with
    ;code:"utm_source=twitter"
    ; , and ten others followed one with
    ;code:"utm_source=medium"
    ; . (It is not tracked individually, which is to say that individual
    ; redirects are not stored with all of their associated data. Think
    ; of it like a people counter.)
  ==
  ;img@"https://s3.us-west-004.backblazeb2.com/demiurge/normul-postem/2023.7.18..04.42.00-d735aaec09f5d1c0079f22e577591157.png"(width "100%");
  ;p
    ; As I mentioned above, I have no idea what I should add to the UI next.
    ; So please get in touch to tell me what you want to see here! The best
    ; ways to do that are:
    ;ul
      ;li
        ; to visit
        ;a/"https://github.com/yungcalibri/prism":"the Github repo"
        ::  can't do &nbsp; so this is the next best thing I guess
        ;+  ;/  " and submit an issue, or"
      ==
      ;li
        ; to DM me on Urbit at
        ;code: ~normul-postem
        ; , or
      ==
      ;li
        ; to DM me on
        ;a/"https://twitter.com/yung_calibri":"Twitter"
        ; .
      ==
    ==
    ; Hope you enjoy.
  ==
  ::  end content
  ==
::
++  usage
  ^-  manx
  ;aside#usage
    ;div.noise;
    ;h1: Usage
    ;p
      ; All commands are invoked with generators.
    ==
    ;p
      ; The following commands are available:
    ==
    ;hr;
    ;stack-l(space "var(--s-1)")
      ;div
        ;pre
          ;code
            ;span:":prism|"
            ;em:"direct"
            ;span:" ~.fragment 'https://urbit.org'"
          ==
        ==
        ;div:"to create a redirect from /apps/prism/fragment to https://urbit.org."
      ==
      ;div
        ;pre
          ;code
            ;span:":prism|"
            ;em:"defect"
            ;span:" ~.fragment"
          ==
        ==
        ;div:" to disable an existing redirect."
      ==
      ;div
        ;pre
          ;code
            ;span:":prism|"
            ;em:"renege"
            ;span:" ~.fragment"
          ==
        ==
        ;div:" to re-enable a previously disabled redirect."
      ==
      ;div
        ;pre
          ;code
            ;span:":prism|"
            ;em:"delete"
            ;span:" ~.fragment"
          ==
        ==
        ;div:" to permanently delete a redirect and all tracking data associated with it."
      ==
    ==
  ==
::  +shortlinks: shows tracking statistics about shortlinks, and
::  (eventually) provides controls to manage them.
++  shortlinks
  ^-  manx
  %-  page
  ;*  ;=
  ::  begin content
  ;h2
    ;+  ?:  (gth ~(wyt by paths) 0)
          ;/  "Shortlinks"
        ;/  "No shortlinks created yet"
  ==
  ;stack-l(space "var(--s0)")
    ;*  %+  turn
      ~(tap by paths)
    |=  [wright=@ta toward=@t]
    =/  beth=breath  (~(got by snoop) wright)
    =/  hits  (~(gut bi beth) '' '' 0)
    =/  brat  (~(has in brats) wright)
    =/  delete-link  (spud /apps/prism/[wright]/delete)
    =/  toggle-link
      (spud ~[%apps %prism wright ?.(brat 'defect' 'renege')])
    :: =/  box-class  ?:(brat "shortlink disabled" "shortlink")
    ;section(class "shortlink {(trip ?:(brat 'disabled' ''))}")
      ;sidebar-l(side "right", sideWidth "5em")
        ;stack-l
          ;section
            ;div
              ; From:
              ;code
                ;+  ;/  "/apps/prism/"
                ;em:"{(trip wright)}"
              ==
            ==
            ;div
              ; To:
              ;a
                =target  "_blank"
                =rel     "noopener noreferer"
                =href    "{(trip toward)}"
                ;code: {(trip toward)}
              ==
            ==
          ==
          ;div
            ;+  ;/  ?.(brat "Enabled" "Disabled")
            ;+  ;/  " — {<hits>} "
            ;+  ;/  ?:(=(hits 1) "visitor" "visitors")
          ==
        ==
        ;stack-l(space "var(--s-1)", splitAfter "1")
          ;button.danger
            =hx-post     delete-link
            =hx-confirm  "Are you sure you want to delete this link?"
            =hx-target   "#content"
            =hx-select   "#content"
            ; Delete
          ==
          ;button
            =hx-post    toggle-link
            =hx-target  "#content"
            =hx-select  "#content"
            ;+  ;/  ?.(brat "Disable" "Enable")
          ==
        ==
      ==
    ==
    ;hr;
    ;section(class "shortlink new")
      ;stack-l
        ;h3: New shortlink
        ;form#new-shortlink
          =hx-post    "/apps/prism/direct"
          =hx-target  "#content"
          =hx-select  "#content"
          ;sidebar-l(side "right", sideWidth "5em")
            ;stack-l(space "var(--s-2)")
              ;label
                ; From:
                ;br;
                ;code: /apps/prism/
                ;input
                  =name         "wright"
                  =type         "text"
                  =pattern      "[a-zA-Z-._~]+"
                  =required     ""
                  =placeholder  "vienna"
                  =style        "color: #f95";
              ==
              ;label
                ; To:
                ;br;
                ;input
                  =name         "toward"
                  =type         "url"
                  =required     ""
                  =placeholder  "https://vienna.earth/";
              ==
            ==
            ;stack-l(class "justify-content:end")
              ;button: Create
            ==
          ==
        ==
      ==
    ==
  ==
  ::  end content
  ==
::
++  style
  ^~
  %-  trip
  '''
  :root {
    --measure: 80ch;
  }
  body {
    font-family: 'Castoro', serif;
    background-color: #112;
    color: #fff;
    margin: 0 !important;
    padding: var(--s1);
  }
  body > * + * {
    margin-block-start: var(--s1);
  }
  code {
    font-family: 'Cousine', monospace;
    padding: 0.25ch;
    margin-inline: 0.25ch;
    margin-block: calc(-1 * 0.25ch);
    border-radius: 0.25ch;
    background-color: #335;
  }
  code em {
    font-style: normal;
    color: #f95;
  }
  hr {
    width: 100%;
  }
  button {
    border-style: outset;
    border-width: var(--s-5);
    border-radius: var(--s-4);
    border-color: white;
    background-color: #537;
    padding-inline: 0.5rem;
    padding-block: 0.25rem;
    color: inherit;
    filter: brightness(110%);
    cursor: pointer;
  }
  button.danger {
    background-color: #a32;
  }
  button:hover {
    filter: brightness(110%) contrast(120%);
  }
  button:active {
    border-style: solid;
    filter: brightness(90%) contrast(120%);
  }
  input {
    background-color: #335;
    color: inherit;
    font-size: inherit;
    font-family: 'Cousine', monospace;
    padding: 0.25ch;
    border-color: #4e3d54;
  }
  #usage {
    font-family: 'Anybody', sans-serif;
    font-size: 11pt;
    line-height: 1.2;
    background-color: #177;
    border: var(--s-3) outset white;
    padding: var(--s-1);
    max-inline-size: fit-content;
    margin-inline: auto;
    position: relative;
    text-shadow: 0.5px 1.5px 1px darkslategray;
  }
  #usage code, #usage pre {
    text-shadow: none;
  }
  #usage > .noise {
    pointer-events: none;
    position: absolute;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    background: url(https://s3.us-west-004.backblazeb2.com/demiurge/normul-postem/2023.7.26..02.11.05-noise.svg);
    mix-blend-mode: multiply;
    filter: contrast(240%);
  }
  #usage pre {
    margin-block: 0;
    padding-block: var(--s-1);
    background-color: #335;
  }
  #usage pre + div {
    margin-block: var(--s-2);
  }
  a:link {
    color: #fff;
  }
  a:visited {
    color: #ccc;
  }
  .padding\:1rem {
    padding: 1rem !important;
  }
  .position\:sticky {
    position: sticky !important;
  }
  .bottom\:0 {
    bottom: 0 !important;
  }
  display\:grid {
    display: grid !important;
  }
  .shortlink {
    border-width: var(--s-5);
    border-style: outset;
    border-color: white;
    border-radius: var(--s-3);
    background-color: #224;
    padding: var(--s-1);
  }
  .shortlink.disabled {
    background-color: inherit;
    border-color: darkgray;
  }
  .shortlink.new input[name=toward]{
    inline-size: 35ch;
  }
  .shortlink.new h3 {
    margin-top: 0;
  }
  .shortlink.new form {
    margin-top: 0;
    margin-bottom: 0;
  }
  '''
--
