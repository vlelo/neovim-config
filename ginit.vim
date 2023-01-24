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
