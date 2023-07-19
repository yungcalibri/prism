/-  *prism
|_  [%0 =paths =brats =snoop]
::
++  page
  |=  kid=marl
  ^-  manx
  %-  document
  %-  frame
    kid
::
++  document
  |=  kid=manx
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
    ;+  kid
    ::
    ==
  ==
::
++  frame
  |=  kid=marl
  ^-  manx
  ;sidebar-l(space "var(--s2)", sideWidth "15ch")
    :: sidebar left side
    ;stack-l(splitAfter "3")
      ;center-l(intrinsic "")
        ;h1: Prism ◈ 
        ;span
          ;small: By calibri
        ==
      ==
      ;hr;
      ;nav(hx-target "#content", hx-select "#content")
        ;stack-l(space "var(--s0)")
          ;button(hx-get "/apps/prism"): About Prism
          ;button(hx-get "/apps/prism/paths"): Manage shortlinks
          ;button(hx-get "/apps/prism/snoop"): Statistics
        ==
      ==
      ;footer
        ;a/"https://github.com/yungcalibri/prism": Github
      ==
    ==
    ::  sidebar right side
    ;center-l#content
    ::
    ;*  kid
    ::
    ;iframe
      =src  "/apps/webterm"
      =scrolling  "no"
      =width  "600"
      =height  "530";
    ==
  ==
::
++  home
  |.
  ^-  manx
  %-  page
  ;*  ;=
  ::  begin content
  ;p
    ; This is Prism, a small app for getting people where they need to go.
    ; This UI, such as it is, will be updated regularly until it
    ; satisfies me.
  ==
  ;p
    ; Prism has two major functions: first, it redirects people from a
    ; shortlink on your ship—for example,
    ;code:"/apps/prism/fragment"
    ; —to a longer URL you specify.
  ==
  ;p
    ; Second, when someone follows one of these redirects, Prism will
    ; make a note of the details of the request they made. Specifically,
    ; Prism will examine an inbound request for its
    ;code:"'Referer'"
    ; header, and any
    ;code:"utm_*"
    ; query parameters attached to the request.
  ==
  ;p
    ; By tailoring your shortlink URLs, and examining the app state with
    ;code:":prism +dbug"
    ; , you can see how many visitors came from a specific shared link.
    ; This data is tracked in aggregate: you might see that twenty
    ; visitors followed a shortlink with
    ;code:"utm_source=twitter"
    ; , and ten more with
    ;code:"utm_source=medium"
    ; . It is not tracked individually, which is to say that individual
    ; redirects are not stored with all of their associated data. Think
    ; of it like a people counter.
  ==
  ;img@"https://s3.us-west-004.backblazeb2.com/demiurge/normul-postem/2023.7.18..04.42.00-d735aaec09f5d1c0079f22e577591157.png"(width "100%");
  ;hr;
  ;p
    ; As mentioned, this UI will be updated regularly, but if you have
    ; suggestions or comments, I encourage you to visit the Github repo
    ; (link in the upper left corner) and submit an issue.
  ==
  ;p
    ; For the moment, you can interact with Prism from the terminal or
    ; webterm.
  ==
  ;p
    ; All commands are invoked with the mark
    ;code: prism-action
    ; , like:
  ==
  ;p
    ;code:":prism &prism-action [...]"
  ==
  ;p
    ; The following commands are available:
    ;ul
      ;li
        ;code:"%direct"
        ;span:" to create a new redirect."
        ;br;
        ;code:"[%direct ~.fragment 'https://urbit.org']"
        ;br;
        ;span:"This will be accessible at /apps/prism/fragment."
      ==
      ;li
        ;code:"%defect"
        ;span:" to disable an existing redirect."
        ;br;
        ;code:"[%defect ~.fragment]"
      ==
      ;li
        ;code:"%renege"
        ;span:" to re-enable a previously disabled redirect."
        ;br;
        ;code:"[%renege ~.fragment]"
      ==
      ;li
        ;code:"%delete"
        ;span:" to permanently delete a redirect and all tracking data associated with it."
        ;br;
        ;code:"[%delete ~.fragment]"
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
  }
  code {
    font-family: 'Cousine', monospace;
    padding-inline: 0.25ch;
    margin-inline: 0.25ch;
    padding-block: 0.25ch;
    margin-block: calc(-1 * 0.25ch);
    border-radius: 0.25ch;
    background-color: #335;
  }
  hr {
    width: 100%;
  }
  a:link {
    color: #fff;
  }
  a:visited {
    color: #ccc;
  }
  '''
--
