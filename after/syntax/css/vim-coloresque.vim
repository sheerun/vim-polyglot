" Name:         Coloresque
" Language:     color preview in vim
" Author:       Gorodinskii Konstantin <gor.konstantin@gmail.com>
" Licence:      Vim license
" Version:      0.9.5
" based on
" https://github.com/ap/vim-css-color
" https://github.com/lilydjwg/colorizer
" vim:et:ts=2 sw=2 sts=2

let s:hex={}
let b:matchescache = {}
let b:color_pattern = {}

let w:colorDictRegExp=''
for i in range(0, 255)
  let s:hex[ printf( '%02x', i ) ] = i
endfor

let s:black = '#000000'
let s:white = '#ffffff'

function! s:FGForBG(color)
  " pick suitable text color given a background color
  let color = tolower(a:color)
  let r = s:hex[color[0:1]]
  let g = s:hex[color[2:3]]
  let b = s:hex[color[4:5]]
  return r*30 + g*59 + b*11 > 12000 ? s:black : s:white
endfunction

let s:color_prefix  = 'gui'
let s:fg_color_calc = 'let color = "#" . toupper(a:color)'

function! s:RestoreColors()
    for part in keys(b:color_pattern)

      "if b:color_pattern[part]=="ffffff"
        "echoe part
      "endif
      
      call s:MatchColorValue(b:color_pattern[part], part)
      "echoe color
      "echoe b:color_pattern[color]
      "let group = 'cssColor' . tolower(strpart(b:color_pattern[part]["color"], 1))
      ""exe 'syn match' group '/'.escape(pattern, '/').'/ contained'
      "exe 'syn cluster cssColors add='.group
      "exe 'hi' group s:color_prefix.'bg='.b:color_pattern[part]["bg"] s:color_prefix.'fg='.b:color_pattern[part]["fg"]
      
      "if !exists('b:matchescache')
        "let b:matchescache={}
      "endif

      "let b:matchescache[part] = matchadd(group, part, -1)
    endfor
endfunction

function! s:MatchColorValue(color, part)
  if ! len(a:color) | return | endif

    let group = 'cssColor' . tolower(a:color)

  if !exists('b:color_pattern[a:part]')
    exe s:fg_color_calc
    exe 'syn cluster cssColors add='.group
    exe 'hi' group s:color_prefix.'bg='.color s:color_prefix.'fg='.s:FGForBG(a:color)
    let b:color_pattern[a:part] = a:color
  endif

  if !exists('b:matchescache')
    let b:matchescache = {}
  elseif !exists('b:matchescache[a:part]')
    let b:matchescache[a:part] = matchadd(group, a:part, -1)
  endif

  "call add(w:matchescache, matchadd(group, a:part, -1))

  return ''
endfunction

function! s:HexForRGBValue(r,g,b)
  " Convert 80% -> 204, 100% -> 255, etc.
  let rgb = map( [a:r,a:g,a:b], 'v:val =~ "%$" ? ( 255 * v:val ) / 100 : v:val' )
  return printf( '%02x%02x%02x', rgb[0], rgb[1], rgb[2] )
endfunction

function! s:HexForHSLValue(h,s,l)
  " Convert 80% -> 0.8, 100% -> 1.0, etc.
  let [s,l] = map( [a:s, a:l], 'v:val =~ "%$" ? v:val / 100.0 : str2float(v:val)' )
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

function! s:ClearMatches()
  call clearmatches()
  
  if !exists('b:matchescache')
    return
  endif
  "for i in values(b:matchescache)
    "call matchdelete(i)
  "endfor
  unlet b:matchescache
endfunction

function! s:VimCssInit(update)

    if a:update==1
        call s:ClearMatches()
    endif
    :set isk+=-
    :set isk+=#
    :set isk+=.

    if len(keys(b:color_pattern))>0
        call s:RestoreColors()
        return
    endif

    "let b:matchescache = {}

    call s:AdditionalColors()

    "for i in range(1, line("$"))
        call s:PreviewCSSColor(join(getline(1,'$'), "\n"))
    "endfor

endfunction

