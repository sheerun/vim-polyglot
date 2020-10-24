let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'ftplugin/scala.xpt.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'scala') == -1


XPTemplate priority=lang

XPTvar $BRif ' '
XPTvar $BRel \n
XPTvar $BRloop ' '
XPTvar $BRfun ' '

XPTinclude
    \ _common/personal
    \ java/java

XPT cake hint=Cake\ Pattern
XSET trait|def=Some
XSET derived|def=Real
trait `trait^Component {
	trait `trait^ {
		`body^
	}

	val `trait^SV('(.)', '\l\1', '')^^: `trait^
}

trait `derived^`trait^Component extends `trait^Component {

	override lazy val `trait^SV('(.)', '\l\1', '')^^ = new `trait^ {
		`body2^
	}
}

endif
