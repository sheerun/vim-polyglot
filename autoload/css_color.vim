" Language:     Colorful CSS Color Preview
" Author:       Aristotle Pagaltzis <pagaltzis@gmx.de>
" Last Change:  2014-01-14
" Licence:      No Warranties. WTFPL. But please tell me!
" Version:      1.0

if v:version < 700
	echoerr printf('Vim 7 is required for css-color (this is only %d.%d)',v:version/100,v:version%100)
	finish
endif

if !( has('gui_running') || &t_Co==256 ) | finish | endif

function! s:rgb2color(r,g,b)
	" Convert 80% -> 204, 100% -> 255, etc.
	let rgb = map( [a:r,a:g,a:b], 'v:val =~ "%$" ? ( 255 * v:val ) / 100 : v:val' )
	return printf( '%02x%02x%02x', rgb[0], rgb[1], rgb[2] )
endfunction

function! s:hsl2color(h,s,l)
	" Convert 80% -> 0.8, 100% -> 1.0, etc.
	let [s,l] = map( [a:s, a:l], 'v:val =~ "%$" ? v:val / 100.0 : v:val + 0.0' )
	" algorithm transcoded to vim from http://www.w3.org/TR/css3-color/#hsl-color
	let hh = ( a:h % 360 ) / 360.0
	let m2 = l <= 0.5 ? l * ( s + 1 ) : l + s - l * s
	let m1 = l * 2 - m2
	let rgb = []
	for h in [ hh + (1/3.0), hh, hh - (1/3.0) ]
		let h = h < 0 ? h + 1 : h > 1 ? h - 1 : h
		let v =
			\ h * 6 < 1 ? m1 + ( m2 - m1 ) * h * 6 :
			\ h * 2 < 1 ? m2 :
			\ h * 3 < 2 ? m1 + ( m2 - m1 ) * ( 2/3.0 - h ) * 6 :
			\ m1
		if v > 1.0 | return '' | endif
		let rgb += [ float2nr( 255 * v ) ]
	endfor
	return printf( '%02x%02x%02x', rgb[0], rgb[1], rgb[2] )
endfunction

let s:hex={}
for i in range(0, 255)
	let s:hex[ printf( '%02x', i ) ] = i
endfor

if has('gui_running')
	let s:is_gui = 1
else
	let s:is_gui = 0

	" preset 16 vt100 colors
	let s:xtermcolor = [
		\ [ 0x00, 0x00, 0x00,  0 ],
		\ [ 0xCD, 0x00, 0x00,  1 ],
		\ [ 0x00, 0xCD, 0x00,  2 ],
		\ [ 0xCD, 0xCD, 0x00,  3 ],
		\ [ 0x00, 0x00, 0xEE,  4 ],
		\ [ 0xCD, 0x00, 0xCD,  5 ],
		\ [ 0x00, 0xCD, 0xCD,  6 ],
		\ [ 0xE5, 0xE5, 0xE5,  7 ],
		\ [ 0x7F, 0x7F, 0x7F,  8 ],
		\ [ 0xFF, 0x00, 0x00,  9 ],
		\ [ 0x00, 0xFF, 0x00, 10 ],
		\ [ 0xFF, 0xFF, 0x00, 11 ],
		\ [ 0x5C, 0x5C, 0xFF, 12 ],
		\ [ 0xFF, 0x00, 0xFF, 13 ],
		\ [ 0x00, 0xFF, 0xFF, 14 ],
		\ [ 0xFF, 0xFF, 0xFF, 15 ]]
	" grayscale ramp
	" (value is 8+10*lum for lum in 0..23)
	let s:xtermcolor += [
		\ [ 0x08, 0x08, 0x08, 232 ],
		\ [ 0x12, 0x12, 0x12, 233 ],
		\ [ 0x1C, 0x1C, 0x1C, 234 ],
		\ [ 0x26, 0x26, 0x26, 235 ],
		\ [ 0x30, 0x30, 0x30, 236 ],
		\ [ 0x3A, 0x3A, 0x3A, 237 ],
		\ [ 0x44, 0x44, 0x44, 238 ],
		\ [ 0x4E, 0x4E, 0x4E, 239 ],
		\ [ 0x58, 0x58, 0x58, 240 ],
		\ [ 0x62, 0x62, 0x62, 241 ],
		\ [ 0x6C, 0x6C, 0x6C, 242 ],
		\ [ 0x76, 0x76, 0x76, 243 ],
		\ [ 0x80, 0x80, 0x80, 244 ],
		\ [ 0x8A, 0x8A, 0x8A, 245 ],
		\ [ 0x94, 0x94, 0x94, 246 ],
		\ [ 0x9E, 0x9E, 0x9E, 247 ],
		\ [ 0xA8, 0xA8, 0xA8, 248 ],
		\ [ 0xB2, 0xB2, 0xB2, 249 ],
		\ [ 0xBC, 0xBC, 0xBC, 250 ],
		\ [ 0xC6, 0xC6, 0xC6, 251 ],
		\ [ 0xD0, 0xD0, 0xD0, 252 ],
		\ [ 0xDA, 0xDA, 0xDA, 253 ],
		\ [ 0xE4, 0xE4, 0xE4, 254 ],
		\ [ 0xEE, 0xEE, 0xEE, 255 ]]

	" the 6 values used in the xterm color cube
	"                    0    95   135   175   215   255
	let s:cubergb = [ 0x00, 0x5F, 0x87, 0xAF, 0xD7, 0xFF ]

	" 0..255 mapped to 0..5 based on the color cube values
	let s:xvquant = repeat([0],48)
				\ + repeat([1],68)
				\ + repeat([2],40)
				\ + repeat([3],40)
				\ + repeat([4],40)
				\ + repeat([5],20)
	" tweak the mapping for the exact matches (0 and 1 already correct)
	let s:xvquant[s:cubergb[2]] = 2
	let s:xvquant[s:cubergb[3]] = 3
	let s:xvquant[s:cubergb[4]] = 4
	let s:xvquant[s:cubergb[5]] = 5

	" selects the nearest xterm color for a rgb value like #FF0000
	function! s:rgb2xterm(color)
		let best_match=0
		let smallest_distance = 10000000000
		let color = tolower(a:color)
		let r = s:hex[color[0:1]]
		let g = s:hex[color[2:3]]
		let b = s:hex[color[4:5]]

		let vr = s:xvquant[r]
		let vg = s:xvquant[g]
		let vb = s:xvquant[b]
		let cidx = vr * 36 + vg * 6 + vb + 16
		let ccol = [ s:cubergb[vr], s:cubergb[vg], s:cubergb[vb], cidx ]

		for [tr,tg,tb,idx] in [ ccol ] + s:xtermcolor
			let dr = tr - r
			let dg = tg - g
			let db = tb - b
			let distance = dr*dr + dg*dg + db*db
			if distance == 0 | return idx | endif
			if distance > smallest_distance | continue | endif
			let smallest_distance = distance
			let best_match = idx
		endfor
		return best_match
	endfunction
