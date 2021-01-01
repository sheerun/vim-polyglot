if polyglot#init#is_disabled(expand('<sfile>:p'), 'icalendar', 'syntax/icalendar.vim')
  finish
endif

" Vim syntax file
" Language:      icalendar <http://www.ietf.org/rfc/rfc2445.txt>
" Maintainer:    Steven N. Severinghaus <sns@severinghaus.org>
" Last Modified: 2006-04-17
" Version:       0.3

" Quit if syntax file is already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

command! -nargs=+ IcalHiLink hi def link <args>

syntax case ignore
setlocal iskeyword+=-

syn match	icalObject	"^\(BEGIN\|END\)"
syn match	icalObjectType	":\(VCALENDAR\|VEVENT\|VTODO\|VJOURNAL\|VFREEBUSY\|VTIMEZONE\|VALARM\)$"
syn match	icalObjectType	":\(DAYLIGHT\|STANDARD\)$"
syn match	icalProperty	"^\(DTSTART\|PRODID\|VERSION\|CALSCALE\|METHOD\)"
syn match	icalProperty	"^\(DTEND\|DTSTAMP\|ORGANIZER\|UID\|CLASS\|CREATED\)"
syn match	icalProperty	"^\(LOCATION\|SEQUENCE\|STATUS\|SUMMARY\|COMMENT\)"
syn match	icalProperty	"^\(TRANSP\|ATTENDEE\|ATTACH\|FREEBUSY\|METHOD\|CONTACT\)"
syn match	icalProperty	"^\(DURATION\|RRULE\|EXDATE\|EXRULE\|URL\|DESCRIPTION\|ACTION\)"
syn match	icalProperty	"^\(LAST-MODIFIED\|RECURRENCE-ID\|TRIGGER\|RELATED-TO\|RDATE\)"
syn match	icalProperty	"^\(TZID\|TZOFFSETFROM\|TZOFFSETTO\|TZNAME\|TZURL\)"
syn match	icalProperty	"^\(PRIORITY\|DUE\|COMPLETED\|PERCENT-COMPLETE\|CATEGORIES\)"
syn match	icalProperty	"^\(RESOURCES\|REPEAT\|REQUEST-STATUS\)"
syn match	icalCustom	/^X-[A-Z-]\+/
syn match	icalDate	"\<\d\{8}\>"
syn match	icalDate	"[0-9]\{8}T[0-9]\{6}Z\="
syn match	icalParameter	"[A-Z0-9-]\+=[^;:]\+"
syn keyword	icalSetValue	CONFIRMED TENTATIVE CANCELLED DELEGATED OPAQUE
syn keyword	icalSetValue	NEEDS-ACTION ACCEPTED DECLINED IN-PROGRESS
syn keyword	icalSetValue	PRIVATE PUBLIC PUBLISH GREGORIAN DISPLAY
syn match	icalSetValue	/:COMPLETED$/

" Types: PreProc Keyword Type String Comment Special
IcalHiLink	icalProperty	PreProc
IcalHiLink	icalObject	Label
IcalHiLink	icalObjectType	Type
IcalHiLink	icalDate	String
IcalHiLink	icalParameter	Comment
IcalHiLink	icalSetValue	Special
IcalHiLink	icalCustom	Error

delcommand IcalHiLink
  
let b:current_syntax = "icalendar"

"EOF vim: tw=78:ft=vim:ts=8


