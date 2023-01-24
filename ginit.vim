cd

let g:neovide_window_floating_blur=0
let g:neovide_input_macos_alt_is_meta=v:true
let g:neovide_refresh_rate=120
let g:neovide_transparency=1.0
let g:neovide_no_idle=v:false
let g:neovide_fullscreen=v:false
let g:neovide_remember_window_size=v:true
let g:neovide_input_use_logo=v:false

if exists('g:fvim_loaded')
	FVimCursorSmoothMove v:true
	FVimCursorSmoothBlink v:true

	FVimCustomTitleBar v:true

	FVimFontAntialias v:true
	FVimFontAutohint v:true
	FVimFontHintLevel 'full'
	FVimFontLigature v:true
	FVimFontLineHeight '+1.0'
	FVimFontSubpixel v:true
	FVimFontNoBuiltinSymbols v:true

	FVimUIPopupMenu v:true
	FVimUIWildMenu v:true

	FVimKeyDisableShiftSpace v:true
	FVimKeyAutoIme v:true
	FVimKeyAltGr v:false
endif
