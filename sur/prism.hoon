/+  *mip
|%
::
::  $wright: a path fragment where a redirect is accessible.
+$  wright  @ta
::
::  $breath: counter for header/parameter values of
:: redirected clients.
::  we use this to count how many times we've seen each
:: value of the 'Referer' header and any utm_* query
:: parameters added to a shortlink.
+$  breath  (mip @t @t @ud)
::
::  $paths: maps public shortlink path segment to outbound
:: redirect url.
+$  paths  (map wright @t)
::
::  $brats: set of all disabled wrights.
+$  brats  (set wright)
::
::  $brite: k/v pair for a $breath.
+$  brite  (pair @t @t)
::
::  $snoop: holds all statistics for all wrights.
+$  snoop  (map wright breath)
::
+$  prism-action
  ::  %direct: add a new wright
  ::  %defect: disable an existing wright
  ::  %renege: re-enable a wright
  $%  [%direct =wright toward=@t]
      [%defect =wright]
      [%renege =wright]
  ==
--