endif

let s:pattern_color = {}
let s:color_fg      = {}
let s:color_bg      = {}
let [s:hi_cmd, s:black, s:white] = s:is_gui
	\ ? ['hi %s  guibg=#%s   guifg=%s', '#000000', '#ffffff']
	\ : ['hi %s ctermbg=%s ctermfg=%s', 0, 15]
function! s:create_syn_match()

	let pattern = submatch(0)

	if has_key( b:has_pattern_syn, pattern ) | return | endif
	let b:has_pattern_syn[pattern] = 1

	let rgb_color = get( s:pattern_color, pattern, '' )

	if ! strlen( rgb_color )
		let hexcolor = submatch(1)
		let funcname = submatch(2)

		if funcname == 'rgb'
			let rgb_color = s:rgb2color(submatch(3),submatch(4),submatch(5))
		elseif funcname == 'hsl'
			let rgb_color = s:hsl2color(submatch(3),submatch(4),submatch(5))
		elseif strlen(hexcolor) == 6
			let rgb_color = tolower(hexcolor)
		elseif strlen(hexcolor) == 3
			let rgb_color = substitute(tolower(hexcolor), '\(.\)', '\1\1', 'g')
		else
			throw 'css_color: create_syn_match invoked on bad match data'
		endif

		let s:pattern_color[pattern] = rgb_color
	endif

	if ! has_key( b:has_color_hi, rgb_color )
		" check GUI flag early here to avoid pure-overhead caching
		let syn_bg = s:is_gui ? rgb_color : get( s:color_bg, rgb_color, '' )
		if ! strlen(syn_bg)
			let syn_bg = s:rgb2xterm(rgb_color)
			let s:color_bg[rgb_color] = syn_bg
		endif

		let syn_fg = get( s:color_fg, rgb_color, '' )
		if ! strlen(syn_fg)
			let r = s:hex[rgb_color[0:1]]
			let g = s:hex[rgb_color[2:3]]
			let b = s:hex[rgb_color[4:5]]
			let syn_fg = r*30 + g*59 + b*11 > 12000 ? s:black : s:white
			let s:color_fg[rgb_color] = syn_fg
		endif
	endif

	let group = 'BG' . rgb_color

	if ! has_key( b:has_color_hi, rgb_color )
		exe printf( s:hi_cmd, group, syn_bg, syn_fg )
		let b:has_color_hi[rgb_color] = 1
	endif

	" iff pattern ends on word character, require word break to match
	if pattern =~ '\>$' | let pattern .= '\>' | endif
	exe 'syn match' group '/'.escape(pattern, '/').'/ contained containedin=@colorableGroup'

	return ''
endfunction

