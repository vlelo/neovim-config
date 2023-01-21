# neovim-config
My neovim dotfiles

### Why is everything under `lua/vleo/`?
To avoid name clashes with `require`. The global function `Vreq` is just an alias to `require("vleo." .. "...")`.

### But why `vleo`?
That's my unix username. If you want to change it you just need to alter the global `Vconf` in `init.lua`. If you also want to change the names of `Vreq` and `Vconf` (where the `V`, again, comes from my username) you'll have to edit the whole config. One good way to go about this would be:
```sh
nvim ./**/*(.)
```
```vim
:argdo %s/Vreq/whatever/g
```
