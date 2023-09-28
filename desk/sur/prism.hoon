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
::  additionally. the value at ['' ''] is a hit counter.
+$  breath  (mip @t @t @ud)
::
::  $paths: maps public shortlink path segment to outbound
:: redirect url.
+$  paths  (map wright @t)
::
::  $steps: maps path segments to the order in which they
:: should be rendered in the UI. odd integers.
+$  steps  (map wright @ud)
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
  ::  %divert: add a new redirect, generating a random path for the link
  ::  %defect: disable an existing wright
  ::  %renege: re-enable a wright
  ::  %delete: delete a wright
  $%  [%direct =wright toward=@t]
      [%divert toward=@t]
      [%defect =wright]
      [%renege =wright]
      [%delete =wright]
  ==
--
