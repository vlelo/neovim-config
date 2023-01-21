cd
"set guifont=JetBrainsMono\ Nerd\ Font,monospace:h16
"JetBrainsMono Nerd Font Mono
let g:neovide_window_floating_blur=0

" fix for macos alt- keymaps
let g:neovide_input_macos_alt_is_meta=v:true

"""""""""""""""""""""""""""""""""""
"                          Functionality                           "
"""""""""""""""""""""""""""""""""""
" the refresh rate of the app
let g:neovide_refresh_rate=120
" background transparency
let g:neovide_transparency=1.0
" if v:true, will force neovide to redraw always the window
let g:neovide_no_idle=v:false
" fullscreen windowed
let g:neovide_fullscreen=v:false
" use window sized from last session
let g:neovide_remember_window_size=v:true

"""""""""""""""""""""""""""""""""""
"                          Input Settings                          "
"""""""""""""""""""""""""""""""""""
" if v:true will allow neovim to handle super key inputs (super, windows, command)
let g:neovide_input_use_logo=v:false
" how much the finger has to moove for the touch to register as scroll input
" let g:neovide_touch_deadzone=6.0
" how much time the cursor has to stay in the dead zone for the input to register as
" scroll
" let g:neovide_touch_drag_timeout=0.17

"""""""""""""""""""""""""""""""""""
"                         Cursor Settings                          "
"""""""""""""""""""""""""""""""""""
" seconds it take for the cursor to complete the animation
" let g:neovide_cursor_animation_length=0.13
" how much the trail of the cursor lags behind
" let g:neovide_cursor_trail_length=0.8
" cursor antialiasing
" let g:neovide_cursor_antialiasing=v:true
" the size of the outline of the cursor to render when window is unfocuesd
" let g:neovide_cursor_unfocused_outline_width=0.125

"""""""""""""""""""""""""""""""""""
"                         Cursor Particles                         "
"""""""""""""""""""""""""""""""""""
" set the particles left behind by cursor
" possible values={
"   "railgun",
"   "torpedo",
"   "pixiedust",
"   "sonicboom",
"   "ripple",
"   "wireframe",
" }
" let g:neovide_cursor_vfx_mode="torpedo"

"""""""""""""""""""""""""""""""""""
"                        Particle Settings                         "
"""""""""""""""""""""""""""""""""""
" transparency of particles left behind
" let g:neovide_cursor_vfx_opacity=200.0
" amount of particles that should survive
" let g:neovide_cursor_vfx_particle_lifetime=1.2
" number of generated particles
" let g:neovide_cursor_vfx_particle_density=7.0
" speed of particle movement
" let g:neovide_cursor_vfx_particle_speed=10.0
" not even the developer knows
" let g:neovide_cursor_vfx_particle_phase=1.5

" if exists("g:neovide")
" 	augroup NeovideFont
" 		autocmd!
" 		autocmd FileType alpha set guifont=JetBrainsMono\ Nerd\ Font,monospace:h14
" 	augroup END
" endif


" System gvimrc file for Mac OS X
" Author:	Benji Fisher <benji@member.AMS.org>
" Last Change: Thu Mar 09 09:00 AM 2006 EST
"
" Define Mac-standard keyboard shortcuts.

" We don't change 'cpoptions' here, because it would not be set properly when
" a .vimrc file is found later.  Thus don't use line continuation and use
" <special> in mappings.

nnoremap <special> <D-n> :confirm enew<CR>
vmap <special> <D-n> <Esc><D-n>gv
imap <special> <D-n> <C-O><D-n>
cmap <special> <D-n> <C-C><D-n>
omap <special> <D-n> <Esc><D-n>

nnoremap <special> <D-o> :browse confirm e<CR>
vmap <special> <D-o> <Esc><D-o>gv
imap <special> <D-o> <C-O><D-o>
cmap <special> <D-o> <C-C><D-o>
omap <special> <D-o> <Esc><D-o>

nnoremap <silent> <special> <D-w> :if winheight(2) < 0 <Bar> confirm enew <Bar> else <Bar> confirm close <Bar> endif<CR>
vmap <special> <D-w> <Esc><D-w>gv
imap <special> <D-w> <C-O><D-w>
cmap <special> <D-w> <C-C><D-w>
omap <special> <D-w> <Esc><D-w>

nnoremap <silent> <special> <D-s> :if expand("%") == ""<Bar>browse confirm w<Bar> else<Bar>confirm w<Bar>endif<CR>
vmap <special> <D-s> <Esc><D-s>gv
imap <special> <D-s> <C-O><D-s>
cmap <special> <D-s> <C-C><D-s>
omap <special> <D-s> <Esc><D-s>

nnoremap <special> <D-S-s> :browse confirm saveas<CR>
vmap <special> <D-S-s> <Esc><D-s>gv
imap <special> <D-S-s> <C-O><D-s>
cmap <special> <D-S-s> <C-C><D-s>
omap <special> <D-S-s> <Esc><D-s>

" From the Edit menu of SimpleText:
nnoremap <special> <D-z> u
vmap <special> <D-z> <Esc><D-z>gv
imap <special> <D-z> <C-O><D-z>
cmap <special> <D-z> <C-C><D-z>
omap <special> <D-z> <Esc><D-z>

vnoremap <special> <D-x> "+x

vnoremap <special> <D-c> "+y

cnoremap <special> <D-c> <C-Y>

nnoremap <special> <D-v> "+gP
cnoremap <special> <D-v> <C-R>+
execute 'vnoremap <script> <special> <D-v>' paste#paste_cmd['v']
execute 'inoremap <script> <special> <D-v>' paste#paste_cmd['i']

nnoremap <silent> <special> <D-a> :if &slm != ""<Bar>exe ":norm gggH<C-O>G"<Bar> else<Bar>exe ":norm ggVG"<Bar>endif<CR>
vmap <special> <D-a> <Esc><D-a>
imap <special> <D-a> <Esc><D-a>
cmap <special> <D-a> <C-C><D-a>
omap <special> <D-a> <Esc><D-a>

nnoremap <special> <D-f> /
vmap <special> <D-f> <Esc><D-f>
imap <special> <D-f> <Esc><D-f>
cmap <special> <D-f> <C-C><D-f>
omap <special> <D-f> <Esc><D-f>

nnoremap <special> <D-g> n
vmap <special> <D-g> <Esc><D-g>
imap <special> <D-g> <C-O><D-g>
cmap <special> <D-g> <C-C><D-g>
omap <special> <D-g> <Esc><D-g>

source $XDG_CONFIG_HOME/nvim/ginit.lua
