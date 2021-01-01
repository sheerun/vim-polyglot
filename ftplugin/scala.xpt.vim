if polyglot#init#is_disabled(expand('<sfile>:p'), 'scala', 'ftplugin/scala.xpt.vim')
  finish
endif


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
