if has_key(g:polyglot_is_disabled, 'stylus')
  finish
endif

" Vim completion script
" Language: Stylus
" Author: Ilia Loginov <i.loginow@outlook.com>
" Created: 2018 Jan 28

fun! stylcomplete#CompleteStyl(findstart, base)

  if a:findstart
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] !~ '\(\s\|\[\|(\|{\|:\)'
      let start -= 1
    endwhile
    let b:start = line[start]
    let b:before = line[start - 1]
    let b:line = line[0:col('.')]
    let b:first_char = matchstrpos(b:line, '^\s*\S')[2]
    let b:first_word_type = synIDattr(synID(line('.'), b:first_char, 1), 'name')
    " Check if there is more than one word on the current line
    let b:word_break = 0
    if b:line =~ '^.*\S\(\s\|\[\|(\|{\|:\)\S.*'
      let b:word_break = 1
    endif
    return start
  endif

  " Complete properties
  if b:start =~ '\w' && b:word_break == 0
    let res = []
    for m in g:css_props
      if m =~ '^' . a:base
        call add(res, m)
      endif
    endfor
    return res

  " Complete pseudo classes and elements
  elseif b:before == ':' && b:first_word_type =~ 'stylusSelector\w*'
    let values = ["active", "any", "any-link", "blank", "checked", "cue", "cue-region", "disabled", "enabled", "default", "dir(", "disabled", "drop", "drop(", "empty", "enabled", "first", "first-child", "first-of-type", "fullscreen", "future", "focus", "focus-within", "has(", "hover", "indeterminate", "in-range", "invalid", "lang(", "last-child", "last-of-type", "left", "link", "matches(", "not(", "nth-child(", "nth-column(", "nth-last-child(", "nth-last-column(", "nth-last-of-type(", "nth-of-type(", "only-child", "only-of-type", "optional", "out-of-range", "past", "paused", "placeholder-shown", "playing", "read-only", "read-write", "required", "right", "root", "scope", "target", "user-invalid", "valid", "visited", "first-line", "first-letter", "before", "after", "selection", "backdrop"]

    let res = []
    for m in values
      if m =~ '^' . a:base
        call add(res, m)
      endif
    endfor
    return res

  " Complete !important and !optional
  elseif b:start == '!' && b:word_break == 1 && b:first_word_type == 'stylusProperty'
    let values = ["important", "optional"]

    let res = []
    for m in values
      if m =~ '^' . a:base
        call add(res, m)
      endif
    endfor
    return res

  " Complete values
  elseif b:start =~ '\w' && b:word_break == 1 && b:first_word_type == 'stylusProperty'
    let prop = matchstr(b:line, '\(^\s\+\)\@<=\<\(\w\|-\)\+\>')
    let res = []

    let wide_keywords = ["initial", "inherit", "unset"]
    let color_values = ["transparent", "rgb(", "rgba(", "hsl(", "hsla(", "#"] + g:css_colors
    let border_style_values = ["none", "hidden", "dotted", "dashed", "solid", "double", "groove", "ridge", "inset", "outset"]
    let border_width_values = ["thin", "thick", "medium"]
    let list_style_type_values = ["decimal", "decimal-leading-zero", "arabic-indic", "armenian", "upper-armenian", "lower-armenian", "bengali", "cambodian", "khmer", "cjk-decimal", "devanagari", "georgian", "gujarati", "gurmukhi", "hebrew", "kannada", "lao", "malayalam", "mongolian", "myanmar", "oriya", "persian", "lower-roman", "upper-roman", "tamil", "telugu", "thai", "tibetan", "lower-alpha", "lower-latin", "upper-alpha", "upper-latin", "cjk-earthly-branch", "cjk-heavenly-stem", "lower-greek", "hiragana", "hiragana-iroha", "katakana", "katakana-iroha", "disc", "circle", "square", "disclosure-open", "disclosure-closed"]
    let timing_functions = ["cubic-bezier(", "steps(", "linear", "ease", "ease-in", "ease-in-out", "ease-out", "step-start", "step-end"]

    if prop == 'all'

      let values = []
    elseif prop == 'additive-symbols'
      let values = []
    elseif prop == 'align-content'
      let values = ["flex-start", "flex-end", "center", "space-between", "space-around", "stretch"]
    elseif prop == 'align-items'
      let values = ["flex-start", "flex-end", "center", "baseline", "stretch"]
    elseif prop == 'align-self'
      let values = ["auto", "flex-start", "flex-end", "center", "baseline", "stretch"]
    elseif prop == 'animation'
      let values = timing_functions + ["normal", "reverse", "alternate", "alternate-reverse"] + ["none", "forwards", "backwards", "both"] + ["running", "paused"]
    elseif prop == 'animation-delay'
      let values = []
    elseif prop == 'animation-direction'
      let values = ["normal", "reverse", "alternate", "alternate-reverse"]
    elseif prop == 'animation-duration'
      let values = []
    elseif prop == 'animation-fill-mode'
      let values = ["none", "forwards", "backwards", "both"]
    elseif prop == 'animation-iteration-count'
      let values = []
    elseif prop == 'animation-name'
      let values = []
    elseif prop == 'animation-play-state'
      let values = ["running", "paused"]
    elseif prop == 'animation-timing-function'
      let values = timing_functions
    elseif prop == 'appearance'
      let values = ["auto", "none"]
    elseif prop == 'background-attachment'
      let values = ["scroll", "fixed"]
    elseif prop == 'background-color'
      let values = color_values
    elseif prop == 'background-image'
      let values = ["url(", "none"]
    elseif prop == 'background-position'
      let vals = matchstr(b:line, '.*:\s*\zs.*')
      if vals =~ '^\%([a-zA-Z]\+\)\?$'
        let values = ["top", "center", "bottom"]
      elseif vals =~ '^[a-zA-Z]\+\s\+\%([a-zA-Z]\+\)\?$'
        let values = ["left", "center", "right"]
      else
        return []
      endif
    elseif prop == 'background-repeat'
      let values = ["repeat", "repeat-x", "repeat-y", "no-repeat"]
    elseif prop == 'background-size'
      let values = ["auto", "contain", "cover"]
    elseif prop == 'background'
      let values = ["scroll", "fixed"] + color_values + ["url(", "none"] + ["top", "center", "bottom", "left", "right"] + ["repeat", "repeat-x", "repeat-y", "no-repeat"] + ["auto", "contain", "cover"]
    elseif prop =~ '^border\%(-top\|-right\|-bottom\|-left\|-block-start\|-block-end\)\?$'
      let vals = matchstr(b:line, '.*:\s*\zs.*')
      if vals =~ '^\%([a-zA-Z0-9.]\+\)\?$'
        let values = border_width_values
      elseif vals =~ '^[a-zA-Z0-9.]\+\s\+\%([a-zA-Z]\+\)\?$'
        let values = border_style_values
      elseif vals =~ '^[a-zA-Z0-9.]\+\s\+[a-zA-Z]\+\s\+\%([a-zA-Z(]\+\)\?$'
        let values = color_values
      else
        return []
      endif
    elseif prop =~ '^border-\%(top\|right\|bottom\|left\|block-start\|block-end\)-color'
      let values = color_values
    elseif prop =~ '^border-\%(top\|right\|bottom\|left\|block-start\|block-end\)-style'
      let values = border_style_values
    elseif prop =~ '^border-\%(top\|right\|bottom\|left\|block-start\|block-end\)-width'
      let values = border_width_values
    elseif prop == 'border-color'
      let values = color_values
    elseif prop == 'border-style'
      let values = border_style_values
    elseif prop == 'border-width'
      let values = border_width_values
    elseif prop == 'bottom'
      let values = ["auto"]
    elseif prop == 'box-decoration-break'
      let values = ["slice", "clone"]
    elseif prop == 'box-shadow'
      let values = ["inset"]
    elseif prop == 'box-sizing'
      let values = ["border-box", "content-box"]
    elseif prop =~ '^break-\%(before\|after\)'
      let values = ["auto", "always", "avoid", "left", "right", "page", "column", "region", "recto", "verso", "avoid-page", "avoid-column", "avoid-region"]
    elseif prop == 'break-inside'
      let values = ["auto", "avoid", "avoid-page", "avoid-column", "avoid-region"]
    elseif prop == 'caption-side'
      let values = ["top", "bottom"]
    elseif prop == 'clear'
      let values = ["none", "left", "right", "both"]
    elseif prop == 'clip'
      let values = ["auto", "rect("]
    elseif prop == 'clip-path'
      let values = ["fill-box", "stroke-box", "view-box", "none"]
    elseif prop == 'color'
      let values = color_values
    elseif prop == 'columns'
      let values = []
    elseif prop == 'column-count'
      let values = ['auto']
    elseif prop == 'column-fill'
      let values = ['auto', 'balance']
    elseif prop == 'column-rule-color'
      let values = color_values
    elseif prop == 'column-rule-style'
      let values = border_style_values
    elseif prop == 'column-rule-width'
      let values = border_width_values
    elseif prop == 'column-rule'
      let vals = matchstr(b:line, '.*:\s*\zs.*')
      if vals =~ '^\%([a-zA-Z0-9.]\+\)\?$'
        let values = border_width_values
      elseif vals =~ '^[a-zA-Z0-9.]\+\s\+\%([a-zA-Z]\+\)\?$'
        let values = border_style_values
      elseif vals =~ '^[a-zA-Z0-9.]\+\s\+[a-zA-Z]\+\s\+\%([a-zA-Z(]\+\)\?$'
        let values = color_values
      else
        return []
      endif
    elseif prop == 'column-span'
      let values = ["none", "all"]
    elseif prop == 'column-width'
      let values = ["auto"]
    elseif prop == 'content'
      let values = ["normal", "attr(", "open-quote", "close-quote", "no-open-quote", "no-close-quote"]
    elseif prop =~ '^counter-\%(increment\|reset\)$'
      let values = ["none"]
    elseif prop =~ '^cue\%(-after\|-before\)\=$'
      let values = ["url("]
    elseif prop == 'cursor'
      let values = ["url(", "auto", "crosshair", "default", "pointer", "move", "e-resize", "ne-resize", "nw-resize", "n-resize", "se-resize", "sw-resize", "s-resize", "w-resize", "text", "wait", "help", "progress"]
    elseif prop == 'direction'
      let values = ["ltr", "rtl"]
    elseif prop == 'display'
      let values = ["inline", "block", "list-item", "run-in", "inline-block", "table", "table-row-group", "table-header-group", "table-footer-group", "table-row", "table-column-group", "table-column", "table-cell", "table-caption", "none", "flex", "inline-flex", "grid", "inline-grid", "inline-table", "inline-list-item", "ruby", "ruby-base", "ruby-text", "ruby-base-container", "ruby-text-container", "contents"]
    elseif prop == 'elevation'
      let values = ["below", "level", "above", "higher", "lower"]
    elseif prop == 'empty-cells'
      let values = ["show", "hide"]
    elseif prop == 'fallback'
      let values = list_style_type_values
    elseif prop == 'filter'
      let values = ["blur(", "brightness(", "contrast(", "drop-shadow(", "grayscale(", "hue-rotate(", "invert(", "opacity(", "sepia(", "saturate("]
    elseif prop == 'flex-basis'
      let values = ["auto", "content"]
    elseif prop == 'flex-direction'
      let values = ["row", "row-reverse", "column", "column-reverse"]
    elseif prop == 'flex-flow'
      let values = ["row", "row-reverse", "column", "column-reverse", "nowrap", "wrap", "wrap-reverse"]
    elseif prop == 'flex-grow'
      let values = []
    elseif prop == 'flex-shrink'
      let values = []
    elseif prop == 'flex-wrap'
      let values = ["nowrap", "wrap", "wrap-reverse"]
    elseif prop == 'flex'
      let values = ["nowrap", "wrap", "wrap-reverse"] + ["row", "row-reverse", "column", "column-reverse", "nowrap", "wrap", "wrap-reverse"] + ["auto", "content"]
    elseif prop == 'float'
      let values = ["left", "right", "none"]
    elseif prop == 'font-display'
      let values = ["auto", "block", "swap", "fallback", "optional"]
    elseif prop == 'font-family'
      let values = ["sans-serif", "serif", "monospace", "cursive", "fantasy", "system-ui", "emoji", "math", "fangsong"]
    elseif prop == 'font-feature-settings'
      let values = ["normal", '"aalt"', '"abvf"', '"abvm"', '"abvs"', '"afrc"', '"akhn"', '"blwf"', '"blwm"', '"blws"', '"calt"', '"case"', '"ccmp"', '"cfar"', '"cjct"', '"clig"', '"cpct"', '"cpsp"', '"cswh"', '"curs"', '"cv', '"c2pc"', '"c2sc"', '"dist"', '"dlig"', '"dnom"', '"dtls"', '"expt"', '"falt"', '"fin2"', '"fin3"', '"fina"', '"flac"', '"frac"', '"fwid"', '"half"', '"haln"', '"halt"', '"hist"', '"hkna"', '"hlig"', '"hngl"', '"hojo"', '"hwid"', '"init"', '"isol"', '"ital"', '"jalt"', '"jp78"', '"jp83"', '"jp90"', '"jp04"', '"kern"', '"lfbd"', '"liga"', '"ljmo"', '"lnum"', '"locl"', '"ltra"', '"ltrm"', '"mark"', '"med2"', '"medi"', '"mgrk"', '"mkmk"', '"mset"', '"nalt"', '"nlck"', '"nukt"', '"numr"', '"onum"', '"opbd"', '"ordn"', '"ornm"', '"palt"', '"pcap"', '"pkna"', '"pnum"', '"pref"', '"pres"', '"pstf"', '"psts"', '"pwid"', '"qwid"', '"rand"', '"rclt"', '"rkrf"', '"rlig"', '"rphf"', '"rtbd"', '"rtla"', '"rtlm"', '"ruby"', '"salt"', '"sinf"', '"size"', '"smcp"', '"smpl"', '"ss01"', '"ss02"', '"ss03"', '"ss04"', '"ss05"', '"ss06"', '"ss07"', '"ss08"', '"ss09"', '"ss10"', '"ss11"', '"ss12"', '"ss13"', '"ss14"', '"ss15"', '"ss16"', '"ss17"', '"ss18"', '"ss19"', '"ss20"', '"ssty"', '"stch"', '"subs"', '"sups"', '"swsh"', '"titl"', '"tjmo"', '"tnam"', '"tnum"', '"trad"', '"twid"', '"unic"', '"valt"', '"vatu"', '"vert"', '"vhal"', '"vjmo"', '"vkna"', '"vkrn"', '"vpal"', '"vrt2"', '"zero"']
    elseif prop == 'font-kerning'
      let values = ["auto", "normal", "none"]
    elseif prop == 'font-language-override'
      let values = ["normal"]
    elseif prop == 'font-size'
      let values = ["xx-small", "x-small", "small", "medium", "large", "x-large", "xx-large", "larger", "smaller"]
    elseif prop == 'font-size-adjust'
      let values = []
    elseif prop == 'font-stretch'
      let values = ["normal", "ultra-condensed", "extra-condensed", "condensed", "semi-condensed", "semi-expanded", "expanded", "extra-expanded", "ultra-expanded"]
    elseif prop == 'font-style'
      let values = ["normal", "italic", "oblique"]
    elseif prop == 'font-synthesis'
      let values = ["none", "weight", "style"]
    elseif prop == 'font-variant-alternates'
      let values = ["normal", "historical-forms", "stylistic(", "styleset(", "character-variant(", "swash(", "ornaments(", "annotation("]
    elseif prop == 'font-variant-caps'
      let values = ["normal", "small-caps", "all-small-caps", "petite-caps", "all-petite-caps", "unicase", "titling-caps"]
    elseif prop == 'font-variant-asian'
      let values = ["normal", "ruby", "jis78", "jis83", "jis90", "jis04", "simplified", "traditional"]
    elseif prop == 'font-variant-ligatures'
      let values = ["normal", "none", "common-ligatures", "no-common-ligatures", "discretionary-ligatures", "no-discretionary-ligatures", "historical-ligatures", "no-historical-ligatures", "contextual", "no-contextual"]
    elseif prop == 'font-variant-numeric'
      let values = ["normal", "ordinal", "slashed-zero", "lining-nums", "oldstyle-nums", "proportional-nums", "tabular-nums", "diagonal-fractions", "stacked-fractions"]
    elseif prop == 'font-variant-position'
      let values = ["normal", "sub", "super"]
    elseif prop == 'font-variant'
      let values = ["normal", "historical-forms", "stylistic(", "styleset(", "character-variant(", "swash(", "ornaments(", "annotation("] + ["small-caps", "all-small-caps", "petite-caps", "all-petite-caps", "unicase", "titling-caps"] + ["ruby", "jis78", "jis83", "jis90", "jis04", "simplified", "traditional"] + ["none", "common-ligatures", "no-common-ligatures", "discretionary-ligatures", "no-discretionary-ligatures", "historical-ligatures", "no-historical-ligatures", "contextual", "no-contextual"] + ["ordinal", "slashed-zero", "lining-nums", "oldstyle-nums", "proportional-nums", "tabular-nums", "diagonal-fractions", "stacked-fractions"] + ["sub", "super"]
    elseif prop == 'font-weight'
      let values = ["normal", "bold", "bolder", "lighter", "100", "200", "300", "400", "500", "600", "700", "800", "900"]
    elseif prop == 'font'
      let values = ["normal", "italic", "oblique", "small-caps", "bold", "bolder", "lighter", "100", "200", "300", "400", "500", "600", "700", "800", "900", "xx-small", "x-small", "small", "medium", "large", "x-large", "xx-large", "larger", "smaller", "sans-serif", "serif", "monospace", "system-ui", "emoji", "math", "fangsong", "cursive", "fantasy", "caption", "icon", "menu", "message-box", "small-caption", "status-bar"]
    elseif prop =~ '^\%(height\|width\)$'
      let values = ["auto", "border-box", "content-box", "max-content", "min-content", "available", "fit-content"]
    elseif prop =~ '^\%(left\|rigth\)$'
      let values = ["auto"]
    elseif prop == 'image-rendering'
      let values = ["auto", "crisp-edges", "pixelated"]
    elseif prop == 'image-orientation'
      let values = ["from-image", "flip"]
    elseif prop == 'ime-mode'
      let values = ["auto", "normal", "active", "inactive", "disabled"]
    elseif prop == 'inline-size'
      let values = ["auto", "border-box", "content-box", "max-content", "min-content", "available", "fit-content"]
    elseif prop == 'isolation'
      let values = ["auto", "isolate"]
    elseif prop == 'justify-content'
      let values = ["flex-start", "flex-end", "center", "space-between", "space-around"]
    elseif prop == 'letter-spacing'
      let values = ["normal"]
    elseif prop == 'line-break'
      let values = ["auto", "loose", "normal", "strict"]
    elseif prop == 'line-height'
      let values = ["normal"]
    elseif prop == 'list-style-image'
      let values = ["url(", "none"]
    elseif prop == 'list-style-position'
      let values = ["inside", "outside"]
    elseif prop == 'list-style-type'
      let values = list_style_type_values
    elseif prop == 'list-style'
      let values = list_style_type_values + ["inside", "outside"] + ["url(", "none"]
    elseif prop == 'margin'
      let values = ["auto"]
    elseif prop =~ '^margin-\%(right\|left\|top\|bottom\|block-start\|block-end\|inline-start\|inline-end\)$'
      let values = ["auto"]
    elseif prop == 'marks'
      let values = ["crop", "cross", "none"]
    elseif prop == 'mask'
      let values = ["url("]
    elseif prop == 'mask-type'
      let values = ["luminance", "alpha"]
    elseif prop == '\%(max\|min\)-\%(block\|inline\)-size'
      let values = ["auto", "border-box", "content-box", "max-content", "min-content", "available", "fit-content"]
    elseif prop == '\%(max\|min\)-\%(height\|width\)'
      let values = ["auto", "border-box", "content-box", "max-content", "min-content", "available", "fit-content"]
    elseif prop == '\%(max\|min\)-zoom'
      let values = ["auto"]
    elseif prop == 'mix-blend-mode'
      let values = ["normal", "multiply", "screen", "overlay", "darken", "lighten", "color-dodge", "color-burn", "hard-light", "soft-light", "difference", "exclusion", "hue", "saturation", "color", "luminosity"]
    elseif prop == 'object-fit'
      let values = ['fill', 'contain', 'cover', 'scale-down']
    elseif prop == 'opacity'
      let values = []
    elseif prop == 'orientation'
      let values = ["auto", "portrait", "landscape"]
    elseif prop == 'orphans'
      let values = []
    elseif prop == 'outline-offset'
      let values = []
    elseif prop == 'outline-color'
      let values = color_values
    elseif prop == 'outline-style'
      let values = ["none", "hidden", "dotted", "dashed", "solid", "double", "groove", "ridge", "inset", "outset"]
    elseif prop == 'outline-width'
      let values = ["thin", "thick", "medium"]
    elseif prop == 'outline'
      let vals = matchstr(b:line, '.*:\s*\zs.*')
      if vals =~ '^\%([a-zA-Z0-9,()#]\+\)\?$'
        let values = color_values
      elseif vals =~ '^[a-zA-Z0-9,()#]\+\s\+\%([a-zA-Z]\+\)\?$'
        let values = ["none", "hidden", "dotted", "dashed", "solid", "double", "groove", "ridge", "inset", "outset"]
      elseif vals =~ '^[a-zA-Z0-9,()#]\+\s\+[a-zA-Z]\+\s\+\%([a-zA-Z(]\+\)\?$'
        let values = ["thin", "thick", "medium"]
      else
        return []
      endif
    elseif prop == 'overflow-wrap'
      let values = ["normal", "break-word"]
    elseif prop =~ '^overflow\%(-x\|-y\)\='
      let values = ["visible", "hidden", "scroll", "auto"]
    elseif prop == 'pad'
      let values = []
    elseif prop == 'padding'
      let values = []
    elseif prop =~ '^padding-\%(top\|right\|bottom\|left\|inline-start\|inline-end\|block-start\|block-end\)$'
      let values = []
    elseif prop =~ '^page-break-\%(after\|before\)$'
      let values = ["auto", "always", "avoid", "left", "right", "recto", "verso"]
    elseif prop == 'page-break-inside'
      let values = ["auto", "avoid"]
    elseif prop =~ '^pause\%(-after\|-before\)\=$'
      let values = ["none", "x-weak", "weak", "medium", "strong", "x-strong"]
    elseif prop == 'perspective'
      let values = ["none"]
    elseif prop == 'perspective-origin'
      let values = ["top", "bottom", "left", "center", " right"]
    elseif prop == 'pointer-events'
      let values = ["auto", "none", "visiblePainted", "visibleFill", "visibleStroke", "visible", "painted", "fill", "stroke", "all"]
    elseif prop == 'position'
      let values = ["static", "relative", "absolute", "fixed", "sticky"]
    elseif prop == 'prefix'
      let values = []
    elseif prop == 'quotes'
      let values = ["none"]
    elseif prop == 'range'
      let values = ["auto", "infinite"]
    elseif prop == 'resize'
      let values = ["none", "both", "horizontal", "vertical"]
    elseif prop =~ '^rest\%(-after\|-before\)\=$'
      let values = ["none", "x-weak", "weak", "medium", "strong", "x-strong"]
    elseif prop == 'ruby-align'
      let values = ["start", "center", "space-between", "space-around"]
    elseif prop == 'ruby-merge'
      let values = ["separate", "collapse", "auto"]
    elseif prop == 'ruby-position'
      let values = ["over", "under", "inter-character"]
    elseif prop == 'scroll-behavior'
      let values = ["auto", "smooth"]
    elseif prop == 'scroll-snap-coordinate'
      let values = ["none"]
    elseif prop == 'scroll-snap-destination'
      return []
    elseif prop == 'scroll-snap-points-\%(x\|y\)$'
      let values = ["none", "repeat("]
    elseif prop == 'scroll-snap-type\%(-x\|-y\)\=$'
      let values = ["none", "mandatory", "proximity"]
    elseif prop == 'shape-image-threshold'
      let values = []
    elseif prop == 'shape-margin'
      let values = []
    elseif prop == 'shape-outside'
      let values = ["margin-box", "border-box", "padding-box", "content-box", 'inset(', 'circle(', 'ellipse(', 'polygon(', 'url(']
    elseif prop == 'speak'
      let values = ["auto", "none", "normal"]
    elseif prop == 'speak-as'
      let values = ["auto", "normal", "spell-out", "digits"]
    elseif prop == 'src'
      let values = ["url("]
    elseif prop == 'suffix'
      let values = []
    elseif prop == 'symbols'
      let values = []
    elseif prop == 'system'
      let vals = matchstr(b:line, '.*:\s*\zs.*')
      if vals =~ '^extends'
        let values = list_style_type_values
      else
        let values = ["cyclic", "numeric", "alphabetic", "symbolic", "additive", "fixed", "extends"]
      endif
    elseif prop == 'table-layout'
      let values = ["auto", "fixed"]
    elseif prop == 'tab-size'
      let values = []
    elseif prop == 'text-align'
      let values = ["start", "end", "left", "right", "center", "justify", "match-parent"]
    elseif prop == 'text-align-last'
      let values = ["auto", "start", "end", "left", "right", "center", "justify"]
    elseif prop == 'text-combine-upright'
      let values = ["none", "all", "digits"]
    elseif prop == 'text-decoration-line'
      let values = ["none", "underline", "overline", "line-through", "blink"]
    elseif prop == 'text-decoration-color'
      let values = color_values
    elseif prop == 'text-decoration-style'
      let values = ["solid", "double", "dotted", "dashed", "wavy"]
    elseif prop == 'text-decoration'
      let values = ["none", "underline", "overline", "line-through", "blink"] + ["solid", "double", "dotted", "dashed", "wavy"] + color_values
    elseif prop == 'text-emphasis-color'
      let values = color_values
    elseif prop == 'text-emphasis-position'
      let values = ["over", "under", "left", "right"]
    elseif prop == 'text-emphasis-style'
      let values = ["none", "filled", "open", "dot", "circle", "double-circle", "triangle", "sesame"]
    elseif prop == 'text-emphasis'
      let values = color_values + ["over", "under", "left", "right"] + ["none", "filled", "open", "dot", "circle", "double-circle", "triangle", "sesame"]
    elseif prop == 'text-indent'
      let values = ["hanging", "each-line"]
    elseif prop == 'text-orientation'
      let values = ["mixed", "upright", "sideways", "sideways-right", "use-glyph-orientation"]
    elseif prop == 'text-overflow'
      let values = ["clip", "ellipsis", "fade", "fade("]
    elseif prop == 'text-rendering'
      let values = ["auto", "optimizeSpeed", "optimizeLegibility", "geometricPrecision"]
    elseif prop == 'text-shadow'
      let values = color_values
    elseif prop == 'text-transform'
      let values = ["capitalize", "uppercase", "lowercase", "full-width", "none"]
    elseif prop == 'text-underline-position'
      let values = ["auto", "under", "left", "right"]
    elseif prop == 'touch-action'
      let values = ["auto", "none", "pan-x", "pan-y", "manipulation", "pan-left", "pan-right", "pan-top", "pan-down"]
    elseif prop == 'transform'
      let values = ["matrix(", "translate(", "translateX(", "translateY(", "scale(", "scaleX(", "scaleY(", "rotate(", "skew(", "skewX(", "skewY(", "matrix3d(", "translate3d(", "translateZ(", "scale3d(", "scaleZ(", "rotate3d(", "rotateX(", "rotateY(", "rotateZ(", "perspective("]
    elseif prop == 'transform-box'
      let values = ["border-box", "fill-box", "view-box"]
    elseif prop == 'transform-origin'
      let values = ["left", "center", "right", "top", "bottom"]
    elseif prop == 'transform-style'
      let values = ["flat", "preserve-3d"]
    elseif prop == 'top'
      let values = ["auto"]
    elseif prop == 'transition-property'
      let values = ["all", "none"] + g:css_animatable_props
    elseif prop == 'transition-duration'
      let values = []
    elseif prop == 'transition-delay'
      let values = []
    elseif prop == 'transition-timing-function'
      let values = timing_functions
    elseif prop == 'transition'
      let values = ["all", "none"] + g:css_animatable_props + timing_functions
    elseif prop == 'unicode-bidi'
      let values = ["normal", "embed", "isolate", "bidi-override", "isolate-override", "plaintext"]
    elseif prop == 'unicode-range'
      let values = ["U+"]
    elseif prop == 'user-select'
      let values = ["auto", "text", "none", "contain", "all"]
    elseif prop == 'user-zoom'
      let values = ["zoom", "fixed"]
    elseif prop == 'vertical-align'
      let values = ["baseline", "sub", "super", "top", "text-top", "middle", "bottom", "text-bottom"]
    elseif prop == 'visibility'
      let values = ["visible", "hidden", "collapse"]
    elseif prop == 'voice-volume'
      let values = ["silent", "x-soft", "soft", "medium", "loud", "x-loud"]
    elseif prop == 'voice-balance'
      let values = ["left", "center", "right", "leftwards", "rightwards"]
    elseif prop == 'voice-family'
      let values = []
    elseif prop == 'voice-rate'
      let values = ["normal", "x-slow", "slow", "medium", "fast", "x-fast"]
    elseif prop == 'voice-pitch'
      let values = ["absolute", "x-low", "low", "medium", "high", "x-high"]
    elseif prop == 'voice-range'
      let values = ["absolute", "x-low", "low", "medium", "high", "x-high"]
    elseif prop == 'voice-stress'
      let values = ["normal", "strong", "moderate", "none", "reduced "]
    elseif prop == 'voice-duration'
      let values = ["auto"]
    elseif prop == 'white-space'
      let values = ["normal", "pre", "nowrap", "pre-wrap", "pre-line"]
    elseif prop == 'widows'
      let values = []
    elseif prop == 'will-change'
      let values = ["auto", "scroll-position", "contents"] + s:values
    elseif prop == 'word-break'
      let values = ["normal", "break-all", "keep-all"]
    elseif prop == 'word-spacing'
      let values = ["normal"]
    elseif prop == 'word-wrap'
      let values = ["normal", "break-word"]
    elseif prop == 'writing-mode'
      let values = ["horizontal-tb", "vertical-rl", "vertical-lr", "sideways-rl", "sideways-lr"]
    elseif prop == 'z-index'
      let values = ["auto"]
    elseif prop == 'zoom'
      let values = ["auto"]
    else
      let values = wide_keywords
    endif

    let values = values + wide_keywords

    for m in values
      if m =~ '^' . a:base
        call add(res, m)
      endif
    endfor
    return res

  " Complete @-rules

  elseif b:start =~ '\w' && b:word_break == 1 && b:first_word_type == 'stylusAtRuleMedia'

    let values = ["min-width", "min-height", "max-width", "max-height"]

    let res = []

    for m in values
      if m =~ '^' . a:base
        call add(res, m . ': ')
      endif
    endfor

    return res

  elseif b:start == '@'

    let values = ["@media", "@import", "@extend", "@block", "@charset", "@page", "@font-face", "@namespace", "@supports", "@keyframes", "@viewport", "@document", "@css"]

    let res = []

    for m in values
      if m =~ '^' . a:base
        call add(res, m .' ')
      endif
    endfor

    return res

  endif

  return []

endfun