function! s:update_matches()
	call filter(b:color_match_id, 'matchdelete(v:val)')
	if &l:cursorline
		" adds matches based that duplicate the highlighted colors on the current line
		let lnr = line('.')
		let group = ''
		let groupstart = 0
		let endcol = col('$')
		for col in range( 1, endcol )
			let nextgroup = col < endcol ? synIDattr( synID( lnr, col, 1 ), 'name' ) : ''
			if group == nextgroup | continue | endif
			if group =~ '^BG\x\{6}$'
				let regex = '\%'.lnr.'l\%'.groupstart.'c'.repeat( '.', col - groupstart )
				let match = matchadd( group, regex, -1 )
				let b:color_match_id += [ match ]
			endif
			let group = nextgroup
			let groupstart = col
		endfor
	endif
endfunction

let s:_hexcolor   = '#\(\x\{3}\|\x\{6}\)\>' " submatch 1
let s:_funcname   = '\(rgb\|hsl\)a\?' " submatch 2
let s:_numval     = '\(\d\{1,3}%\?\)' " submatch 3,4,5
let s:_ws_        = '\s*'
let s:_listsep    = s:_ws_ . ',' . s:_ws_
let s:_otherargs_ = '\%(,[^)]*\)\?'
let s:_funcexpr   = s:_funcname . '[(]' . s:_numval . s:_listsep . s:_numval . s:_listsep . s:_numval . s:_ws_ . s:_otherargs_ . '[)]'
let s:_csscolor   = s:_hexcolor . '\|' . s:_funcexpr
" N.B. these substitute() calls are here just for the side effect
"      of invoking s:create_syn_match during substitution -- because
"      match() and friends do not allow finding all matches in a single
"      scan without examining the start of the string over and over
function! s:parse_css_screen()
	call substitute( join( getline('w0','w$'), "\n" ), s:_csscolor, '\=s:create_syn_match()', 'g' )
	call s:update_matches()