function! s:AdditionalColors()
    "if exists('&b:colorDictRegExp')&&b:colorDictRegExp!=''
        "return
    "endif

  " w3c Colors
  " plus extra colors
    let w:colorDict = {
      \'black': '#000000',
      \'red': '#ff0000',
      \'silver': '#c0c0c0',
      \'gray': '#808080',
      \'white': '#ffffff',
      \'maroon': '#800000',
      \'purple': '#800080',
      \'fuchsia': '#ff00ff',
      \'green': '#008000',
      \'lime': '#00ff00',
      \'olive': '#808000',
      \'yellow': '#ffff00',
      \'navy': '#000080',
      \'blue': '#0000ff',
      \'teal': '#008080',
      \'aqua': '#00ffff',
      \'aliceblue': '#f0f8ff',
      \'antiquewhite': '#faebd7',
      \'aquamarine': '#7fffd4',
      \'azure': '#f0ffff',
      \'beige': '#f5f5dc',
      \'bisque': '#ffe4c4',
      \'blanchedalmond': '#ffebcd',
      \'blueviolet': '#8a2be2',
      \'brown': '#a52a2a',
      \'burlywood': '#deb887',
      \'cadetblue': '#5f9ea0',
      \'chartreuse': '#7fff00',
      \'chocolate': '#d2691e',
      \'coral': '#ff7f50',
      \'cornflowerblue': '#6495ed',
      \'cornsilk': '#fff8dc',
      \'crimson': '#dc143c',
      \'cyan': '#00ffff',
      \'darkblue': '#00008b',
      \'darkcyan': '#008b8b',
      \'darkgoldenrod': '#b8860b',
      \'darkgray': '#a9a9a9',
      \'darkgreen': '#006400',
      \'darkgrey': '#a9a9a9',
      \'darkkhaki': '#bdb76b',
      \'darkmagenta': '#8b008b',
      \'darkolivegreen': '#556b2f',
      \'darkorchid': '#9932cc',
      \'darkred': '#8b0000',
      \'darksalmon': '#e9967a',
      \'darkseagreen': '#8fbc8f',
      \'darkslateblue': '#483d8b',
      \'darkslategray': '#2f4f4f',
      \'darkslategrey': '#2f4f4f',
      \'darkturquoise': '#00ced1',
      \'darkviolet': '#9400d3',
      \'darkorange': '#ff8c00',
      \'deeppink': '#ff1493',
      \'deepskyblue': '#00bfff',
      \'dimgray': '#696969',
      \'dimgrey': '#696969',
      \'dodgerblue': '#1e90ff',
      \'firebrick': '#b22222',
      \'floralwhite': '#fffaf0',
      \'forestgreen': '#228b22',
      \'gainsboro': '#dcdcdc',
      \'ghostwhite': '#f8f8ff',
      \'gold': '#ffd700',
      \'goldenrod': '#daa520',
      \'greenyellow': '#adff2f',
      \'grey': '#808080',
      \'honeydew': '#f0fff0',
      \'hotpink': '#ff69b4',
      \'indianred': '#cd5c5c',
      \'indigo': '#4b0082',
      \'ivory': '#fffff0',
      \'khaki': '#f0e68c',
      \'lavender': '#e6e6fa',
      \'lavenderblush': '#fff0f5',
      \'lawngreen': '#7cfc00',
      \'lemonchiffon': '#fffacd',
      \'lightblue': '#add8e6',
      \'lightcoral': '#f08080',
      \'lightcyan': '#e0ffff',
      \'lightgoldenrodyellow': '#fafad2',
      \'lightgray': '#d3d3d3',
      \'lightgreen': '#90ee90',
      \'lightgrey': '#d3d3d3',
      \'lightpink': '#ffb6c1',
      \'lightsalmon': '#ffa07a',
      \'lightseagreen': '#20b2aa',
      \'lightskyblue': '#87cefa',
      \'lightslategray': '#778899',
      \'lightslategrey': '#778899',
      \'lightsteelblue': '#b0c4de',
      \'lightyellow': '#ffffe0',
      \'limegreen': '#32cd32',
      \'linen': '#faf0e6',
      \'magenta': '#ff00ff',
      \'mediumaquamarine': '#66cdaa',
      \'mediumblue': '#0000cd',
      \'mediumorchid': '#ba55d3',
      \'mediumpurple': '#9370d8',
      \'mediumseagreen': '#3cb371',
      \'mediumslateblue': '#7b68ee',
      \'mediumspringgreen': '#00fa9a',
      \'mediumturquoise': '#48d1cc',
      \'mediumvioletred': '#c71585',
      \'midnightblue': '#191970',
      \'mintcream': '#f5fffa',
      \'mistyrose': '#ffe4e1',
      \'moccasin': '#ffe4b5',
      \'navajowhite': '#ffdead',
      \'oldlace': '#fdf5e6',
      \'olivedrab': '#6b8e23',
      \'orange': '#ffa500',
      \'orangered': '#ff4500',
      \'orchid': '#da70d6',
      \'palegoldenrod': '#eee8aa',
      \'palegreen': '#98fb98',
      \'paleturquoise': '#afeeee',
      \'palevioletred': '#d87093',
      \'papayawhip': '#ffefd5',
      \'peachpuff': '#ffdab9',
      \'peru': '#cd853f',
      \'pink': '#ffc0cb',
      \'plum': '#dda0dd',
      \'powderblue': '#b0e0e6',
      \'rosybrown': '#bc8f8f',
      \'royalblue': '#4169e1',
      \'saddlebrown': '#8b4513',
      \'salmon': '#fa8072',
      \'sandybrown': '#f4a460',
      \'seagreen': '#2e8b57',
      \'seashell': '#fff5ee',
      \'sienna': '#a0522d',
      \'skyblue': '#87ceeb',
      \'slateblue': '#6a5acd',
      \'slategray': '#708090',
      \'slategrey': '#708090',
      \'snow': '#fffafa',
      \'springgreen': '#00ff7f',
      \'steelblue': '#4682b4',
      \'tan': '#d2b48c',
      \'thistle': '#d8bfd8',
      \'tomato': '#ff6347',
      \'turquoise': '#40e0d0',
      \'violet': '#ee82ee',
      \'wheat': '#f5deb3',
      \'whitesmoke': '#f5f5f5',
      \'yellowgreen': '#9acd32'
    \}

  "let w:colorDictRegExp = '\(' 
  for _color in keys(w:colorDict)
    "let w:colorDictRegExp.='\<'._color.'\>\|' 
    call s:MatchColorValue(strpart(w:colorDict[tolower(_color)], 1), '\<\c'._color.'\>')
  endfor
  "let w:colorDictRegExp=strpart(w:colorDictRegExp, 0, len(w:colorDictRegExp)-2).'\)\c'
endfunction

function! s:ProcessByLine(w)
  call s:PreviewCSSColor(getline(a:w))
endfunction

function! s:PreviewCSSColor(str)
  "if !exists('&w:colorDictRegExp')
  "endif

  let line=a:str "getline(a:w)
  let colorexps = {
    \ 'hex'  : '#[0-9A-Fa-f]\{3\}\>\|#[0-9A-Fa-f]\{6\}\>',
    \ 'rgba' : 'rgba\?(\s*\(\d\{1,3}%\?\)\s*,\s*\(\d\{1,3}%\?\)\s*,\s*\(\d\{1,3}%\?\)\s*\%(,[^)]*\)\?)',
    \ 'hsla' : 'hsla\?(\s*\(\d\{1,3}%\?\)\s*,\s*\(\d\{1,3}%\?\)\s*,\s*\(\d\{1,3}%\?\)\s*\%(,[^)]*\)\?)'
    \ }
    "\ 'color': w:colorDictRegExp

  "let foundcolor=''

  for exp in keys(colorexps)
      let place=0

      if exists("foundcolor")
          unlet foundcolor
      endif

      while 1
          if exp=='rgba'||exp=='hsla'
              let foundcolor = matchlist(a:str, colorexps[exp], place)
          else
              let foundcolor = matchstr(a:str, colorexps[exp], place)
          endif

          let place = matchend(a:str, colorexps[exp], place)

          if empty(foundcolor)
              break
          endif

          if exp=='hex'
              let part = foundcolor.'\>'
          else
              let part = foundcolor[0]
          endif

          if exp=='hex'
              if len(foundcolor) == 4
                  let foundcolor = substitute(foundcolor, '[[:xdigit:]]', '&&', 'g')
              endif
              call s:MatchColorValue(strpart(foundcolor, 1), part)
          elseif exp=='rgba'
              "TODO get rid of duplicated variables
              call s:MatchColorValue(s:HexForRGBValue(foundcolor[1], foundcolor[2], foundcolor[3]), part)
          elseif exp=='hsla'
              call s:MatchColorValue(s:HexForHSLValue(foundcolor[1], foundcolor[2], foundcolor[3]), part)
          endif
      endwhile
  endfor

endfunction