endfunction
function! s:parse_any_screen()
	call substitute( join( getline('w0','w$'), "\n" ), s:_hexcolor, '\=s:create_syn_match()', 'g' )
	call s:update_matches()
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! css_color#init(type, groups)
	exe 'syn cluster colorableGroup contains=' . a:groups

	let b:has_color_hi    = {}
	let b:has_pattern_syn = {}
	let b:color_match_id  = []

	augroup CSSColor
		autocmd! * <buffer>
		exe 'autocmd CursorMoved,CursorMovedI <buffer> call s:parse_'.a:type.'_screen()'
	augroup END

	do CSSColor CursorMoved <buffer>

	if a:type != 'css' | return | endif

	hi BG000000 guibg=#000000 guifg=#FFFFFF ctermbg=16  ctermfg=231
	hi BG000080 guibg=#000080 guifg=#FFFFFF ctermbg=235 ctermfg=231
	hi BG00008b guibg=#00008B guifg=#FFFFFF ctermbg=4   ctermfg=231
	hi BG0000cd guibg=#0000CD guifg=#FFFFFF ctermbg=4   ctermfg=231
	hi BG0000ff guibg=#0000FF guifg=#FFFFFF ctermbg=4   ctermfg=231
	hi BG006400 guibg=#006400 guifg=#FFFFFF ctermbg=235 ctermfg=231
	hi BG008000 guibg=#008000 guifg=#FFFFFF ctermbg=2   ctermfg=231
	hi BG008080 guibg=#008080 guifg=#FFFFFF ctermbg=30  ctermfg=231
	hi BG008b8b guibg=#008B8B guifg=#FFFFFF ctermbg=30  ctermfg=231
	hi BG00bfff guibg=#00BFFF guifg=#000000 ctermbg=6   ctermfg=16
	hi BG00ced1 guibg=#00CED1 guifg=#000000 ctermbg=6   ctermfg=16
	hi BG00fa9a guibg=#00FA9A guifg=#000000 ctermbg=6   ctermfg=16
	hi BG00ff00 guibg=#00FF00 guifg=#000000 ctermbg=10  ctermfg=16
	hi BG00ff7f guibg=#00FF7F guifg=#000000 ctermbg=6   ctermfg=16
	hi BG00ffff guibg=#00FFFF guifg=#000000 ctermbg=51  ctermfg=16
	hi BG191970 guibg=#191970 guifg=#FFFFFF ctermbg=237 ctermfg=231
	hi BG1e90ff guibg=#1E90FF guifg=#000000 ctermbg=12  ctermfg=16
	hi BG20b2aa guibg=#20B2AA guifg=#000000 ctermbg=37  ctermfg=16
	hi BG228b22 guibg=#228B22 guifg=#FFFFFF ctermbg=2   ctermfg=231
	hi BG2e8b57 guibg=#2E8B57 guifg=#FFFFFF ctermbg=240 ctermfg=231
	hi BG2f4f4f guibg=#2F4F4F guifg=#FFFFFF ctermbg=238 ctermfg=231
	hi BG32cd32 guibg=#32CD32 guifg=#000000 ctermbg=2   ctermfg=16
	hi BG3cb371 guibg=#3CB371 guifg=#000000 ctermbg=71  ctermfg=16
	hi BG40e0d0 guibg=#40E0D0 guifg=#000000 ctermbg=80  ctermfg=16
	hi BG4169e1 guibg=#4169E1 guifg=#FFFFFF ctermbg=12  ctermfg=231
	hi BG4682b4 guibg=#4682B4 guifg=#FFFFFF ctermbg=67  ctermfg=231
	hi BG483d8b guibg=#483D8B guifg=#FFFFFF ctermbg=240 ctermfg=231
	hi BG48d1cc guibg=#48D1CC guifg=#000000 ctermbg=80  ctermfg=16
	hi BG4b0082 guibg=#4B0082 guifg=#FFFFFF ctermbg=238 ctermfg=231
	hi BG556b2f guibg=#556B2F guifg=#FFFFFF ctermbg=239 ctermfg=231
	hi BG5f9ea0 guibg=#5F9EA0 guifg=#000000 ctermbg=73  ctermfg=16
	hi BG6495ed guibg=#6495ED guifg=#000000 ctermbg=12  ctermfg=16
	hi BG66cdaa guibg=#66CDAA guifg=#000000 ctermbg=79  ctermfg=16
	hi BG696969 guibg=#696969 guifg=#FFFFFF ctermbg=242 ctermfg=231
	hi BG6a5acd guibg=#6A5ACD guifg=#FFFFFF ctermbg=12  ctermfg=231
	hi BG6b8e23 guibg=#6B8E23 guifg=#FFFFFF ctermbg=241 ctermfg=231
	hi BG708090 guibg=#708090 guifg=#000000 ctermbg=66  ctermfg=16
	hi BG778899 guibg=#778899 guifg=#000000 ctermbg=102 ctermfg=16
	hi BG7b68ee guibg=#7B68EE guifg=#000000 ctermbg=12  ctermfg=16
	hi BG7cfc00 guibg=#7CFC00 guifg=#000000 ctermbg=3   ctermfg=16
	hi BG7fff00 guibg=#7FFF00 guifg=#000000 ctermbg=3   ctermfg=16
	hi BG7fffd4 guibg=#7FFFD4 guifg=#000000 ctermbg=122 ctermfg=16
	hi BG800000 guibg=#800000 guifg=#FFFFFF ctermbg=88  ctermfg=231
	hi BG800080 guibg=#800080 guifg=#FFFFFF ctermbg=240 ctermfg=231
	hi BG808000 guibg=#808000 guifg=#FFFFFF ctermbg=240 ctermfg=231
	hi BG808080 guibg=#808080 guifg=#000000 ctermbg=244 ctermfg=16
	hi BG87ceeb guibg=#87CEEB guifg=#000000 ctermbg=117 ctermfg=16
	hi BG87cefa guibg=#87CEFA guifg=#000000 ctermbg=117 ctermfg=16
	hi BG8a2be2 guibg=#8A2BE2 guifg=#FFFFFF ctermbg=12  ctermfg=231
	hi BG8b0000 guibg=#8B0000 guifg=#FFFFFF ctermbg=88  ctermfg=231
	hi BG8b008b guibg=#8B008B guifg=#FFFFFF ctermbg=5   ctermfg=231
	hi BG8b4513 guibg=#8B4513 guifg=#FFFFFF ctermbg=94  ctermfg=231
	hi BG8fbc8f guibg=#8FBC8F guifg=#000000 ctermbg=108 ctermfg=16
	hi BG90ee90 guibg=#90EE90 guifg=#000000 ctermbg=249 ctermfg=16
	hi BG9370d8 guibg=#9370D8 guifg=#000000 ctermbg=12  ctermfg=16
	hi BG9400d3 guibg=#9400D3 guifg=#FFFFFF ctermbg=5   ctermfg=231
	hi BG98fb98 guibg=#98FB98 guifg=#000000 ctermbg=250 ctermfg=16
	hi BG9932cc guibg=#9932CC guifg=#FFFFFF ctermbg=5   ctermfg=231
	hi BG9acd32 guibg=#9ACD32 guifg=#000000 ctermbg=3   ctermfg=16
	hi BGa0522d guibg=#A0522D guifg=#FFFFFF ctermbg=130 ctermfg=231
	hi BGa52a2a guibg=#A52A2A guifg=#FFFFFF ctermbg=124 ctermfg=231
	hi BGa9a9a9 guibg=#A9A9A9 guifg=#000000 ctermbg=248 ctermfg=16
	hi BGadd8e6 guibg=#ADD8E6 guifg=#000000 ctermbg=152 ctermfg=16
	hi BGadff2f guibg=#ADFF2F guifg=#000000 ctermbg=3   ctermfg=16
	hi BGafeeee guibg=#AFEEEE guifg=#000000 ctermbg=159 ctermfg=16
	hi BGb0c4de guibg=#B0C4DE guifg=#000000 ctermbg=152 ctermfg=16
	hi BGb0e0e6 guibg=#B0E0E6 guifg=#000000 ctermbg=152 ctermfg=16
	hi BGb22222 guibg=#B22222 guifg=#FFFFFF ctermbg=124 ctermfg=231
	hi BGb8860b guibg=#B8860B guifg=#000000 ctermbg=3   ctermfg=16
	hi BGba55d3 guibg=#BA55D3 guifg=#000000 ctermbg=5   ctermfg=16
	hi BGbc8f8f guibg=#BC8F8F guifg=#000000 ctermbg=138 ctermfg=16
	hi BGbdb76b guibg=#BDB76B guifg=#000000 ctermbg=247 ctermfg=16
	hi BGc0c0c0 guibg=#C0C0C0 guifg=#000000 ctermbg=250 ctermfg=16
	hi BGc71585 guibg=#C71585 guifg=#FFFFFF ctermbg=5   ctermfg=231
	hi BGcd5c5c guibg=#CD5C5C guifg=#000000 ctermbg=167 ctermfg=16
	hi BGcd853f guibg=#CD853F guifg=#000000 ctermbg=173 ctermfg=16
	hi BGd2691e guibg=#D2691E guifg=#000000 ctermbg=166 ctermfg=16
	hi BGd2b48c guibg=#D2B48C guifg=#000000 ctermbg=180 ctermfg=16
	hi BGd3d3d3 guibg=#D3D3D3 guifg=#000000 ctermbg=252 ctermfg=16
	hi BGd87093 guibg=#D87093 guifg=#000000 ctermbg=168 ctermfg=16
	hi BGd8bfd8 guibg=#D8BFD8 guifg=#000000 ctermbg=252 ctermfg=16
	hi BGda70d6 guibg=#DA70D6 guifg=#000000 ctermbg=249 ctermfg=16
	hi BGdaa520 guibg=#DAA520 guifg=#000000 ctermbg=3   ctermfg=16
	hi BGdc143c guibg=#DC143C guifg=#FFFFFF ctermbg=161 ctermfg=231
	hi BGdcdcdc guibg=#DCDCDC guifg=#000000 ctermbg=253 ctermfg=16
	hi BGdda0dd guibg=#DDA0DD guifg=#000000 ctermbg=182 ctermfg=16
	hi BGdeb887 guibg=#DEB887 guifg=#000000 ctermbg=180 ctermfg=16
	hi BGe0ffff guibg=#E0FFFF guifg=#000000 ctermbg=195 ctermfg=16
	hi BGe6e6fa guibg=#E6E6FA guifg=#000000 ctermbg=255 ctermfg=16
	hi BGe9967a guibg=#E9967A guifg=#000000 ctermbg=174 ctermfg=16
	hi BGee82ee guibg=#EE82EE guifg=#000000 ctermbg=251 ctermfg=16
	hi BGeee8aa guibg=#EEE8AA guifg=#000000 ctermbg=223 ctermfg=16
	hi BGf08080 guibg=#F08080 guifg=#000000 ctermbg=210 ctermfg=16
	hi BGf0e68c guibg=#F0E68C guifg=#000000 ctermbg=222 ctermfg=16
	hi BGf0f8ff guibg=#F0F8FF guifg=#000000 ctermbg=15  ctermfg=16
	hi BGf0fff0 guibg=#F0FFF0 guifg=#000000 ctermbg=255 ctermfg=16
	hi BGf0ffff guibg=#F0FFFF guifg=#000000 ctermbg=15  ctermfg=16
	hi BGf4a460 guibg=#F4A460 guifg=#000000 ctermbg=215 ctermfg=16
	hi BGf5deb3 guibg=#F5DEB3 guifg=#000000 ctermbg=223 ctermfg=16
	hi BGf5f5dc guibg=#F5F5DC guifg=#000000 ctermbg=255 ctermfg=16
	hi BGf5f5f5 guibg=#F5F5F5 guifg=#000000 ctermbg=255 ctermfg=16
	hi BGf5fffa guibg=#F5FFFA guifg=#000000 ctermbg=15  ctermfg=16
	hi BGf8f8ff guibg=#F8F8FF guifg=#000000 ctermbg=15  ctermfg=16
	hi BGfa8072 guibg=#FA8072 guifg=#000000 ctermbg=209 ctermfg=16
	hi BGfaebd7 guibg=#FAEBD7 guifg=#000000 ctermbg=7   ctermfg=16
	hi BGfaf0e6 guibg=#FAF0E6 guifg=#000000 ctermbg=255 ctermfg=16
	hi BGfafad2 guibg=#FAFAD2 guifg=#000000 ctermbg=255 ctermfg=16
	hi BGfdf5e6 guibg=#FDF5E6 guifg=#000000 ctermbg=255 ctermfg=16
	hi BGff0000 guibg=#FF0000 guifg=#FFFFFF ctermbg=196 ctermfg=231
	hi BGff00ff guibg=#FF00FF guifg=#FFFFFF ctermbg=13  ctermfg=231
	hi BGff1493 guibg=#FF1493 guifg=#FFFFFF ctermbg=5   ctermfg=231
	hi BGff4500 guibg=#FF4500 guifg=#FFFFFF ctermbg=9   ctermfg=231
	hi BGff6347 guibg=#FF6347 guifg=#000000 ctermbg=203 ctermfg=16
	hi BGff69b4 guibg=#FF69B4 guifg=#000000 ctermbg=205 ctermfg=16
	hi BGff7f50 guibg=#FF7F50 guifg=#000000 ctermbg=209 ctermfg=16
	hi BGff8c00 guibg=#FF8C00 guifg=#000000 ctermbg=3   ctermfg=16
	hi BGffa07a guibg=#FFA07A guifg=#000000 ctermbg=216 ctermfg=16
	hi BGffa500 guibg=#FFA500 guifg=#000000 ctermbg=3   ctermfg=16
	hi BGffb6c1 guibg=#FFB6C1 guifg=#000000 ctermbg=217 ctermfg=16
	hi BGffc0cb guibg=#FFC0CB guifg=#000000 ctermbg=218 ctermfg=16
	hi BGffd700 guibg=#FFD700 guifg=#000000 ctermbg=11  ctermfg=16
	hi BGffdab9 guibg=#FFDAB9 guifg=#000000 ctermbg=223 ctermfg=16
	hi BGffdead guibg=#FFDEAD guifg=#000000 ctermbg=223 ctermfg=16
	hi BGffe4b5 guibg=#FFE4B5 guifg=#000000 ctermbg=223 ctermfg=16
	hi BGffe4c4 guibg=#FFE4C4 guifg=#000000 ctermbg=224 ctermfg=16
	hi BGffe4e1 guibg=#FFE4E1 guifg=#000000 ctermbg=224 ctermfg=16
	hi BGffebcd guibg=#FFEBCD guifg=#000000 ctermbg=7   ctermfg=16
	hi BGffefd5 guibg=#FFEFD5 guifg=#000000 ctermbg=255 ctermfg=16
	hi BGfff0f5 guibg=#FFF0F5 guifg=#000000 ctermbg=15  ctermfg=16
	hi BGfff5ee guibg=#FFF5EE guifg=#000000 ctermbg=255 ctermfg=16
	hi BGfff8dc guibg=#FFF8DC guifg=#000000 ctermbg=255 ctermfg=16
	hi BGfffacd guibg=#FFFACD guifg=#000000 ctermbg=255 ctermfg=16
	hi BGfffaf0 guibg=#FFFAF0 guifg=#000000 ctermbg=15  ctermfg=16
	hi BGfffafa guibg=#FFFAFA guifg=#000000 ctermbg=15  ctermfg=16
	hi BGffff00 guibg=#FFFF00 guifg=#000000 ctermbg=11  ctermfg=16
	hi BGffffe0 guibg=#FFFFE0 guifg=#000000 ctermbg=255 ctermfg=16
	hi BGfffff0 guibg=#FFFFF0 guifg=#000000 ctermbg=15  ctermfg=16
	hi BGffffff guibg=#FFFFFF guifg=#000000 ctermbg=231 ctermfg=16

	" W3C Colors
	syn keyword BG000000 black   contained containedin=@colorableGroup
	syn keyword BGc0c0c0 silver  contained containedin=@colorableGroup
	syn keyword BG808080 gray    contained containedin=@colorableGroup
	syn match BGffffff "\<white\(-\)\@!\>" contained containedin=@colorableGroup
	syn keyword BG800000 maroon  contained containedin=@colorableGroup
	syn keyword BGff0000 red     contained containedin=@colorableGroup
	syn keyword BG800080 purple  contained containedin=@colorableGroup
	syn keyword BGff00ff fuchsia contained containedin=@colorableGroup
	syn keyword BG008000 green   contained containedin=@colorableGroup
	syn keyword BG00ff00 lime    contained containedin=@colorableGroup
	syn keyword BG808000 olive   contained containedin=@colorableGroup
	syn keyword BGffff00 yellow  contained containedin=@colorableGroup
	syn keyword BG000080 navy    contained containedin=@colorableGroup
	syn keyword BG0000ff blue    contained containedin=@colorableGroup
	syn keyword BG008080 teal    contained containedin=@colorableGroup
	syn keyword BG00ffff aqua    contained containedin=@colorableGroup

	" extra colors
	syn keyword BGf0f8ff AliceBlue            contained containedin=@colorableGroup
	syn keyword BGfaebd7 AntiqueWhite         contained containedin=@colorableGroup
	syn keyword BG7fffd4 Aquamarine           contained containedin=@colorableGroup
	syn keyword BGf0ffff Azure                contained containedin=@colorableGroup
	syn keyword BGf5f5dc Beige                contained containedin=@colorableGroup
	syn keyword BGffe4c4 Bisque               contained containedin=@colorableGroup
	syn keyword BGffebcd BlanchedAlmond       contained containedin=@colorableGroup
	syn keyword BG8a2be2 BlueViolet           contained containedin=@colorableGroup
	syn keyword BGa52a2a Brown                contained containedin=@colorableGroup
	syn keyword BGdeb887 BurlyWood            contained containedin=@colorableGroup
	syn keyword BG5f9ea0 CadetBlue            contained containedin=@colorableGroup
	syn keyword BG7fff00 Chartreuse           contained containedin=@colorableGroup
	syn keyword BGd2691e Chocolate            contained containedin=@colorableGroup
	syn keyword BGff7f50 Coral                contained containedin=@colorableGroup
	syn keyword BG6495ed CornflowerBlue       contained containedin=@colorableGroup
	syn keyword BGfff8dc Cornsilk             contained containedin=@colorableGroup
	syn keyword BGdc143c Crimson              contained containedin=@colorableGroup
	syn keyword BG00ffff Cyan                 contained containedin=@colorableGroup
	syn keyword BG00008b DarkBlue             contained containedin=@colorableGroup
	syn keyword BG008b8b DarkCyan             contained containedin=@colorableGroup
	syn keyword BGb8860b DarkGoldenRod        contained containedin=@colorableGroup
	syn keyword BGa9a9a9 DarkGray             contained containedin=@colorableGroup
	syn keyword BG006400 DarkGreen            contained containedin=@colorableGroup
	syn keyword BGa9a9a9 DarkGrey             contained containedin=@colorableGroup
	syn keyword BGbdb76b DarkKhaki            contained containedin=@colorableGroup
	syn keyword BG8b008b DarkMagenta          contained containedin=@colorableGroup
	syn keyword BG556b2f DarkOliveGreen       contained containedin=@colorableGroup
	syn keyword BG9932cc DarkOrchid           contained containedin=@colorableGroup
	syn keyword BG8b0000 DarkRed              contained containedin=@colorableGroup
	syn keyword BGe9967a DarkSalmon           contained containedin=@colorableGroup
	syn keyword BG8fbc8f DarkSeaGreen         contained containedin=@colorableGroup
	syn keyword BG483d8b DarkSlateBlue        contained containedin=@colorableGroup
	syn keyword BG2f4f4f DarkSlateGray        contained containedin=@colorableGroup
	syn keyword BG2f4f4f DarkSlateGrey        contained containedin=@colorableGroup
	syn keyword BG00ced1 DarkTurquoise        contained containedin=@colorableGroup
	syn keyword BG9400d3 DarkViolet           contained containedin=@colorableGroup
	syn keyword BGff8c00 Darkorange           contained containedin=@colorableGroup
	syn keyword BGff1493 DeepPink             contained containedin=@colorableGroup
	syn keyword BG00bfff DeepSkyBlue          contained containedin=@colorableGroup
	syn keyword BG696969 DimGray              contained containedin=@colorableGroup
	syn keyword BG696969 DimGrey              contained containedin=@colorableGroup
	syn keyword BG1e90ff DodgerBlue           contained containedin=@colorableGroup
	syn keyword BGb22222 FireBrick            contained containedin=@colorableGroup
	syn keyword BGfffaf0 FloralWhite          contained containedin=@colorableGroup
	syn keyword BG228b22 ForestGreen          contained containedin=@colorableGroup
	syn keyword BGdcdcdc Gainsboro            contained containedin=@colorableGroup
	syn keyword BGf8f8ff GhostWhite           contained containedin=@colorableGroup
	syn keyword BGffd700 Gold                 contained containedin=@colorableGroup
	syn keyword BGdaa520 GoldenRod            contained containedin=@colorableGroup
	syn keyword BGadff2f GreenYellow          contained containedin=@colorableGroup
	syn keyword BG808080 Grey                 contained containedin=@colorableGroup
	syn keyword BGf0fff0 HoneyDew             contained containedin=@colorableGroup
	syn keyword BGff69b4 HotPink              contained containedin=@colorableGroup
	syn keyword BGcd5c5c IndianRed            contained containedin=@colorableGroup
	syn keyword BG4b0082 Indigo               contained containedin=@colorableGroup
	syn keyword BGfffff0 Ivory                contained containedin=@colorableGroup
	syn keyword BGf0e68c Khaki                contained containedin=@colorableGroup
	syn keyword BGe6e6fa Lavender             contained containedin=@colorableGroup
	syn keyword BGfff0f5 LavenderBlush        contained containedin=@colorableGroup
	syn keyword BG7cfc00 LawnGreen            contained containedin=@colorableGroup
	syn keyword BGfffacd LemonChiffon         contained containedin=@colorableGroup
	syn keyword BGadd8e6 LightBlue            contained containedin=@colorableGroup
	syn keyword BGf08080 LightCoral           contained containedin=@colorableGroup
	syn keyword BGe0ffff LightCyan            contained containedin=@colorableGroup
	syn keyword BGfafad2 LightGoldenRodYellow contained containedin=@colorableGroup
	syn keyword BGd3d3d3 LightGray            contained containedin=@colorableGroup
	syn keyword BG90ee90 LightGreen           contained containedin=@colorableGroup
	syn keyword BGd3d3d3 LightGrey            contained containedin=@colorableGroup
	syn keyword BGffb6c1 LightPink            contained containedin=@colorableGroup
	syn keyword BGffa07a LightSalmon          contained containedin=@colorableGroup
	syn keyword BG20b2aa LightSeaGreen        contained containedin=@colorableGroup
	syn keyword BG87cefa LightSkyBlue         contained containedin=@colorableGroup
	syn keyword BG778899 LightSlateGray       contained containedin=@colorableGroup
	syn keyword BG778899 LightSlateGrey       contained containedin=@colorableGroup
	syn keyword BGb0c4de LightSteelBlue       contained containedin=@colorableGroup
	syn keyword BGffffe0 LightYellow          contained containedin=@colorableGroup
	syn keyword BG32cd32 LimeGreen            contained containedin=@colorableGroup
	syn keyword BGfaf0e6 Linen                contained containedin=@colorableGroup
	syn keyword BGff00ff Magenta              contained containedin=@colorableGroup
	syn keyword BG66cdaa MediumAquaMarine     contained containedin=@colorableGroup
	syn keyword BG0000cd MediumBlue           contained containedin=@colorableGroup
	syn keyword BGba55d3 MediumOrchid         contained containedin=@colorableGroup
	syn keyword BG9370d8 MediumPurple         contained containedin=@colorableGroup
	syn keyword BG3cb371 MediumSeaGreen       contained containedin=@colorableGroup
	syn keyword BG7b68ee MediumSlateBlue      contained containedin=@colorableGroup
	syn keyword BG00fa9a MediumSpringGreen    contained containedin=@colorableGroup
	syn keyword BG48d1cc MediumTurquoise      contained containedin=@colorableGroup
	syn keyword BGc71585 MediumVioletRed      contained containedin=@colorableGroup
	syn keyword BG191970 MidnightBlue         contained containedin=@colorableGroup
	syn keyword BGf5fffa MintCream            contained containedin=@colorableGroup
	syn keyword BGffe4e1 MistyRose            contained containedin=@colorableGroup
	syn keyword BGffe4b5 Moccasin             contained containedin=@colorableGroup
	syn keyword BGffdead NavajoWhite          contained containedin=@colorableGroup
	syn keyword BGfdf5e6 OldLace              contained containedin=@colorableGroup
	syn keyword BG6b8e23 OliveDrab            contained containedin=@colorableGroup
	syn keyword BGffa500 Orange               contained containedin=@colorableGroup
	syn keyword BGff4500 OrangeRed            contained containedin=@colorableGroup
	syn keyword BGda70d6 Orchid               contained containedin=@colorableGroup
	syn keyword BGeee8aa PaleGoldenRod        contained containedin=@colorableGroup
	syn keyword BG98fb98 PaleGreen            contained containedin=@colorableGroup
	syn keyword BGafeeee PaleTurquoise        contained containedin=@colorableGroup
	syn keyword BGd87093 PaleVioletRed        contained containedin=@colorableGroup
	syn keyword BGffefd5 PapayaWhip           contained containedin=@colorableGroup
	syn keyword BGffdab9 PeachPuff            contained containedin=@colorableGroup
	syn keyword BGcd853f Peru                 contained containedin=@colorableGroup
	syn keyword BGffc0cb Pink                 contained containedin=@colorableGroup
	syn keyword BGdda0dd Plum                 contained containedin=@colorableGroup
	syn keyword BGb0e0e6 PowderBlue           contained containedin=@colorableGroup
	syn keyword BGbc8f8f RosyBrown            contained containedin=@colorableGroup
	syn keyword BG4169e1 RoyalBlue            contained containedin=@colorableGroup
	syn keyword BG8b4513 SaddleBrown          contained containedin=@colorableGroup
	syn keyword BGfa8072 Salmon               contained containedin=@colorableGroup
	syn keyword BGf4a460 SandyBrown           contained containedin=@colorableGroup
	syn keyword BG2e8b57 SeaGreen             contained containedin=@colorableGroup
	syn keyword BGfff5ee SeaShell             contained containedin=@colorableGroup
	syn keyword BGa0522d Sienna               contained containedin=@colorableGroup
	syn keyword BG87ceeb SkyBlue              contained containedin=@colorableGroup
	syn keyword BG6a5acd SlateBlue            contained containedin=@colorableGroup
	syn keyword BG708090 SlateGray            contained containedin=@colorableGroup
	syn keyword BG708090 SlateGrey            contained containedin=@colorableGroup
	syn keyword BGfffafa Snow                 contained containedin=@colorableGroup
	syn keyword BG00ff7f SpringGreen          contained containedin=@colorableGroup
	syn keyword BG4682b4 SteelBlue            contained containedin=@colorableGroup
	syn keyword BGd2b48c Tan                  contained containedin=@colorableGroup
	syn keyword BGd8bfd8 Thistle              contained containedin=@colorableGroup
	syn keyword BGff6347 Tomato               contained containedin=@colorableGroup
	syn keyword BG40e0d0 Turquoise            contained containedin=@colorableGroup
	syn keyword BGee82ee Violet               contained containedin=@colorableGroup
	syn keyword BGf5deb3 Wheat                contained containedin=@colorableGroup
	syn keyword BGf5f5f5 WhiteSmoke           contained containedin=@colorableGroup
	syn keyword BG9acd32 YellowGreen          contained containedin=@colorableGroup
endfunction