if has("gui_running") || &t_Co==256
  " HACK modify cssDefinition to add @cssColors to its contains
  redir => cssdef
  silent! syn list cssDefinition
  redir END
  if len( cssdef )
    for out in split( cssdef, "\n" )
      if out !~ '^cssDefinition ' | continue | endif
      let out = substitute( out, ' \+xxx \+', ' ', '' )
      let out = substitute( out, ' contains=\zs', '@cssColors,', '' )
      exe 'syn region' out
    endfor
  endif

  if ! has('gui_running')

    let s:black = 0
    let s:white = 15

    let s:color_prefix  = 'cterm'
    let s:fg_color_calc = 'let color = s:XTermColorForRGB(a:color)'

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
        \         + repeat([1],68)
        \         + repeat([2],40)
        \         + repeat([3],40)
        \         + repeat([4],40)
        \         + repeat([5],20)
    " tweak the mapping for the exact matches (0 and 1 already correct)
    let s:xvquant[s:cubergb[2]] = 2
    let s:xvquant[s:cubergb[3]] = 3
    let s:xvquant[s:cubergb[4]] = 4
    let s:xvquant[s:cubergb[5]] = 5

    " selects the nearest xterm color for a rgb value like #FF0000
    function! s:XTermColorForRGB(color)
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

  hi cssColor000000 guibg=#000000 guifg=#FFFFFF ctermbg=16  ctermfg=231 | syn cluster cssColors add=cssColor000000
  hi cssColor000080 guibg=#000080 guifg=#FFFFFF ctermbg=235 ctermfg=231 | syn cluster cssColors add=cssColor000080
  hi cssColor00008b guibg=#00008B guifg=#FFFFFF ctermbg=4   ctermfg=231 | syn cluster cssColors add=cssColor00008b
  hi cssColor0000cd guibg=#0000CD guifg=#FFFFFF ctermbg=4   ctermfg=231 | syn cluster cssColors add=cssColor0000cd
  hi cssColor0000ff guibg=#0000FF guifg=#FFFFFF ctermbg=4   ctermfg=231 | syn cluster cssColors add=cssColor0000ff
  hi cssColor006400 guibg=#006400 guifg=#FFFFFF ctermbg=235 ctermfg=231 | syn cluster cssColors add=cssColor006400
  hi cssColor008000 guibg=#008000 guifg=#FFFFFF ctermbg=2   ctermfg=231 | syn cluster cssColors add=cssColor008000
  hi cssColor008080 guibg=#008080 guifg=#FFFFFF ctermbg=30  ctermfg=231 | syn cluster cssColors add=cssColor008080
  hi cssColor008b8b guibg=#008B8B guifg=#FFFFFF ctermbg=30  ctermfg=231 | syn cluster cssColors add=cssColor008b8b
  hi cssColor00bfff guibg=#00BFFF guifg=#000000 ctermbg=6   ctermfg=16  | syn cluster cssColors add=cssColor00bfff
  hi cssColor00ced1 guibg=#00CED1 guifg=#000000 ctermbg=6   ctermfg=16  | syn cluster cssColors add=cssColor00ced1
  hi cssColor00fa9a guibg=#00FA9A guifg=#000000 ctermbg=6   ctermfg=16  | syn cluster cssColors add=cssColor00fa9a
  hi cssColor00ff00 guibg=#00FF00 guifg=#000000 ctermbg=10  ctermfg=16  | syn cluster cssColors add=cssColor00ff00
  hi cssColor00ff7f guibg=#00FF7F guifg=#000000 ctermbg=6   ctermfg=16  | syn cluster cssColors add=cssColor00ff7f
  hi cssColor00ffff guibg=#00FFFF guifg=#000000 ctermbg=51  ctermfg=16  | syn cluster cssColors add=cssColor00ffff
  hi cssColor191970 guibg=#191970 guifg=#FFFFFF ctermbg=237 ctermfg=231 | syn cluster cssColors add=cssColor191970
  hi cssColor1e90ff guibg=#1E90FF guifg=#000000 ctermbg=12  ctermfg=16  | syn cluster cssColors add=cssColor1e90ff
  hi cssColor20b2aa guibg=#20B2AA guifg=#000000 ctermbg=37  ctermfg=16  | syn cluster cssColors add=cssColor20b2aa
  hi cssColor228b22 guibg=#228B22 guifg=#FFFFFF ctermbg=2   ctermfg=231 | syn cluster cssColors add=cssColor228b22
  hi cssColor2e8b57 guibg=#2E8B57 guifg=#FFFFFF ctermbg=240 ctermfg=231 | syn cluster cssColors add=cssColor2e8b57
  hi cssColor2f4f4f guibg=#2F4F4F guifg=#FFFFFF ctermbg=238 ctermfg=231 | syn cluster cssColors add=cssColor2f4f4f
  hi cssColor32cd32 guibg=#32CD32 guifg=#000000 ctermbg=2   ctermfg=16  | syn cluster cssColors add=cssColor32cd32
  hi cssColor3cb371 guibg=#3CB371 guifg=#000000 ctermbg=71  ctermfg=16  | syn cluster cssColors add=cssColor3cb371
  hi cssColor40e0d0 guibg=#40E0D0 guifg=#000000 ctermbg=80  ctermfg=16  | syn cluster cssColors add=cssColor40e0d0
  hi cssColor4169e1 guibg=#4169E1 guifg=#FFFFFF ctermbg=12  ctermfg=231 | syn cluster cssColors add=cssColor4169e1
  hi cssColor4682b4 guibg=#4682B4 guifg=#FFFFFF ctermbg=67  ctermfg=231 | syn cluster cssColors add=cssColor4682b4
  hi cssColor483d8b guibg=#483D8B guifg=#FFFFFF ctermbg=240 ctermfg=231 | syn cluster cssColors add=cssColor483d8b
  hi cssColor48d1cc guibg=#48D1CC guifg=#000000 ctermbg=80  ctermfg=16  | syn cluster cssColors add=cssColor48d1cc
  hi cssColor4b0082 guibg=#4B0082 guifg=#FFFFFF ctermbg=238 ctermfg=231 | syn cluster cssColors add=cssColor4b0082
  hi cssColor556b2f guibg=#556B2F guifg=#FFFFFF ctermbg=239 ctermfg=231 | syn cluster cssColors add=cssColor556b2f
  hi cssColor5f9ea0 guibg=#5F9EA0 guifg=#000000 ctermbg=73  ctermfg=16  | syn cluster cssColors add=cssColor5f9ea0
  hi cssColor6495ed guibg=#6495ED guifg=#000000 ctermbg=12  ctermfg=16  | syn cluster cssColors add=cssColor6495ed
  hi cssColor66cdaa guibg=#66CDAA guifg=#000000 ctermbg=79  ctermfg=16  | syn cluster cssColors add=cssColor66cdaa
  hi cssColor696969 guibg=#696969 guifg=#FFFFFF ctermbg=242 ctermfg=231 | syn cluster cssColors add=cssColor696969
  hi cssColor6a5acd guibg=#6A5ACD guifg=#FFFFFF ctermbg=12  ctermfg=231 | syn cluster cssColors add=cssColor6a5acd
  hi cssColor6b8e23 guibg=#6B8E23 guifg=#FFFFFF ctermbg=241 ctermfg=231 | syn cluster cssColors add=cssColor6b8e23
  hi cssColor708090 guibg=#708090 guifg=#000000 ctermbg=66  ctermfg=16  | syn cluster cssColors add=cssColor708090
  hi cssColor778899 guibg=#778899 guifg=#000000 ctermbg=102 ctermfg=16  | syn cluster cssColors add=cssColor778899
  hi cssColor7b68ee guibg=#7B68EE guifg=#000000 ctermbg=12  ctermfg=16  | syn cluster cssColors add=cssColor7b68ee
  hi cssColor7cfc00 guibg=#7CFC00 guifg=#000000 ctermbg=3   ctermfg=16  | syn cluster cssColors add=cssColor7cfc00
  hi cssColor7fff00 guibg=#7FFF00 guifg=#000000 ctermbg=3   ctermfg=16  | syn cluster cssColors add=cssColor7fff00
  hi cssColor7fffd4 guibg=#7FFFD4 guifg=#000000 ctermbg=122 ctermfg=16  | syn cluster cssColors add=cssColor7fffd4
  hi cssColor800000 guibg=#800000 guifg=#FFFFFF ctermbg=88  ctermfg=231 | syn cluster cssColors add=cssColor800000
  hi cssColor800080 guibg=#800080 guifg=#FFFFFF ctermbg=240 ctermfg=231 | syn cluster cssColors add=cssColor800080
  hi cssColor808000 guibg=#808000 guifg=#FFFFFF ctermbg=240 ctermfg=231 | syn cluster cssColors add=cssColor808000
  hi cssColor808080 guibg=#808080 guifg=#000000 ctermbg=244 ctermfg=16  | syn cluster cssColors add=cssColor808080
  hi cssColor87ceeb guibg=#87CEEB guifg=#000000 ctermbg=117 ctermfg=16  | syn cluster cssColors add=cssColor87ceeb
  hi cssColor87cefa guibg=#87CEFA guifg=#000000 ctermbg=117 ctermfg=16  | syn cluster cssColors add=cssColor87cefa
  hi cssColor8a2be2 guibg=#8A2BE2 guifg=#FFFFFF ctermbg=12  ctermfg=231 | syn cluster cssColors add=cssColor8a2be2
  hi cssColor8b0000 guibg=#8B0000 guifg=#FFFFFF ctermbg=88  ctermfg=231 | syn cluster cssColors add=cssColor8b0000
  hi cssColor8b008b guibg=#8B008B guifg=#FFFFFF ctermbg=5   ctermfg=231 | syn cluster cssColors add=cssColor8b008b
  hi cssColor8b4513 guibg=#8B4513 guifg=#FFFFFF ctermbg=94  ctermfg=231 | syn cluster cssColors add=cssColor8b4513
  hi cssColor8fbc8f guibg=#8FBC8F guifg=#000000 ctermbg=108 ctermfg=16  | syn cluster cssColors add=cssColor8fbc8f
  hi cssColor90ee90 guibg=#90EE90 guifg=#000000 ctermbg=249 ctermfg=16  | syn cluster cssColors add=cssColor90ee90
  hi cssColor9370d8 guibg=#9370D8 guifg=#000000 ctermbg=12  ctermfg=16  | syn cluster cssColors add=cssColor9370d8
  hi cssColor9400d3 guibg=#9400D3 guifg=#FFFFFF ctermbg=5   ctermfg=231 | syn cluster cssColors add=cssColor9400d3
  hi cssColor98fb98 guibg=#98FB98 guifg=#000000 ctermbg=250 ctermfg=16  | syn cluster cssColors add=cssColor98fb98
  hi cssColor9932cc guibg=#9932CC guifg=#FFFFFF ctermbg=5   ctermfg=231 | syn cluster cssColors add=cssColor9932cc
  hi cssColor9acd32 guibg=#9ACD32 guifg=#000000 ctermbg=3   ctermfg=16  | syn cluster cssColors add=cssColor9acd32
  hi cssColora0522d guibg=#A0522D guifg=#FFFFFF ctermbg=130 ctermfg=231 | syn cluster cssColors add=cssColora0522d
  hi cssColora52a2a guibg=#A52A2A guifg=#FFFFFF ctermbg=124 ctermfg=231 | syn cluster cssColors add=cssColora52a2a
  hi cssColora9a9a9 guibg=#A9A9A9 guifg=#000000 ctermbg=248 ctermfg=16  | syn cluster cssColors add=cssColora9a9a9
  hi cssColoradd8e6 guibg=#ADD8E6 guifg=#000000 ctermbg=152 ctermfg=16  | syn cluster cssColors add=cssColoradd8e6
  hi cssColoradff2f guibg=#ADFF2F guifg=#000000 ctermbg=3   ctermfg=16  | syn cluster cssColors add=cssColoradff2f
  hi cssColorafeeee guibg=#AFEEEE guifg=#000000 ctermbg=159 ctermfg=16  | syn cluster cssColors add=cssColorafeeee
  hi cssColorb0c4de guibg=#B0C4DE guifg=#000000 ctermbg=152 ctermfg=16  | syn cluster cssColors add=cssColorb0c4de
  hi cssColorb0e0e6 guibg=#B0E0E6 guifg=#000000 ctermbg=152 ctermfg=16  | syn cluster cssColors add=cssColorb0e0e6
  hi cssColorb22222 guibg=#B22222 guifg=#FFFFFF ctermbg=124 ctermfg=231 | syn cluster cssColors add=cssColorb22222
  hi cssColorb8860b guibg=#B8860B guifg=#000000 ctermbg=3   ctermfg=16  | syn cluster cssColors add=cssColorb8860b
  hi cssColorba55d3 guibg=#BA55D3 guifg=#000000 ctermbg=5   ctermfg=16  | syn cluster cssColors add=cssColorba55d3
  hi cssColorbc8f8f guibg=#BC8F8F guifg=#000000 ctermbg=138 ctermfg=16  | syn cluster cssColors add=cssColorbc8f8f
  hi cssColorbdb76b guibg=#BDB76B guifg=#000000 ctermbg=247 ctermfg=16  | syn cluster cssColors add=cssColorbdb76b
  hi cssColorc0c0c0 guibg=#C0C0C0 guifg=#000000 ctermbg=250 ctermfg=16  | syn cluster cssColors add=cssColorc0c0c0
  hi cssColorc71585 guibg=#C71585 guifg=#FFFFFF ctermbg=5   ctermfg=231 | syn cluster cssColors add=cssColorc71585
  hi cssColorcd5c5c guibg=#CD5C5C guifg=#000000 ctermbg=167 ctermfg=16  | syn cluster cssColors add=cssColorcd5c5c
  hi cssColorcd853f guibg=#CD853F guifg=#000000 ctermbg=173 ctermfg=16  | syn cluster cssColors add=cssColorcd853f
  hi cssColord2691e guibg=#D2691E guifg=#000000 ctermbg=166 ctermfg=16  | syn cluster cssColors add=cssColord2691e
  hi cssColord2b48c guibg=#D2B48C guifg=#000000 ctermbg=180 ctermfg=16  | syn cluster cssColors add=cssColord2b48c
  hi cssColord3d3d3 guibg=#D3D3D3 guifg=#000000 ctermbg=252 ctermfg=16  | syn cluster cssColors add=cssColord3d3d3
  hi cssColord87093 guibg=#D87093 guifg=#000000 ctermbg=168 ctermfg=16  | syn cluster cssColors add=cssColord87093
  hi cssColord8bfd8 guibg=#D8BFD8 guifg=#000000 ctermbg=252 ctermfg=16  | syn cluster cssColors add=cssColord8bfd8
  hi cssColorda70d6 guibg=#DA70D6 guifg=#000000 ctermbg=249 ctermfg=16  | syn cluster cssColors add=cssColorda70d6
  hi cssColordaa520 guibg=#DAA520 guifg=#000000 ctermbg=3   ctermfg=16  | syn cluster cssColors add=cssColordaa520
  hi cssColordc143c guibg=#DC143C guifg=#FFFFFF ctermbg=161 ctermfg=231 | syn cluster cssColors add=cssColordc143c
  hi cssColordcdcdc guibg=#DCDCDC guifg=#000000 ctermbg=253 ctermfg=16  | syn cluster cssColors add=cssColordcdcdc
  hi cssColordda0dd guibg=#DDA0DD guifg=#000000 ctermbg=182 ctermfg=16  | syn cluster cssColors add=cssColordda0dd
  hi cssColordeb887 guibg=#DEB887 guifg=#000000 ctermbg=180 ctermfg=16  | syn cluster cssColors add=cssColordeb887
  hi cssColore0ffff guibg=#E0FFFF guifg=#000000 ctermbg=195 ctermfg=16  | syn cluster cssColors add=cssColore0ffff
  hi cssColore6e6fa guibg=#E6E6FA guifg=#000000 ctermbg=255 ctermfg=16  | syn cluster cssColors add=cssColore6e6fa
  hi cssColore9967a guibg=#E9967A guifg=#000000 ctermbg=174 ctermfg=16  | syn cluster cssColors add=cssColore9967a
  hi cssColoree82ee guibg=#EE82EE guifg=#000000 ctermbg=251 ctermfg=16  | syn cluster cssColors add=cssColoree82ee
  hi cssColoreee8aa guibg=#EEE8AA guifg=#000000 ctermbg=223 ctermfg=16  | syn cluster cssColors add=cssColoreee8aa
  hi cssColorf08080 guibg=#F08080 guifg=#000000 ctermbg=210 ctermfg=16  | syn cluster cssColors add=cssColorf08080
  hi cssColorf0e68c guibg=#F0E68C guifg=#000000 ctermbg=222 ctermfg=16  | syn cluster cssColors add=cssColorf0e68c
  hi cssColorf0f8ff guibg=#F0F8FF guifg=#000000 ctermbg=15  ctermfg=16  | syn cluster cssColors add=cssColorf0f8ff
  hi cssColorf0fff0 guibg=#F0FFF0 guifg=#000000 ctermbg=255 ctermfg=16  | syn cluster cssColors add=cssColorf0fff0
  hi cssColorf0ffff guibg=#F0FFFF guifg=#000000 ctermbg=15  ctermfg=16  | syn cluster cssColors add=cssColorf0ffff
  hi cssColorf4a460 guibg=#F4A460 guifg=#000000 ctermbg=215 ctermfg=16  | syn cluster cssColors add=cssColorf4a460
  hi cssColorf5deb3 guibg=#F5DEB3 guifg=#000000 ctermbg=223 ctermfg=16  | syn cluster cssColors add=cssColorf5deb3
  hi cssColorf5f5dc guibg=#F5F5DC guifg=#000000 ctermbg=255 ctermfg=16  | syn cluster cssColors add=cssColorf5f5dc
  hi cssColorf5f5f5 guibg=#F5F5F5 guifg=#000000 ctermbg=255 ctermfg=16  | syn cluster cssColors add=cssColorf5f5f5
  hi cssColorf5fffa guibg=#F5FFFA guifg=#000000 ctermbg=15  ctermfg=16  | syn cluster cssColors add=cssColorf5fffa
  hi cssColorf8f8ff guibg=#F8F8FF guifg=#000000 ctermbg=15  ctermfg=16  | syn cluster cssColors add=cssColorf8f8ff
  hi cssColorfa8072 guibg=#FA8072 guifg=#000000 ctermbg=209 ctermfg=16  | syn cluster cssColors add=cssColorfa8072
  hi cssColorfaebd7 guibg=#FAEBD7 guifg=#000000 ctermbg=7   ctermfg=16  | syn cluster cssColors add=cssColorfaebd7
  hi cssColorfaf0e6 guibg=#FAF0E6 guifg=#000000 ctermbg=255 ctermfg=16  | syn cluster cssColors add=cssColorfaf0e6
  hi cssColorfafad2 guibg=#FAFAD2 guifg=#000000 ctermbg=255 ctermfg=16  | syn cluster cssColors add=cssColorfafad2
  hi cssColorfdf5e6 guibg=#FDF5E6 guifg=#000000 ctermbg=255 ctermfg=16  | syn cluster cssColors add=cssColorfdf5e6
  hi cssColorff0000 guibg=#FF0000 guifg=#FFFFFF ctermbg=196 ctermfg=231 | syn cluster cssColors add=cssColorff0000
  hi cssColorff00ff guibg=#FF00FF guifg=#FFFFFF ctermbg=13  ctermfg=231 | syn cluster cssColors add=cssColorff00ff
  hi cssColorff1493 guibg=#FF1493 guifg=#FFFFFF ctermbg=5   ctermfg=231 | syn cluster cssColors add=cssColorff1493
  hi cssColorff4500 guibg=#FF4500 guifg=#FFFFFF ctermbg=9   ctermfg=231 | syn cluster cssColors add=cssColorff4500
  hi cssColorff6347 guibg=#FF6347 guifg=#000000 ctermbg=203 ctermfg=16  | syn cluster cssColors add=cssColorff6347
  hi cssColorff69b4 guibg=#FF69B4 guifg=#000000 ctermbg=205 ctermfg=16  | syn cluster cssColors add=cssColorff69b4
  hi cssColorff7f50 guibg=#FF7F50 guifg=#000000 ctermbg=209 ctermfg=16  | syn cluster cssColors add=cssColorff7f50
  hi cssColorff8c00 guibg=#FF8C00 guifg=#000000 ctermbg=3   ctermfg=16  | syn cluster cssColors add=cssColorff8c00
  hi cssColorffa07a guibg=#FFA07A guifg=#000000 ctermbg=216 ctermfg=16  | syn cluster cssColors add=cssColorffa07a
  hi cssColorffa500 guibg=#FFA500 guifg=#000000 ctermbg=3   ctermfg=16  | syn cluster cssColors add=cssColorffa500
  hi cssColorffb6c1 guibg=#FFB6C1 guifg=#000000 ctermbg=217 ctermfg=16  | syn cluster cssColors add=cssColorffb6c1
  hi cssColorffc0cb guibg=#FFC0CB guifg=#000000 ctermbg=218 ctermfg=16  | syn cluster cssColors add=cssColorffc0cb
  hi cssColorffd700 guibg=#FFD700 guifg=#000000 ctermbg=11  ctermfg=16  | syn cluster cssColors add=cssColorffd700
  hi cssColorffdab9 guibg=#FFDAB9 guifg=#000000 ctermbg=223 ctermfg=16  | syn cluster cssColors add=cssColorffdab9
  hi cssColorffdead guibg=#FFDEAD guifg=#000000 ctermbg=223 ctermfg=16  | syn cluster cssColors add=cssColorffdead
  hi cssColorffe4b5 guibg=#FFE4B5 guifg=#000000 ctermbg=223 ctermfg=16  | syn cluster cssColors add=cssColorffe4b5
  hi cssColorffe4c4 guibg=#FFE4C4 guifg=#000000 ctermbg=224 ctermfg=16  | syn cluster cssColors add=cssColorffe4c4
  hi cssColorffe4e1 guibg=#FFE4E1 guifg=#000000 ctermbg=224 ctermfg=16  | syn cluster cssColors add=cssColorffe4e1
  hi cssColorffebcd guibg=#FFEBCD guifg=#000000 ctermbg=7   ctermfg=16  | syn cluster cssColors add=cssColorffebcd
  hi cssColorffefd5 guibg=#FFEFD5 guifg=#000000 ctermbg=255 ctermfg=16  | syn cluster cssColors add=cssColorffefd5
  hi cssColorfff0f5 guibg=#FFF0F5 guifg=#000000 ctermbg=15  ctermfg=16  | syn cluster cssColors add=cssColorfff0f5
  hi cssColorfff5ee guibg=#FFF5EE guifg=#000000 ctermbg=255 ctermfg=16  | syn cluster cssColors add=cssColorfff5ee
  hi cssColorfff8dc guibg=#FFF8DC guifg=#000000 ctermbg=255 ctermfg=16  | syn cluster cssColors add=cssColorfff8dc
  hi cssColorfffacd guibg=#FFFACD guifg=#000000 ctermbg=255 ctermfg=16  | syn cluster cssColors add=cssColorfffacd
  hi cssColorfffaf0 guibg=#FFFAF0 guifg=#000000 ctermbg=15  ctermfg=16  | syn cluster cssColors add=cssColorfffaf0
  hi cssColorfffafa guibg=#FFFAFA guifg=#000000 ctermbg=15  ctermfg=16  | syn cluster cssColors add=cssColorfffafa
  hi cssColorffff00 guibg=#FFFF00 guifg=#000000 ctermbg=11  ctermfg=16  | syn cluster cssColors add=cssColorffff00
  hi cssColorffffe0 guibg=#FFFFE0 guifg=#000000 ctermbg=255 ctermfg=16  | syn cluster cssColors add=cssColorffffe0
  hi cssColorfffff0 guibg=#FFFFF0 guifg=#000000 ctermbg=15  ctermfg=16  | syn cluster cssColors add=cssColorfffff0
  hi cssColorffffff guibg=#FFFFFF guifg=#000000 ctermbg=231 ctermfg=16  | syn cluster cssColors add=cssColorffffff

  "call s:VimCssInit(1)

  ":augroup css
    "au!
    autocmd CursorMovedI <buffer> silent call s:ProcessByLine('.')
    autocmd ColorScheme <buffer> silent call s:VimCssInit(1)
    autocmd BufEnter <buffer> silent call s:VimCssInit(1)
  ":augroup END

  "autocmd CursorMoved  <buffer> silent call s:ProcessByLine('.')
endif
