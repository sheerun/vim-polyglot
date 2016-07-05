if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'pgsql') == -1
  
" Vim syntax file
" Language:     pgsql
" Maintainer:   Devrim GUNDUZ <devrim@PostgreSQL.org>
" Contributors: Jacek Wysocki, Ryan Delaney <ryan.delaney@gmail.com>
" Last Change:  $Fri May 23 09:55:21 PDT 2014$
" Filenames:    *.pgsql *.plpgsql
" URL:			http://www.gunduz.org/postgresql/pgsql.vim
" Note:			The definitions below are for PostgreSQL 8.4, some versions may differ.
" Changelog:	Thanks to Todd A. Cook for the updates
" Changelog:	Thanks a lot to David Fetter for the big update set, that came as of Mar 11, 2010.

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Always ignore case
syn case ignore

" Section: Syntax {{{1

" Section: Miscellaneous {{{2

" General keywords which don't fall into other categories {{{3
"
" Use match instead of keyword to lower priority and allow data types bits
" and other constructs to match too
syn match pgsqlKeyword	    "\<as\>"
syn match pgsqlKeyword	    "\<add\>"
syn match pgsqlKeyword	    "\<all\>"
syn match pgsqlKeyword	    "\<cast\>"
syn match pgsqlKeyword	    "\<cluster\>"
syn match pgsqlKeyword	    "\<copy\>"
syn match pgsqlKeyword	    "\<default\>"
syn match pgsqlKeyword	    "\<do\>"
syn match pgsqlKeyword	    "\<drop\>"
syn match pgsqlKeyword	    "\<end\>"
" fun fact: 'create table fetch ()' fails, but not 'create table move ()'
syn match pgsqlKeyword      "\<fetch\>"
syn match pgsqlKeyword      "\<for\>"
syn match pgsqlKeyword      "\<full\>"
syn match pgsqlKeyword	    "\<from\>"
syn match pgsqlKeyword      "\<grant\>"
syn match pgsqlKeyword	    "\<group\>"
syn match pgsqlKeyword      "\<if\>"
syn match pgsqlOperator     "\<in\>"
syn match pgsqlKeyword	    "\<key\>"
syn match pgsqlKeyword      "\<language\>"
syn match pgsqlKeyword      "\<nothing\>"
syn match pgsqlKeyword      "\<on\>"
syn match pgsqlKeyword	    "\<only\>"
syn match pgsqlKeyword	    "\<options\>"
syn match pgsqlKeyword	    "\<range\>"
syn match pgsqlKeyword      "\<returns\>"
syn match pgsqlKeyword	    "\<row\>"
syn match pgsqlKeyword	    "\<rows\>"
syn match pgsqlKeyword	    "\<schema\>"
syn match pgsqlKeyword	    "\<set\>"
syn match pgsqlKeyword	    "\<table\>"
syn match pgsqlKeyword	    "\<to\>"
syn match pgsqlKeyword	    "\<user\>"
syn match pgsqlKeyword	    "\<update\>"
syn match pgsqlKeyword      "\<with\(\_s\+recursive\)\?\>"
syn match pgsqlKeyword	    "\<where\>"

syn match pgsqlKeyword      "\<\(begin\|commit\|rollback\|abort\|start\|end\)\(\_s\+work\|\_s\+transaction\)\?\>"
syn match pgsqlKeyword      "\<isolation\_s\+level\_s\+\(serializable\|repeatable\_s\+read\|read\_s\+committed\|read\_s\+uncommitted\)\>"
syn match pgsqlKeyword      "\<read\_s\+\(write\|only\)\>"

syn match pgsqlKeyword      "\<\(commit\|rollback\)\_s\+prepared\>"
syn match pgsqlKeyword      "\<savepoint\>"
syn match pgsqlKeyword      "\<rollback\_s\+to\_s\+savepoint\>"
syn match pgsqlKeyword      "\<release\(\_s\+savepoint\)\?\>"

syn match pgsqlKeyword      "\<close\(\_s\+all\)\?\>"
syn match pgsqlKeyword      "\<\(binary\_s\+\|insensitive\_s\+\|\(no\_s\+\)\?scroll\_s\+\)*cursor\(\_s\+with\(out\)\_s\+hold\)\?\_s\+for\>"

syn match pgsqlKeyword      "\<current\_s\+of\>"
syn match pgsqlKeyword      "\<delete\_s\+from\>"
syn match pgsqlKeyword      "\<discard\_s\+\(all\|plans\|sequences\|temp\|temporary\)\>"

syn match pgsqlKeyword      "\<\(alter\|add\|drop\|comment\_s\+on\|create\)\_s\+\(aggregate\|attribute\|cast\|collation\|conversion\|database\|default\_s\+privileges\|domain\|\(event\_s\+\)\?trigger\|extension\|foreign\_s\+\(data\_s\+wrapper\|table\)\|function\|group\|index\(\_s\+concurrently\)\?\|\(procedural\_s\+\)\?language\|materialized\_s\+view\|operator\(\_s\+class\|\_s\+family\)\?\|owned\_s\+by\|role\|rule\|schema\|sequence\|server\|table\|tablespace\|text\_s\+search\_s\+\(configuration\|dictionary\|parser\|template\)\|type\|user\(\_s\+mapping\)\?\|view\)\>"

syn match pgsqlKeyword      "\<create\_s\+default\_s\+conversion\>"
syn match pgsqlKeyword      "\<create\_s\+\(or\_s\+replace\_s\+\)\?\(function\|\(trusted\_s\+\)\?\(procedural\_s\+\)\?language\|rule\)\>"
syn match pgsqlKeyword      "\<create\_s\+unique\_s\+index\(\_s\+concurrently\)\?\>"
syn match pgsqlKeyword      "\<create\_s\+temp\(orary\)\?\_s\+sequence\>"
syn match pgsqlKeyword      "\<create\_s\+\(temp\(orary\)\?\|unlogged\)\_s\+table\>"
syn match pgsqlKeyword      "\<on\_s\+commit\_s\+\(preserve\_s\+rows\|delete\_s\+rows\|drop\)\>"
syn match pgsqlKeyword      "\<match\_s\+\(full\|partial\|simple\)\>"
syn match pgsqlKeyword      "\<\(including\|excluding\)\_s\+\(defaults\|constraints\|indexes\|storage\|comments\|all\)\>"

syn match pgsqlKeyword      "\<create\_s\+\(constraint\)\?\_s\+\(trigger\)\>"
syn match pgsqlKeyword      "\<\(before\|after\|instead\_s\+of\)\_s\+\(insert\|update\|delete\|truncate\)\(\_s\+or\_s\+\(insert\|update\|delete\|truncate\)\)*\>"
syn match pgsqlKeyword      "\<for\_s\+\(each\_s\+\)\?\(row\|statement\)\>"

syn match pgsqlKeyword      "\<create\_s\+\(or\_s\+replace\_s\+\)\?\(temp\(orary\)\?\_s\+\)\?\(recursive\_s\+\)\?view\>"
syn match pgsqlKeyword      "\<with\_s\+\(cascaded\|local\)\_s\+check\_s\+option\>"

syn match pgsqlKeyword      "\<do\(\_s\+also\|\_s\+instead\)\?\(\_s\+nothing\)\?\>"

syn match pgsqlKeyword      "\<\(rename\|owner\)\_s\+to\>"
syn match pgsqlKeyword      "\<for\_s\+\(role\|user\)\>"
syn match pgsqlKeyword      "\<\(drop\|rename\|validate\)\_s\+constraint\>"
syn match pgsqlKeyword      "\<\(disable\|enable\(\_s\+\(replica\|always\)\)\?\)\(\_s\+trigger\)\?\>"
syn match pgsqlKeyword      "\<\(no\_s\+\)\?\(handler\|validator\)\>"
syn match pgsqlKeyword      "\<if\_s\+\(not\_s\+\)\?exists\>"
syn match pgsqlKeyword      "\<\(set\|drop\)\_s\+\(default\|not\_s\+null\)\>"
syn match pgsqlKeyword      "\<\(set\_s\+data\_s\+\)type\>"
syn match pgsqlKeyword      "\<set\_s\+storage\_s\+\(plain\|external\|extended\|main\)\>"
syn match pgsqlKeyword      "\<set\_s\+statistics\>"
syn match pgsqlKeyword      "\<cluster\_s\+on\>"
syn match pgsqlKeyword      "\<set\_s\+without\_s\+cluster\>"
syn match pgsqlKeyword      "\<\(enable\|disable\)\_s\+rule\>"
syn match pgsqlKeyword      "\<as\_s\+on\_s\+\(select\|insert\|update\|delete\)\>"

syn match pgsqlKeyword      "\<alter\_s\+\(constraint\|system\)\>"
syn match pgsqlKeyword      "\<\(initially\_s\+\)\?\(deferred\|immediate\)\>"
syn match pgsqlKeyword      "\<on\_s\+\(delete\|update\)>"
syn match pgsqlKeyword      "\<set\_s\+with\(out\)\?\_s\+oids\>"
syn match pgsqlKeyword      "\<for\_s\+\(search\|order\_s\+by\)\>"
syn match pgsqlKeyword      "\<\(no\_s\+\)\?inherit\>"
syn match pgsqlKeyword      "\<\(not\_s\+\)\?of\>"
syn match pgsqlKeyword      "\<primary\_s\+key\>"
syn match pgsqlKeyword      "\<foreign\_s\+key\>"
syn match pgsqlKeyword      "\<replica\_s\+identity\>"
syn match pgsqlKeyword      "\<using\(\_s\+index\(\_s\+tablespace\)\?\)\?\>"
syn match pgsqlKeyword      "\<with\(out\)\?\_s\+function\>"
syn match pgsqlKeyword      "\<with\_s\+inout\>"
syn match pgsqlKeyword      "\<as\_s\+\(assignment\|implicit\)\>"

syn match pgsqlKeyword      "\<explain\(\_s\+verbose\|\_s\+analyze\)*\>"
syn match pgsqlKeyword      "\<\(analyze\|verbose\|costs\|buffers\|timing\)\(\_s\+\(true\|on\|1\|false\|off\|0\)\)\?\>"
syn match pgsqlKeyword      "\<format\_s\+\(text\|xml\|json\|yaml\)\>"

syn match pgsqlKeyword      "\<\(fetch\|move\)\_s\+\(next\|prior\|first\|last\|absolute\|relative\|\(forward\|backward\)\(\_s\+all\)\?\)\>"

syn match pgsqlKeyword      "\<grant\_s\+\(select\|insert\|update\|delete\|truncate\|references\|trigger\|connect\|temporary\|temp\|usage\|execute\|all\(\_s\+privileges\)\?\)\(\_s*,\_s*\(select\|insert\|update\|delete\|truncate\|references\|trigger\|connect\|temporary\|temp\|usage\|execute\|all\(\_s\+privileges\)\?\)\)*\>"
syn match pgsqlKeyword      "\<on\_s\+\(table\|sequence\|database\|domain\|foreign\_s\+data\_s\+wrapper\|foreign\_s\+server\|function\|language\|large\_s\+object\|schema\|tablespace\|type\|all\_s\+\(tables\|sequences\|functions\)\_s\+in\_s\+schema\)\>"
syn match pgsqlKeyword      "\<with\_s\+\(grant\|admin\)\_s\+option\>"
syn match pgsqlKeyword      "\<insert\_s\+into\>"
syn match pgsqlKeyword      "\<\(default\_s\+\)\?values\>"

syn match pgsqlKeyword      "\<\(called\|returns\_s\+null\)\_s\+on\_s\+null\_s\+input\>"
syn match pgsqlKeyword      "\<\(external\_s\+\)\?security\_s\+\(definer\|invoker\)\>"
syn match pgsqlKeyword      "\<from\_s\+current\>"

syn match pgsqlKeyword      "\<in\_s\+schema\>"
syn match pgsqlKeyword      "\<in\_s\+\(access\_s\+share\|row\_s\+share\|row\_s\+exclusive\|\_s\+share\_s\+update\_s\+exclusive\|share\|share\_s\+row\_s\+exclusive\|exclusive\|access\_s\+exclusive\)\_s\+mode\>"

syn match pgsqlKeyword      "\<prepare\(\_s\+transaction\)\?\>"
syn match pgsqlKeyword      "\<execute\(\_s\+procedure\)\?\>"
syn match pgsqlKeyword      "\<deallocate\(\_s\+prepare\)\?\>"
syn match pgsqlKeyword      "\<\(reassign\_s\+\)\?owned\_s\+by\>"

syn match pgsqlKeyword      "\<refresh\_s\+materialized\_s\+view\(\_s\+concurrently\)\?\>"
syn match pgsqlKeyword      "\<with\_s\+\(no\_s\+\)\?data\>"

syn match pgsqlKeyword      "\<reindex\_s\+\(index\|table\|database\|system\)\>"

syn match pgsqlKeyword      "\<reset\(\_s\+all\)\?\>"

syn match pgsqlKeyword      "\<revoke\(\_s\+grant\_s\+option\_s\+for\)\?\>"
syn match pgsqlKeyword      "\<revoke\(\_s\+grant\_s\+option\_s\+for\)\?\_s\+\(select\|insert\|update\|delete\|truncate\|references\|trigger\|connect\|temporary\|temp\|usage\|execute\|all\(\_s\+privileges\)\?\)\(\_s*,\_s*\(select\|insert\|update\|delete\|truncate\|references\|trigger\|connect\|temporary\|temp\|usage\|execute\|all\(\_s\+privileges\)\?\)\)*\>"
syn match pgsqlKeyword      "\<security\_s\+label\>"

syn match pgsqlKeyword      "\<select\(\_s\+all\|\_s\+distinct\(\_s\+on\)\?\)\?\>"
syn match pgsqlKeyword      "\<for\_s\+\(update\|no\_s\+key\_s\+update\|share\|key\_s\+share\)\_s\+of\>"
syn match pgsqlKeyword      "\<with\_s\+ordinality\>"
syn match pgsqlKeyword      "\<\(\(inner\|cross\|\(left\|right\|full\)\(\_s\+outer\)\?\)\_s\+\)\?join\>"
syn match pgsqlKeyword      "\<union\(\_s\+all\)\?\>"
syn match pgsqlKeyword      "\<\(unbounded\_s\+\)\?\(preceding\|following\)\>"
syn match pgsqlKeyword      "\<order\_s\+by\>"
syn match pgsqlKeyword      "\<current\_s\+row\>"
syn match pgsqlKeyword      "\<partition\_s\+by\>"
syn match pgsqlKeyword      "\<nulls\_s\+\(first\|last\)\>"
syn match pgsqlKeyword      "\<into\(\_s\+\(temp\|temporary\|unlogged\)\)\?\(\_s\+table\)\?\>"
syn match pgsqlKeyword      "\<set\_s\+\(session\|local\|tablespace\|schema\)\?\>"
syn match pgsqlKeyword      "\<set\_s\+constraints\(\_s\+all\)\?\>"
syn match pgsqlKeyword      "\<set\(\_s\+session\|\_s\+local\)\?\_s\+\(role\(\_s\+none\)\?\)\>"
syn match pgsqlKeyword      "\<set\(\_s\+session\|\_s\+local\)\?\_s\+\(session\_s\+authorization\(\_s\+default\)\?\)\>"
syn match pgsqlKeyword      "\<reset\_s\+\(role\|session\_s\+authorization\)\>"
syn match pgsqlKeyword      "\<set\_s\+transaction\(\_s\+snapshot\)\?\>"
syn match pgsqlKeyword      "\<set\_s\+session\_s\+characteristics\_s\+as\_s\+transaction\>"

syn match pgsqlKeyword      "\<show\(\_s\+all\)\?\>"

syn match pgsqlKeyword      "\<\(restart\|continue\)\_s\+identity\>"

syn match pgsqlKeyword      "\<vacuum\(\_s\+full\|\_s\+freeze\|\_s\+verbose\)*\>"

syn keyword pgsqlKeyword	 and alias asc
syn keyword pgsqlKeyword	 cascade current_date current_time current_timestamp
syn keyword pgsqlKeyword	 checkpoint check cost
syn keyword pgsqlKeyword	 check column columns constraint
syn keyword pgsqlKeyword	 databases distinct declare deallocate desc
syn keyword pgsqlKeyword	 deferrable diagnostics
syn keyword pgsqlKeyword	 explain elsif exclusion found exception except exit
syn keyword pgsqlKeyword	 force
syn keyword pgsqlKeyword	 group global get
syn keyword pgsqlKeyword	 having
syn keyword pgsqlKeyword	 immutable inherits inline intersect
syn keyword pgsqlKeyword	 leakproof lock local limit load loop listen lateral
syn keyword pgsqlKeyword	 notify next nowait
syn keyword pgsqlKeyword	 out open offset
syn keyword pgsqlKeyword	 password privilege
syn keyword pgsqlKeyword	 perform
syn keyword pgsqlKeyword	 replace references restrict returning
syn keyword pgsqlKeyword	 reassing return
syn keyword pgsqlKeyword	 strict sequences stable setof
syn keyword pgsqlKeyword	 truncate tranaction trigger trusted
syn keyword pgsqlKeyword	 unique unlisten
syn keyword pgsqlKeyword	 version volatile
syn keyword pgsqlKeyword	 window

" Section: Constants {{{2
" Constant values
syn keyword pgsqlConstant	 false true
" weakened to allow matching 'not null'
syn match   pgsqlConstant	 "\<null\>"
" }}}

" Section: Strings {{{2
" Strings (single- and double-quote)
syn region pgsqlIdentifier	 start=+"+  skip=+\\\\\|\\"+  end=+"+
syn region pgsqlIdentifier	 start=+U&"+  skip=+\\\\\|\\"+  end=+"+

syn region pgsqlString		 start=+'+  skip=+\\\\\|\\'+  end=+'+
syn region pgsqlString		 start=+U&'+  skip=+\\\\\|\\'+  end=+'+

syn match pgsqlString		 "\$\w*\$"
" }}}

" Section: Numbers {{{2
" Numbers and hexidecimal values
syn match pgsqlNumber		 "-\=\<[0-9]*\>"
syn match pgsqlNumber		 "-\=\<[0-9]*\.[0-9]*\>"
syn match pgsqlNumber		 "-\=\<[0-9]*e[+-]\=[0-9]*\>"
syn match pgsqlNumber		 "-\=\<[0-9]*\.[0-9]*e[+-]\=[0-9]*\>"
syn match pgsqlNumber		 "\<0x[abcdefABCDEF0-9]*\>"
" }}}

" Section: Comments {{{2
" Comments (c-style, sql-style)
syn region  pgsqlComment    start="/\*"  end="\*/" contains=pgsqlTodo,pgsqlComment
syn match   pgsqlComment    "--.*" contains=pgsqlTodo
syn sync    ccomment        pgsqlComment
syn keyword pgsqlTodo       todo note xxx warn warning contained
" }}}

" Section: Variables {{{2
"
" Special variables

syn keyword pgsqlVariable   old new
" Variables available in trigger definitions
syn keyword pgsqlVariable   tg_name tg_when tg_level tg_op tg_relid tg_relname
syn keyword pgsqlVariable   tg_table_name tg_table_schema tg_nargs tg_argv

" SQL-style variables
syn match pgsqlVariable		 "\$[0-9]\+"
syn match pgsqlLabel		 "<<[^>]\+>>"

" Is this a class of things or just a sort of an alien?
syn match pgsqlExtschema		 "@extschema@"

" Section: Column types {{{3
syn keyword pgsqlType        anyarray anyelement abstime anyenum
syn keyword pgsqlType        anynonarray aclitem
" Would like to have this as type, but even if it's a match it fails
" matching of the any() operator, which is more used.
" syn match   pgsqlType        "\<any\>"
syn keyword pgsqlType        bytea bigserial bool boolean bigint box
syn keyword pgsqlType        cidr cstring cid circle
syn keyword pgsqlType        date
syn keyword pgsqlType        enum
syn keyword pgsqlType        gtsvector
syn keyword pgsqlType        hstore
syn keyword pgsqlType        inet
syn keyword pgsqlType        internal int2vector int int2 int4 int8 integer
syn keyword pgsqlType        json jsonb
syn keyword pgsqlType        line lseg language_handler
syn keyword pgsqlType        macaddr money
syn keyword pgsqlType        numeric
syn keyword pgsqlType        opaque oidvector oid
syn keyword pgsqlType        polygon point path period
syn keyword pgsqlType        regclass real regtype refcursor regoperator
syn keyword pgsqlType        reltime record regproc regdictionary regoper
syn keyword pgsqlType        regprocedure regconfig
syn keyword pgsqlType        smgr smallint serial smallserial
syn keyword pgsqlType        serial2 serial4 serial8
syn keyword pgsqlType        tsquery tinterval
syn keyword pgsqlType        trigger tid text
syn keyword pgsqlType        tsvector txid_snapshot
syn keyword pgsqlType        unknown uuid
syn keyword pgsqlType        void varchar
syn keyword pgsqlType        xml xid
" %rowtype, %type PL/pgSQL constructs
syn match pgsqlType          "%\(row\)\?type\>"
" this should actually be the end of a region
syn match pgsqlType          "\<with\(out\)\?\_s\+time\_s\+zone\>"

" Section: Variable types {{{3
syn match  pgsqlType		 "\<float\>"
syn region pgsqlType		 start="\<float\_s*(" end=")" contains=pgsqlNumber,pgsqlVariable
syn match  pgsqlType		 "\<double\_s\+precision\>"
syn region pgsqlType		 start="\<double\_s\+precision\_s*(" end=")" contains=pgsqlNumber,pgsqlVariable
syn match  pgsqlType		 "\<numeric\>"
syn region pgsqlType		 start="\<numeric\_s*(" end=")" contains=pgsqlNumber,pgsqlVariable
syn match  pgsqlType		 "\<decimal\>"
syn region pgsqlType		 start="\<decimal\_s*(" end=")" contains=pgsqlNumber,pgsqlVariable
syn match  pgsqlType		 "\<time\(stamp\(tz\)\?\)\?\>"
syn region pgsqlType		 start="\<time\(stamp\(tz\)\?\)\?\_s*(" end=")" contains=pgsqlNumber,pgsqlVariable
syn match  pgsqlType		 "\<interval\>"
syn region pgsqlType		 start="\<interval\_s*(" end=")" contains=pgsqlNumber,pgsqlVariable
syn match  pgsqlType		 "\<interval\_s\+\(year\|month\|day\|hour\|minute\|second\)\>"
syn match  pgsqlType		 "\<interval\_s\+year\_s\+to\_s\+month\>"
syn match  pgsqlType		 "\<interval\_s\+day\_s\+to\_s\+\(hour\|minute\|second\)\>"
syn match  pgsqlType		 "\<interval\_s\+hour\_s\+to\_s\+\(minute\|second\)\>"
syn match  pgsqlType		 "\<interval\_s\+minute\_s\+to\_s\+second\>"
syn region pgsqlType		 start="\<interval\_s\+\(\(day\|hour\|minute\)\_s\+to\_s\+\)\?second\_s*(" end=")" contains=pgsqlNumber,pgsqlVariable
syn match  pgsqlType		 "\<char\>"
syn region pgsqlType		 start="\<char\_s*(" end=")" contains=pgsqlNumber,pgsqlVariable
syn match  pgsqlType		 "\<character\>"
syn region pgsqlType		 start="\<character\_s*(" end=")" contains=pgsqlNumber,pgsqlVariable
syn match  pgsqlType		 "\<varchar\>"
syn region pgsqlType		 start="\<varchar\_s*(" end=")" contains=pgsqlNumber,pgsqlVariable
syn match  pgsqlType		 "\<character\_s\+varying\>"
syn region pgsqlType		 start="\<character\_s\+varying\_s*(" end=")" contains=pgsqlNumber,pgsqlVariable
syn match  pgsqlType		 "\<bit\>"
syn region pgsqlType		 start="\<bit\_s*(" end=")" contains=pgsqlNumber,pgsqlVariable
syn match  pgsqlType		 "\<varbit\>"
syn region pgsqlType		 start="\<varbit\_s*(" end=")" contains=pgsqlNumber,pgsqlVariable
syn match  pgsqlType		 "\<bit\_s\+varying\>"
syn region pgsqlType		 start="\<bit\_s\+varying\_s*(" end=")" contains=pgsqlNumber,pgsqlVariable
" }}}

" Section: Operators {{{1
" Logical, string and  numeric operators
" TODO: terms contained within the function are not keywords! --Ryan Delaney 2014-02-06T14:11-0800 OpenGPG: 0D98863B4E1D07B6
" note: the 'in' operator is defined above, before lockmodes
syn keyword pgsqlOperator	 between and is like regexp rlike
syn match   pgsqlOperator	 "\<not\>"
syn match   pgsqlOperator	 "\<or\>"
syn region pgsqlOperator	 start="isnull\_s*(" end=")" contains=ALL
syn region pgsqlOperator	 start="coalesce\_s*(" end=")" contains=ALL
syn region pgsqlOperator	 start="interval\_s*(" end=")" contains=ALL
syn region pgsqlOperator	 start="in\_s*(" end=")" contains=ALL
syn region pgsqlOperator	 start="any\_s*(" end=")" contains=ALL
syn region pgsqlOperator	 start="some\_s*(" end=")" contains=ALL
syn region pgsqlOperator	 start="all\_s*(" end=")" contains=ALL
syn region pgsqlOperator	 start="exists\_s*(" end=")" contains=ALL
syn region pgsqlOperator	 start="array\_s*\[" end="\]" contains=ALL

" Let's consider this an operator, not operator + constant
syn match   pgsqlKeyword	 "\<not\_s\+null\>"
" }}}

" Section: psql special stuff {{{1
syn region pgsqlCopy    start="\<copy\([^;]\|\n\)\+from\_s\+stdin\([^;]\|\n\)*;" end="\\\."
" TODO: the content would be nice "Normal", not "Special"
syn region pgsqlBackslash	 start="^\\" end="$"
" }}}

" Section: Functions {{{1
" Control flow functions {{{2
syn keyword pgsqlFlow		 case when then else end
syn region pgsqlFlow		 start="ifnull("   end=")"  contains=ALL
syn region pgsqlFlow		 start="nullif("   end=")"  contains=ALL
" }}}

" General Functions {{{2
syn region pgsqlFunction	start="abbrev'(" end=")" contains=ALL
syn region pgsqlFunction	start="abs'(" end=")" contains=ALL
syn region pgsqlFunction	start="abstime'(" end=")" contains=ALL
syn region pgsqlFunction	start="abstimeeq'(" end=")" contains=ALL
syn region pgsqlFunction	start="abstimege'(" end=")" contains=ALL
syn region pgsqlFunction	start="abstimegt'(" end=")" contains=ALL
syn region pgsqlFunction	start="abstimein'(" end=")" contains=ALL
syn region pgsqlFunction	start="abstimele'(" end=")" contains=ALL
syn region pgsqlFunction	start="abstimelt'(" end=")" contains=ALL
syn region pgsqlFunction	start="abstimene'(" end=")" contains=ALL
syn region pgsqlFunction	start="abstimeout'(" end=")" contains=ALL
syn region pgsqlFunction	start="abstimerecv'(" end=")" contains=ALL
syn region pgsqlFunction	start="abstimesend'(" end=")" contains=ALL
syn region pgsqlFunction	start="aclcontains'(" end=")" contains=ALL
syn region pgsqlFunction	start="aclexplode'(" end=")" contains=ALL
syn region pgsqlFunction	start="aclinsert'(" end=")" contains=ALL
syn region pgsqlFunction	start="aclitemeq'(" end=")" contains=ALL
syn region pgsqlFunction	start="aclitemin'(" end=")" contains=ALL
syn region pgsqlFunction	start="aclitemout'(" end=")" contains=ALL
syn region pgsqlFunction	start="aclremove'(" end=")" contains=ALL
syn region pgsqlFunction	start="acos'(" end=")" contains=ALL
syn region pgsqlFunction	start="adjacent'(" end=")" contains=ALL
syn region pgsqlFunction	start="after'(" end=")" contains=ALL
syn region pgsqlFunction	start="age'(" end=")" contains=ALL
syn region pgsqlFunction	start="anyarray_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="anyarray_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="anyarray_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="anyarray_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="anyelement_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="anyelement_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="anyenum_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="anyenum_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="any_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="anynonarray_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="anynonarray_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="any_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="anytextcat'(" end=")" contains=ALL
syn region pgsqlFunction	start="area'(" end=")" contains=ALL
syn region pgsqlFunction	start="areajoinsel'(" end=")" contains=ALL
syn region pgsqlFunction	start="areasel'(" end=")" contains=ALL
syn region pgsqlFunction	start="array_agg'(" end=")" contains=ALL
syn region pgsqlFunction	start="array_agg_finalfn'(" end=")" contains=ALL
syn region pgsqlFunction	start="array_agg_transfn'(" end=")" contains=ALL
syn region pgsqlFunction	start="array_append'(" end=")" contains=ALL
syn region pgsqlFunction	start="array_cat'(" end=")" contains=ALL
syn region pgsqlFunction	start="arraycontained'(" end=")" contains=ALL
syn region pgsqlFunction	start="arraycontains'(" end=")" contains=ALL
syn region pgsqlFunction	start="array_dims'(" end=")" contains=ALL
syn region pgsqlFunction	start="array_eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="array_fill'(" end=")" contains=ALL
syn region pgsqlFunction	start="array_ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="array_gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="array_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="array_larger'(" end=")" contains=ALL
syn region pgsqlFunction	start="array_le'(" end=")" contains=ALL
syn region pgsqlFunction	start="array_length'(" end=")" contains=ALL
syn region pgsqlFunction	start="array_lower'(" end=")" contains=ALL
syn region pgsqlFunction	start="array_lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="array_ndims'(" end=")" contains=ALL
syn region pgsqlFunction	start="array_ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="array_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="arrayoverlap'(" end=")" contains=ALL
syn region pgsqlFunction	start="array_prepend'(" end=")" contains=ALL
syn region pgsqlFunction	start="array_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="array_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="array_smaller'(" end=")" contains=ALL
syn region pgsqlFunction	start="array_to_string'(" end=")" contains=ALL
syn region pgsqlFunction	start="array_unique'(" end=")" contains=ALL
syn region pgsqlFunction	start="array_upper'(" end=")" contains=ALL
syn region pgsqlFunction	start="ascii'(" end=")" contains=ALL
syn region pgsqlFunction	start="ascii_to_mic'(" end=")" contains=ALL
syn region pgsqlFunction	start="ascii_to_utf8'(" end=")" contains=ALL
syn region pgsqlFunction	start="asin'(" end=")" contains=ALL
syn region pgsqlFunction	start="atan2'(" end=")" contains=ALL
syn region pgsqlFunction	start="atan'(" end=")" contains=ALL
syn region pgsqlFunction	start="avg'(" end=")" contains=ALL
syn region pgsqlFunction	start="before'(" end=")" contains=ALL
syn region pgsqlFunction	start="big5_to_euc_tw'(" end=")" contains=ALL
syn region pgsqlFunction	start="big5_to_mic'(" end=")" contains=ALL
syn region pgsqlFunction	start="big5_to_utf8'(" end=")" contains=ALL
syn region pgsqlFunction	start="bit_and'(" end=")" contains=ALL
syn region pgsqlFunction	start="bitand'(" end=")" contains=ALL
syn region pgsqlFunction	start="bitcat'(" end=")" contains=ALL
syn region pgsqlFunction	start="bitcmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="bit'(" end=")" contains=ALL
syn region pgsqlFunction	start="biteq'(" end=")" contains=ALL
syn region pgsqlFunction	start="bitge'(" end=")" contains=ALL
syn region pgsqlFunction	start="bitgt'(" end=")" contains=ALL
syn region pgsqlFunction	start="bit_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="bitle'(" end=")" contains=ALL
syn region pgsqlFunction	start="bit_length'(" end=")" contains=ALL
syn region pgsqlFunction	start="bitlt'(" end=")" contains=ALL
syn region pgsqlFunction	start="bitne'(" end=")" contains=ALL
syn region pgsqlFunction	start="bitnot'(" end=")" contains=ALL
syn region pgsqlFunction	start="bit_or'(" end=")" contains=ALL
syn region pgsqlFunction	start="bitor'(" end=")" contains=ALL
syn region pgsqlFunction	start="bit_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="bit_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="bit_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="bitshiftleft'(" end=")" contains=ALL
syn region pgsqlFunction	start="bitshiftright'(" end=")" contains=ALL
syn region pgsqlFunction	start="bittypmodin'(" end=")" contains=ALL
syn region pgsqlFunction	start="bittypmodout'(" end=")" contains=ALL
syn region pgsqlFunction	start="bitxor'(" end=")" contains=ALL
syn region pgsqlFunction	start="bool_and'(" end=")" contains=ALL
syn region pgsqlFunction	start="booland_statefunc'(" end=")" contains=ALL
syn region pgsqlFunction	start="bool'(" end=")" contains=ALL
syn region pgsqlFunction	start="booleq'(" end=")" contains=ALL
syn region pgsqlFunction	start="boolge'(" end=")" contains=ALL
syn region pgsqlFunction	start="boolgt'(" end=")" contains=ALL
syn region pgsqlFunction	start="boolin'(" end=")" contains=ALL
syn region pgsqlFunction	start="boolle'(" end=")" contains=ALL
syn region pgsqlFunction	start="boollt'(" end=")" contains=ALL
syn region pgsqlFunction	start="boolne'(" end=")" contains=ALL
syn region pgsqlFunction	start="bool_or'(" end=")" contains=ALL
syn region pgsqlFunction	start="boolor_statefunc'(" end=")" contains=ALL
syn region pgsqlFunction	start="boolout'(" end=")" contains=ALL
syn region pgsqlFunction	start="boolrecv'(" end=")" contains=ALL
syn region pgsqlFunction	start="boolsend'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_above'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_above_eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_add'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_below'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_below_eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_center'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_contained'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_contain'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_contain_pt'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_distance'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_div'(" end=")" contains=ALL
syn region pgsqlFunction	start="box'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_intersect'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_le'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_left'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_mul'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_overabove'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_overbelow'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_overlap'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_overleft'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_overright'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_right'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_same'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="box_sub'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpcharcmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpchar'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpchareq'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpcharge'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpchargt'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpchariclike'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpcharicnlike'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpcharicregexeq'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpcharicregexne'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpcharin'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpchar_larger'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpcharle'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpcharlike'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpcharlt'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpcharne'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpcharnlike'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpcharout'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpchar_pattern_ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpchar_pattern_gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpchar_pattern_le'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpchar_pattern_lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpcharrecv'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpcharregexeq'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpcharregexne'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpcharsend'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpchar_smaller'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpchartypmodin'(" end=")" contains=ALL
syn region pgsqlFunction	start="bpchartypmodout'(" end=")" contains=ALL
syn region pgsqlFunction	start="broadcast'(" end=")" contains=ALL
syn region pgsqlFunction	start="btabstimecmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="btarraycmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="btbeginscan'(" end=")" contains=ALL
syn region pgsqlFunction	start="btboolcmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="btbpchar_pattern_cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="btbuild'(" end=")" contains=ALL
syn region pgsqlFunction	start="btbulkdelete'(" end=")" contains=ALL
syn region pgsqlFunction	start="btcharcmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="btcostestimate'(" end=")" contains=ALL
syn region pgsqlFunction	start="btendscan'(" end=")" contains=ALL
syn region pgsqlFunction	start="btfloat48cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="btfloat4cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="btfloat84cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="btfloat8cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="btgetbitmap'(" end=")" contains=ALL
syn region pgsqlFunction	start="btgettuple'(" end=")" contains=ALL
syn region pgsqlFunction	start="btinsert'(" end=")" contains=ALL
syn region pgsqlFunction	start="btint24cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="btint28cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="btint2cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="btint42cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="btint48cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="btint4cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="btint82cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="btint84cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="btint8cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="btmarkpos'(" end=")" contains=ALL
syn region pgsqlFunction	start="btnamecmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="btoidcmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="btoidvectorcmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="btoptions'(" end=")" contains=ALL
syn region pgsqlFunction	start="btrecordcmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="btreltimecmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="btrescan'(" end=")" contains=ALL
syn region pgsqlFunction	start="btrestrpos'(" end=")" contains=ALL
syn region pgsqlFunction	start="btrim'(" end=")" contains=ALL
syn region pgsqlFunction	start="bttextcmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="bttext_pattern_cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="bttidcmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="bttintervalcmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="btvacuumcleanup'(" end=")" contains=ALL
syn region pgsqlFunction	start="byteacat'(" end=")" contains=ALL
syn region pgsqlFunction	start="byteacmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="byteaeq'(" end=")" contains=ALL
syn region pgsqlFunction	start="byteage'(" end=")" contains=ALL
syn region pgsqlFunction	start="byteagt'(" end=")" contains=ALL
syn region pgsqlFunction	start="byteain'(" end=")" contains=ALL
syn region pgsqlFunction	start="byteale'(" end=")" contains=ALL
syn region pgsqlFunction	start="bytealike'(" end=")" contains=ALL
syn region pgsqlFunction	start="bytealt'(" end=")" contains=ALL
syn region pgsqlFunction	start="byteane'(" end=")" contains=ALL
syn region pgsqlFunction	start="byteanlike'(" end=")" contains=ALL
syn region pgsqlFunction	start="byteaout'(" end=")" contains=ALL
syn region pgsqlFunction	start="bytearecv'(" end=")" contains=ALL
syn region pgsqlFunction	start="byteasend'(" end=")" contains=ALL
syn region pgsqlFunction	start="cash_cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="cash_div_flt4'(" end=")" contains=ALL
syn region pgsqlFunction	start="cash_div_flt8'(" end=")" contains=ALL
syn region pgsqlFunction	start="cash_div_int2'(" end=")" contains=ALL
syn region pgsqlFunction	start="cash_div_int4'(" end=")" contains=ALL
syn region pgsqlFunction	start="cash_eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="cash_ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="cash_gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="cash_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="cashlarger'(" end=")" contains=ALL
syn region pgsqlFunction	start="cash_le'(" end=")" contains=ALL
syn region pgsqlFunction	start="cash_lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="cash_mi'(" end=")" contains=ALL
syn region pgsqlFunction	start="cash_mul_flt4'(" end=")" contains=ALL
syn region pgsqlFunction	start="cash_mul_flt8'(" end=")" contains=ALL
syn region pgsqlFunction	start="cash_mul_int2'(" end=")" contains=ALL
syn region pgsqlFunction	start="cash_mul_int4'(" end=")" contains=ALL
syn region pgsqlFunction	start="cash_ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="cash_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="cash_pl'(" end=")" contains=ALL
syn region pgsqlFunction	start="cash_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="cash_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="cashsmaller'(" end=")" contains=ALL
syn region pgsqlFunction	start="cash_words'(" end=")" contains=ALL
syn region pgsqlFunction	start="cbrt'(" end=")" contains=ALL
syn region pgsqlFunction	start="ceil'(" end=")" contains=ALL
syn region pgsqlFunction	start="ceiling'(" end=")" contains=ALL
syn region pgsqlFunction	start="center'(" end=")" contains=ALL
syn region pgsqlFunction	start="character_length'(" end=")" contains=ALL
syn region pgsqlFunction	start="char'(" end=")" contains=ALL
syn region pgsqlFunction	start="chareq'(" end=")" contains=ALL
syn region pgsqlFunction	start="charge'(" end=")" contains=ALL
syn region pgsqlFunction	start="chargt'(" end=")" contains=ALL
syn region pgsqlFunction	start="charin'(" end=")" contains=ALL
syn region pgsqlFunction	start="charle'(" end=")" contains=ALL
syn region pgsqlFunction	start="char_length'(" end=")" contains=ALL
syn region pgsqlFunction	start="charlt'(" end=")" contains=ALL
syn region pgsqlFunction	start="charne'(" end=")" contains=ALL
syn region pgsqlFunction	start="charout'(" end=")" contains=ALL
syn region pgsqlFunction	start="charrecv'(" end=")" contains=ALL
syn region pgsqlFunction	start="charsend'(" end=")" contains=ALL
syn region pgsqlFunction	start="chr'(" end=")" contains=ALL
syn region pgsqlFunction	start="cideq'(" end=")" contains=ALL
syn region pgsqlFunction	start="cidin'(" end=")" contains=ALL
syn region pgsqlFunction	start="cidout'(" end=")" contains=ALL
syn region pgsqlFunction	start="cidrecv'(" end=")" contains=ALL
syn region pgsqlFunction	start="cidr'(" end=")" contains=ALL
syn region pgsqlFunction	start="cidr_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="cidr_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="cidr_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="cidr_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="cidsend'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_above'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_add_pt'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_below'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_center'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_contained'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_contain'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_contain_pt'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_distance'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_div_pt'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_le'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_left'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_mul_pt'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_overabove'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_overbelow'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_overlap'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_overleft'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_overright'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_right'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_same'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="circle_sub_pt'(" end=")" contains=ALL
syn region pgsqlFunction	start="clock_timestamp'(" end=")" contains=ALL
syn region pgsqlFunction	start="close_lb'(" end=")" contains=ALL
syn region pgsqlFunction	start="close_lseg'(" end=")" contains=ALL
syn region pgsqlFunction	start="close_ls'(" end=")" contains=ALL
syn region pgsqlFunction	start="close_pb'(" end=")" contains=ALL
syn region pgsqlFunction	start="close_pl'(" end=")" contains=ALL
syn region pgsqlFunction	start="close_ps'(" end=")" contains=ALL
syn region pgsqlFunction	start="close_sb'(" end=")" contains=ALL
syn region pgsqlFunction	start="close_sl'(" end=")" contains=ALL
syn region pgsqlFunction	start="col_description'(" end=")" contains=ALL
syn region pgsqlFunction	start="contained_by'(" end=")" contains=ALL
syn region pgsqlFunction	start="contains'(" end=")" contains=ALL
syn region pgsqlFunction	start="contjoinsel'(" end=")" contains=ALL
syn region pgsqlFunction	start="contsel'(" end=")" contains=ALL
syn region pgsqlFunction	start="convert'(" end=")" contains=ALL
syn region pgsqlFunction	start="convert_from'(" end=")" contains=ALL
syn region pgsqlFunction	start="convert_to'(" end=")" contains=ALL
syn region pgsqlFunction	start="corr'(" end=")" contains=ALL
syn region pgsqlFunction	start="cos'(" end=")" contains=ALL
syn region pgsqlFunction	start="cot'(" end=")" contains=ALL
syn region pgsqlFunction	start="count'(" end=")" contains=ALL
syn region pgsqlFunction	start="covar_pop'(" end=")" contains=ALL
syn region pgsqlFunction	start="covar_samp'(" end=")" contains=ALL
syn region pgsqlFunction	start="cstring_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="cstring_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="cstring_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="cstring_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="cume_dist'(" end=")" contains=ALL
syn region pgsqlFunction	start="current_database'(" end=")" contains=ALL
syn region pgsqlFunction	start="current_query'(" end=")" contains=ALL
syn region pgsqlFunction	start="current_schema'(" end=")" contains=ALL
syn region pgsqlFunction	start="current_schemas'(" end=")" contains=ALL
syn region pgsqlFunction	start="current_setting'(" end=")" contains=ALL
syn region pgsqlFunction	start="current_user'(" end=")" contains=ALL
syn region pgsqlFunction	start="currtid2'(" end=")" contains=ALL
syn region pgsqlFunction	start="currtid'(" end=")" contains=ALL
syn region pgsqlFunction	start="currval'(" end=")" contains=ALL
syn region pgsqlFunction	start="cursor_to_xml'(" end=")" contains=ALL
syn region pgsqlFunction	start="cursor_to_xmlschema'(" end=")" contains=ALL
syn region pgsqlFunction	start="database_to_xml_and_xmlschema'(" end=")" contains=ALL
syn region pgsqlFunction	start="database_to_xml'(" end=")" contains=ALL
syn region pgsqlFunction	start="database_to_xmlschema'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_cmp_timestamp'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_cmp_timestamptz'(" end=")" contains=ALL
syn region pgsqlFunction	start="date'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_eq_timestamp'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_eq_timestamptz'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_ge_timestamp'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_ge_timestamptz'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_gt_timestamp'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_gt_timestamptz'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_larger'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_le'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_le_timestamp'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_le_timestamptz'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_lt_timestamp'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_lt_timestamptz'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_mi'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_mii'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_mi_interval'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_ne_timestamp'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_ne_timestamptz'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_part'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_pli'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_pl_interval'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_smaller'(" end=")" contains=ALL
syn region pgsqlFunction	start="datetime_pl'(" end=")" contains=ALL
syn region pgsqlFunction	start="datetimetz_pl'(" end=")" contains=ALL
syn region pgsqlFunction	start="date_trunc'(" end=")" contains=ALL
syn region pgsqlFunction	start="dcbrt'(" end=")" contains=ALL
syn region pgsqlFunction	start="decode'(" end=")" contains=ALL
syn region pgsqlFunction	start="degrees'(" end=")" contains=ALL
syn region pgsqlFunction	start="dense_rank'(" end=")" contains=ALL
syn region pgsqlFunction	start="dexp'(" end=")" contains=ALL
syn region pgsqlFunction	start="diagonal'(" end=")" contains=ALL
syn region pgsqlFunction	start="diameter'(" end=")" contains=ALL
syn region pgsqlFunction	start="dispell_init'(" end=")" contains=ALL
syn region pgsqlFunction	start="dispell_lexize'(" end=")" contains=ALL
syn region pgsqlFunction	start="dist_cpoly'(" end=")" contains=ALL
syn region pgsqlFunction	start="dist_lb'(" end=")" contains=ALL
syn region pgsqlFunction	start="dist_pb'(" end=")" contains=ALL
syn region pgsqlFunction	start="dist_pc'(" end=")" contains=ALL
syn region pgsqlFunction	start="dist_pl'(" end=")" contains=ALL
syn region pgsqlFunction	start="dist_ppath'(" end=")" contains=ALL
syn region pgsqlFunction	start="dist_ps'(" end=")" contains=ALL
syn region pgsqlFunction	start="dist_sb'(" end=")" contains=ALL
syn region pgsqlFunction	start="dist_sl'(" end=")" contains=ALL
syn region pgsqlFunction	start="div'(" end=")" contains=ALL
syn region pgsqlFunction	start="dlog10'(" end=")" contains=ALL
syn region pgsqlFunction	start="dlog1'(" end=")" contains=ALL
syn region pgsqlFunction	start="domain_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="domain_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="dpow'(" end=")" contains=ALL
syn region pgsqlFunction	start="dround'(" end=")" contains=ALL
syn region pgsqlFunction	start="dsimple_init'(" end=")" contains=ALL
syn region pgsqlFunction	start="dsimple_lexize'(" end=")" contains=ALL
syn region pgsqlFunction	start="dsnowball_init'(" end=")" contains=ALL
syn region pgsqlFunction	start="dsnowball_lexize'(" end=")" contains=ALL
syn region pgsqlFunction	start="dsqrt'(" end=")" contains=ALL
syn region pgsqlFunction	start="dsynonym_init'(" end=")" contains=ALL
syn region pgsqlFunction	start="dsynonym_lexize'(" end=")" contains=ALL
syn region pgsqlFunction	start="dtrunc'(" end=")" contains=ALL
syn region pgsqlFunction	start="empty_period'(" end=")" contains=ALL
syn region pgsqlFunction	start="encode'(" end=")" contains=ALL
syn region pgsqlFunction	start="enum_cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="enum_eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="enum_first'(" end=")" contains=ALL
syn region pgsqlFunction	start="enum_ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="enum_gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="enum_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="enum_larger'(" end=")" contains=ALL
syn region pgsqlFunction	start="enum_last'(" end=")" contains=ALL
syn region pgsqlFunction	start="enum_le'(" end=")" contains=ALL
syn region pgsqlFunction	start="enum_lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="enum_ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="enum_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="enum_range'(" end=")" contains=ALL
syn region pgsqlFunction	start="enum_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="enum_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="enum_smaller'(" end=")" contains=ALL
syn region pgsqlFunction	start="eqjoinsel'(" end=")" contains=ALL
syn region pgsqlFunction	start="eqsel'(" end=")" contains=ALL
syn region pgsqlFunction	start="equals'(" end=")" contains=ALL
syn region pgsqlFunction	start="euc_cn_to_mic'(" end=")" contains=ALL
syn region pgsqlFunction	start="euc_cn_to_utf8'(" end=")" contains=ALL
syn region pgsqlFunction	start="euc_jis_2004_to_shift_jis_2004'(" end=")" contains=ALL
syn region pgsqlFunction	start="euc_jis_2004_to_utf8'(" end=")" contains=ALL
syn region pgsqlFunction	start="euc_jp_to_mic'(" end=")" contains=ALL
syn region pgsqlFunction	start="euc_jp_to_sjis'(" end=")" contains=ALL
syn region pgsqlFunction	start="euc_jp_to_utf8'(" end=")" contains=ALL
syn region pgsqlFunction	start="euc_kr_to_mic'(" end=")" contains=ALL
syn region pgsqlFunction	start="euc_kr_to_utf8'(" end=")" contains=ALL
syn region pgsqlFunction	start="euc_tw_to_big5'(" end=")" contains=ALL
syn region pgsqlFunction	start="euc_tw_to_mic'(" end=")" contains=ALL
syn region pgsqlFunction	start="euc_tw_to_utf8'(" end=")" contains=ALL
syn region pgsqlFunction	start="every'(" end=")" contains=ALL
syn region pgsqlFunction	start="exp'(" end=")" contains=ALL
syn region pgsqlFunction	start="factorial'(" end=")" contains=ALL
syn region pgsqlFunction	start="family'(" end=")" contains=ALL
syn region pgsqlFunction	start="first'(" end=")" contains=ALL
syn region pgsqlFunction	start="first_value'(" end=")" contains=ALL
syn region pgsqlFunction	start="float48div'(" end=")" contains=ALL
syn region pgsqlFunction	start="float48eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="float48ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="float48gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="float48le'(" end=")" contains=ALL
syn region pgsqlFunction	start="float48lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="float48mi'(" end=")" contains=ALL
syn region pgsqlFunction	start="float48mul'(" end=")" contains=ALL
syn region pgsqlFunction	start="float48ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="float48pl'(" end=")" contains=ALL
syn region pgsqlFunction	start="float4abs'(" end=")" contains=ALL
syn region pgsqlFunction	start="float4_accum'(" end=")" contains=ALL
syn region pgsqlFunction	start="float4div'(" end=")" contains=ALL
syn region pgsqlFunction	start="float4'(" end=")" contains=ALL
syn region pgsqlFunction	start="float4eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="float4ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="float4gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="float4in'(" end=")" contains=ALL
syn region pgsqlFunction	start="float4larger'(" end=")" contains=ALL
syn region pgsqlFunction	start="float4le'(" end=")" contains=ALL
syn region pgsqlFunction	start="float4lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="float4mi'(" end=")" contains=ALL
syn region pgsqlFunction	start="float4mul'(" end=")" contains=ALL
syn region pgsqlFunction	start="float4ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="float4out'(" end=")" contains=ALL
syn region pgsqlFunction	start="float4pl'(" end=")" contains=ALL
syn region pgsqlFunction	start="float4recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="float4send'(" end=")" contains=ALL
syn region pgsqlFunction	start="float4smaller'(" end=")" contains=ALL
syn region pgsqlFunction	start="float4um'(" end=")" contains=ALL
syn region pgsqlFunction	start="float4up'(" end=")" contains=ALL
syn region pgsqlFunction	start="float84div'(" end=")" contains=ALL
syn region pgsqlFunction	start="float84eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="float84ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="float84gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="float84le'(" end=")" contains=ALL
syn region pgsqlFunction	start="float84lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="float84mi'(" end=")" contains=ALL
syn region pgsqlFunction	start="float84mul'(" end=")" contains=ALL
syn region pgsqlFunction	start="float84ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="float84pl'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8abs'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8_accum'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8_avg'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8_corr'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8_covar_pop'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8_covar_samp'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8div'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8in'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8larger'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8le'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8mi'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8mul'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8out'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8pl'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8_regr_accum'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8_regr_avgx'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8_regr_avgy'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8_regr_intercept'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8_regr_r2'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8_regr_slope'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8_regr_sxx'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8_regr_sxy'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8_regr_syy'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8send'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8smaller'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8_stddev_pop'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8_stddev_samp'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8um'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8up'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8_var_pop'(" end=")" contains=ALL
syn region pgsqlFunction	start="float8_var_samp'(" end=")" contains=ALL
syn region pgsqlFunction	start="floor'(" end=")" contains=ALL
syn region pgsqlFunction	start="flt4_mul_cash'(" end=")" contains=ALL
syn region pgsqlFunction	start="flt8_mul_cash'(" end=")" contains=ALL
syn region pgsqlFunction	start="fmgr_c_validator'(" end=")" contains=ALL
syn region pgsqlFunction	start="fmgr_internal_validator'(" end=")" contains=ALL
syn region pgsqlFunction	start="fmgr_sql_validator'(" end=")" contains=ALL
syn region pgsqlFunction	start="format_type'(" end=")" contains=ALL
syn region pgsqlFunction	start="gb18030_to_utf8'(" end=")" contains=ALL
syn region pgsqlFunction	start="gbk_to_utf8'(" end=")" contains=ALL
syn region pgsqlFunction	start="generate_series'(" end=")" contains=ALL
syn region pgsqlFunction	start="generate_subscripts'(" end=")" contains=ALL
syn region pgsqlFunction	start="get_bit'(" end=")" contains=ALL
syn region pgsqlFunction	start="get_byte'(" end=")" contains=ALL
syn region pgsqlFunction	start="get_current_ts_config'(" end=")" contains=ALL
syn region pgsqlFunction	start="getdatabaseencoding'(" end=")" contains=ALL
syn region pgsqlFunction	start="getpgusername'(" end=")" contains=ALL
syn region pgsqlFunction	start="ginarrayconsistent'(" end=")" contains=ALL
syn region pgsqlFunction	start="ginarrayextract'(" end=")" contains=ALL
syn region pgsqlFunction	start="ginbeginscan'(" end=")" contains=ALL
syn region pgsqlFunction	start="ginbuild'(" end=")" contains=ALL
syn region pgsqlFunction	start="ginbulkdelete'(" end=")" contains=ALL
syn region pgsqlFunction	start="gin_cmp_prefix'(" end=")" contains=ALL
syn region pgsqlFunction	start="gin_cmp_tslexeme'(" end=")" contains=ALL
syn region pgsqlFunction	start="gincostestimate'(" end=")" contains=ALL
syn region pgsqlFunction	start="ginendscan'(" end=")" contains=ALL
syn region pgsqlFunction	start="gin_extract_tsquery'(" end=")" contains=ALL
syn region pgsqlFunction	start="gin_extract_tsvector'(" end=")" contains=ALL
syn region pgsqlFunction	start="gingetbitmap'(" end=")" contains=ALL
syn region pgsqlFunction	start="gininsert'(" end=")" contains=ALL
syn region pgsqlFunction	start="ginmarkpos'(" end=")" contains=ALL
syn region pgsqlFunction	start="ginoptions'(" end=")" contains=ALL
syn region pgsqlFunction	start="ginqueryarrayextract'(" end=")" contains=ALL
syn region pgsqlFunction	start="ginrescan'(" end=")" contains=ALL
syn region pgsqlFunction	start="ginrestrpos'(" end=")" contains=ALL
syn region pgsqlFunction	start="gin_tsquery_consistent'(" end=")" contains=ALL
syn region pgsqlFunction	start="ginvacuumcleanup'(" end=")" contains=ALL
syn region pgsqlFunction	start="gistbeginscan'(" end=")" contains=ALL
syn region pgsqlFunction	start="gist_box_compress'(" end=")" contains=ALL
syn region pgsqlFunction	start="gist_box_consistent'(" end=")" contains=ALL
syn region pgsqlFunction	start="gist_box_decompress'(" end=")" contains=ALL
syn region pgsqlFunction	start="gist_box_penalty'(" end=")" contains=ALL
syn region pgsqlFunction	start="gist_box_picksplit'(" end=")" contains=ALL
syn region pgsqlFunction	start="gist_box_same'(" end=")" contains=ALL
syn region pgsqlFunction	start="gist_box_union'(" end=")" contains=ALL
syn region pgsqlFunction	start="gistbuild'(" end=")" contains=ALL
syn region pgsqlFunction	start="gistbulkdelete'(" end=")" contains=ALL
syn region pgsqlFunction	start="gist_circle_compress'(" end=")" contains=ALL
syn region pgsqlFunction	start="gist_circle_consistent'(" end=")" contains=ALL
syn region pgsqlFunction	start="gistcostestimate'(" end=")" contains=ALL
syn region pgsqlFunction	start="gistendscan'(" end=")" contains=ALL
syn region pgsqlFunction	start="gistgetbitmap'(" end=")" contains=ALL
syn region pgsqlFunction	start="gistgettuple'(" end=")" contains=ALL
syn region pgsqlFunction	start="gistinsert'(" end=")" contains=ALL
syn region pgsqlFunction	start="gistmarkpos'(" end=")" contains=ALL
syn region pgsqlFunction	start="gistoptions'(" end=")" contains=ALL
syn region pgsqlFunction	start="gist_period_compress'(" end=")" contains=ALL
syn region pgsqlFunction	start="gist_period_consistent'(" end=")" contains=ALL
syn region pgsqlFunction	start="gist_period_decompress'(" end=")" contains=ALL
syn region pgsqlFunction	start="gist_period_penalty'(" end=")" contains=ALL
syn region pgsqlFunction	start="gist_period_picksplit'(" end=")" contains=ALL
syn region pgsqlFunction	start="gist_period_same'(" end=")" contains=ALL
syn region pgsqlFunction	start="gist_period_union'(" end=")" contains=ALL
syn region pgsqlFunction	start="gist_point_compress'(" end=")" contains=ALL
syn region pgsqlFunction	start="gist_point_consistent'(" end=")" contains=ALL
syn region pgsqlFunction	start="gist_poly_compress'(" end=")" contains=ALL
syn region pgsqlFunction	start="gist_poly_consistent'(" end=")" contains=ALL
syn region pgsqlFunction	start="gistrescan'(" end=")" contains=ALL
syn region pgsqlFunction	start="gistrestrpos'(" end=")" contains=ALL
syn region pgsqlFunction	start="gistvacuumcleanup'(" end=")" contains=ALL
syn region pgsqlFunction	start="gtsquery_compress'(" end=")" contains=ALL
syn region pgsqlFunction	start="gtsquery_consistent'(" end=")" contains=ALL
syn region pgsqlFunction	start="gtsquery_decompress'(" end=")" contains=ALL
syn region pgsqlFunction	start="gtsquery_penalty'(" end=")" contains=ALL
syn region pgsqlFunction	start="gtsquery_picksplit'(" end=")" contains=ALL
syn region pgsqlFunction	start="gtsquery_same'(" end=")" contains=ALL
syn region pgsqlFunction	start="gtsquery_union'(" end=")" contains=ALL
syn region pgsqlFunction	start="gtsvector_compress'(" end=")" contains=ALL
syn region pgsqlFunction	start="gtsvector_consistent'(" end=")" contains=ALL
syn region pgsqlFunction	start="gtsvector_decompress'(" end=")" contains=ALL
syn region pgsqlFunction	start="gtsvectorin'(" end=")" contains=ALL
syn region pgsqlFunction	start="gtsvectorout'(" end=")" contains=ALL
syn region pgsqlFunction	start="gtsvector_penalty'(" end=")" contains=ALL
syn region pgsqlFunction	start="gtsvector_picksplit'(" end=")" contains=ALL
syn region pgsqlFunction	start="gtsvector_same'(" end=")" contains=ALL
syn region pgsqlFunction	start="gtsvector_union'(" end=")" contains=ALL
syn region pgsqlFunction	start="has_any_column_privilege'(" end=")" contains=ALL
syn region pgsqlFunction	start="has_column_privilege'(" end=")" contains=ALL
syn region pgsqlFunction	start="has_database_privilege'(" end=")" contains=ALL
syn region pgsqlFunction	start="has_foreign_data_wrapper_privilege'(" end=")" contains=ALL
syn region pgsqlFunction	start="has_function_privilege'(" end=")" contains=ALL
syn region pgsqlFunction	start="hash_aclitem'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashbeginscan'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashbpchar'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashbuild'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashbulkdelete'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashchar'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashcostestimate'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashendscan'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashenum'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashfloat4'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashfloat8'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashgetbitmap'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashgettuple'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashinet'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashinsert'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashint2'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashint2vector'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashint4'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashint8'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashmacaddr'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashmarkpos'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashname'(" end=")" contains=ALL
syn region pgsqlFunction	start="hash_numeric'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashoid'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashoidvector'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashoptions'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashrescan'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashrestrpos'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashtext'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashvacuumcleanup'(" end=")" contains=ALL
syn region pgsqlFunction	start="hashvarlena'(" end=")" contains=ALL
syn region pgsqlFunction	start="has_language_privilege'(" end=")" contains=ALL
syn region pgsqlFunction	start="has_schema_privilege'(" end=")" contains=ALL
syn region pgsqlFunction	start="has_sequence_privilege'(" end=")" contains=ALL
syn region pgsqlFunction	start="has_server_privilege'(" end=")" contains=ALL
syn region pgsqlFunction	start="has_table_privilege'(" end=")" contains=ALL
syn region pgsqlFunction	start="has_tablespace_privilege'(" end=")" contains=ALL
syn region pgsqlFunction	start="height'(" end=")" contains=ALL
syn region pgsqlFunction	start="host'(" end=")" contains=ALL
syn region pgsqlFunction	start="hostmask'(" end=")" contains=ALL
syn region pgsqlFunction	start="iclikejoinsel'(" end=")" contains=ALL
syn region pgsqlFunction	start="iclikesel'(" end=")" contains=ALL
syn region pgsqlFunction	start="icnlikejoinsel'(" end=")" contains=ALL
syn region pgsqlFunction	start="icnlikesel'(" end=")" contains=ALL
syn region pgsqlFunction	start="icregexeqjoinsel'(" end=")" contains=ALL
syn region pgsqlFunction	start="icregexeqsel'(" end=")" contains=ALL
syn region pgsqlFunction	start="icregexnejoinsel'(" end=")" contains=ALL
syn region pgsqlFunction	start="icregexnesel'(" end=")" contains=ALL
syn region pgsqlFunction	start="inetand'(" end=")" contains=ALL
syn region pgsqlFunction	start="inet_client_addr'(" end=")" contains=ALL
syn region pgsqlFunction	start="inet_client_port'(" end=")" contains=ALL
syn region pgsqlFunction	start="inet_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="inetmi'(" end=")" contains=ALL
syn region pgsqlFunction	start="inetmi_int8'(" end=")" contains=ALL
syn region pgsqlFunction	start="inetnot'(" end=")" contains=ALL
syn region pgsqlFunction	start="inetor'(" end=")" contains=ALL
syn region pgsqlFunction	start="inet_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="inetpl'(" end=")" contains=ALL
syn region pgsqlFunction	start="inet_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="inet_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="inet_server_addr'(" end=")" contains=ALL
syn region pgsqlFunction	start="inet_server_port'(" end=")" contains=ALL
syn region pgsqlFunction	start="initcap'(" end=")" contains=ALL
syn region pgsqlFunction	start="int24div'(" end=")" contains=ALL
syn region pgsqlFunction	start="int24eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="int24ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="int24gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="int24le'(" end=")" contains=ALL
syn region pgsqlFunction	start="int24lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="int24mi'(" end=")" contains=ALL
syn region pgsqlFunction	start="int24mul'(" end=")" contains=ALL
syn region pgsqlFunction	start="int24ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="int24pl'(" end=")" contains=ALL
syn region pgsqlFunction	start="int28div'(" end=")" contains=ALL
syn region pgsqlFunction	start="int28eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="int28ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="int28gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="int28le'(" end=")" contains=ALL
syn region pgsqlFunction	start="int28lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="int28mi'(" end=")" contains=ALL
syn region pgsqlFunction	start="int28mul'(" end=")" contains=ALL
syn region pgsqlFunction	start="int28ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="int28pl'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2abs'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2_accum'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2and'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2_avg_accum'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2div'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2in'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2larger'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2le'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2mi'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2mod'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2_mul_cash'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2mul'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2not'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2or'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2out'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2pl'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2send'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2shl'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2shr'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2smaller'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2_sum'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2um'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2up'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2vectoreq'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2vectorin'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2vectorout'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2vectorrecv'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2vectorsend'(" end=")" contains=ALL
syn region pgsqlFunction	start="int2xor'(" end=")" contains=ALL
syn region pgsqlFunction	start="int42div'(" end=")" contains=ALL
syn region pgsqlFunction	start="int42eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="int42ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="int42gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="int42le'(" end=")" contains=ALL
syn region pgsqlFunction	start="int42lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="int42mi'(" end=")" contains=ALL
syn region pgsqlFunction	start="int42mul'(" end=")" contains=ALL
syn region pgsqlFunction	start="int42ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="int42pl'(" end=")" contains=ALL
syn region pgsqlFunction	start="int48div'(" end=")" contains=ALL
syn region pgsqlFunction	start="int48eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="int48ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="int48gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="int48le'(" end=")" contains=ALL
syn region pgsqlFunction	start="int48lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="int48mi'(" end=")" contains=ALL
syn region pgsqlFunction	start="int48mul'(" end=")" contains=ALL
syn region pgsqlFunction	start="int48ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="int48pl'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4abs'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4_accum'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4and'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4_avg_accum'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4div'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4inc'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4in'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4larger'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4le'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4mi'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4mod'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4_mul_cash'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4mul'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4not'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4or'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4out'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4pl'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4send'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4shl'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4shr'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4smaller'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4_sum'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4um'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4up'(" end=")" contains=ALL
syn region pgsqlFunction	start="int4xor'(" end=")" contains=ALL
syn region pgsqlFunction	start="int82div'(" end=")" contains=ALL
syn region pgsqlFunction	start="int82eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="int82ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="int82gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="int82le'(" end=")" contains=ALL
syn region pgsqlFunction	start="int82lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="int82mi'(" end=")" contains=ALL
syn region pgsqlFunction	start="int82mul'(" end=")" contains=ALL
syn region pgsqlFunction	start="int82ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="int82pl'(" end=")" contains=ALL
syn region pgsqlFunction	start="int84div'(" end=")" contains=ALL
syn region pgsqlFunction	start="int84eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="int84ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="int84gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="int84le'(" end=")" contains=ALL
syn region pgsqlFunction	start="int84lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="int84mi'(" end=")" contains=ALL
syn region pgsqlFunction	start="int84mul'(" end=")" contains=ALL
syn region pgsqlFunction	start="int84ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="int84pl'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8abs'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8_accum'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8and'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8_avg_accum'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8_avg'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8div'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8inc_any'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8inc'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8inc_float8_float8'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8in'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8larger'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8le'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8mi'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8mod'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8mul'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8not'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8or'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8out'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8pl'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8pl_inet'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8send'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8shl'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8shr'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8smaller'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8_sum'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8um'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8up'(" end=")" contains=ALL
syn region pgsqlFunction	start="int8xor'(" end=")" contains=ALL
syn region pgsqlFunction	start="integer_pl_date'(" end=")" contains=ALL
syn region pgsqlFunction	start="inter_lb'(" end=")" contains=ALL
syn region pgsqlFunction	start="internal_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="internal_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="inter_sb'(" end=")" contains=ALL
syn region pgsqlFunction	start="inter_sl'(" end=")" contains=ALL
syn region pgsqlFunction	start="interval_accum'(" end=")" contains=ALL
syn region pgsqlFunction	start="interval_avg'(" end=")" contains=ALL
syn region pgsqlFunction	start="interval_cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="interval_div'(" end=")" contains=ALL
syn region pgsqlFunction	start="interval'(" end=")" contains=ALL
syn region pgsqlFunction	start="interval_eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="interval_ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="interval_gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="interval_hash'(" end=")" contains=ALL
syn region pgsqlFunction	start="interval_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="interval_larger'(" end=")" contains=ALL
syn region pgsqlFunction	start="interval_le'(" end=")" contains=ALL
syn region pgsqlFunction	start="interval_lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="interval_mi'(" end=")" contains=ALL
syn region pgsqlFunction	start="interval_mul'(" end=")" contains=ALL
syn region pgsqlFunction	start="interval_ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="interval_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="interval_pl_date'(" end=")" contains=ALL
syn region pgsqlFunction	start="interval_pl'(" end=")" contains=ALL
syn region pgsqlFunction	start="interval_pl_time'(" end=")" contains=ALL
syn region pgsqlFunction	start="interval_pl_timestamp'(" end=")" contains=ALL
syn region pgsqlFunction	start="interval_pl_timestamptz'(" end=")" contains=ALL
syn region pgsqlFunction	start="interval_pl_timetz'(" end=")" contains=ALL
syn region pgsqlFunction	start="interval_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="interval_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="interval_smaller'(" end=")" contains=ALL
syn region pgsqlFunction	start="intervaltypmodin'(" end=")" contains=ALL
syn region pgsqlFunction	start="intervaltypmodout'(" end=")" contains=ALL
syn region pgsqlFunction	start="interval_um'(" end=")" contains=ALL
syn region pgsqlFunction	start="intinterval'(" end=")" contains=ALL
syn region pgsqlFunction	start="isclosed'(" end=")" contains=ALL
syn region pgsqlFunction	start="is_empty'(" end=")" contains=ALL
syn region pgsqlFunction	start="isfinite'(" end=")" contains=ALL
syn region pgsqlFunction	start="ishorizontal'(" end=")" contains=ALL
syn region pgsqlFunction	start="iso8859_1_to_utf8'(" end=")" contains=ALL
syn region pgsqlFunction	start="iso8859_to_utf8'(" end=")" contains=ALL
syn region pgsqlFunction	start="isopen'(" end=")" contains=ALL
syn region pgsqlFunction	start="iso_to_koi8r'(" end=")" contains=ALL
syn region pgsqlFunction	start="iso_to_mic'(" end=")" contains=ALL
syn region pgsqlFunction	start="iso_to_win1251'(" end=")" contains=ALL
syn region pgsqlFunction	start="iso_to_win866'(" end=")" contains=ALL
syn region pgsqlFunction	start="isparallel'(" end=")" contains=ALL
syn region pgsqlFunction	start="isperp'(" end=")" contains=ALL
syn region pgsqlFunction	start="isvertical'(" end=")" contains=ALL
syn region pgsqlFunction	start="johab_to_utf8'(" end=")" contains=ALL
syn region pgsqlFunction	start="justify_days'(" end=")" contains=ALL
syn region pgsqlFunction	start="justify_hours'(" end=")" contains=ALL
syn region pgsqlFunction	start="justify_interval'(" end=")" contains=ALL
syn region pgsqlFunction	start="koi8r_to_iso'(" end=")" contains=ALL
syn region pgsqlFunction	start="koi8r_to_mic'(" end=")" contains=ALL
syn region pgsqlFunction	start="koi8r_to_utf8'(" end=")" contains=ALL
syn region pgsqlFunction	start="koi8r_to_win1251'(" end=")" contains=ALL
syn region pgsqlFunction	start="koi8r_to_win866'(" end=")" contains=ALL
syn region pgsqlFunction	start="koi8u_to_utf8'(" end=")" contains=ALL
syn region pgsqlFunction	start="lag'(" end=")" contains=ALL
syn region pgsqlFunction	start="language_handler_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="language_handler_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="last'(" end=")" contains=ALL
syn region pgsqlFunction	start="lastval'(" end=")" contains=ALL
syn region pgsqlFunction	start="last_value'(" end=")" contains=ALL
syn region pgsqlFunction	start="latin1_to_mic'(" end=")" contains=ALL
syn region pgsqlFunction	start="latin2_to_mic'(" end=")" contains=ALL
syn region pgsqlFunction	start="latin2_to_win1250'(" end=")" contains=ALL
syn region pgsqlFunction	start="latin3_to_mic'(" end=")" contains=ALL
syn region pgsqlFunction	start="latin4_to_mic'(" end=")" contains=ALL
syn region pgsqlFunction	start="lead'(" end=")" contains=ALL
syn region pgsqlFunction	start="length'(" end=")" contains=ALL
syn region pgsqlFunction	start="like'(" end=")" contains=ALL
syn region pgsqlFunction	start="like_escape'(" end=")" contains=ALL
syn region pgsqlFunction	start="likejoinsel'(" end=")" contains=ALL
syn region pgsqlFunction	start="likesel'(" end=")" contains=ALL
syn region pgsqlFunction	start="line_distance'(" end=")" contains=ALL
syn region pgsqlFunction	start="line'(" end=")" contains=ALL
syn region pgsqlFunction	start="line_eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="line_horizontal'(" end=")" contains=ALL
syn region pgsqlFunction	start="line_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="line_interpt'(" end=")" contains=ALL
syn region pgsqlFunction	start="line_intersect'(" end=")" contains=ALL
syn region pgsqlFunction	start="line_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="line_parallel'(" end=")" contains=ALL
syn region pgsqlFunction	start="line_perp'(" end=")" contains=ALL
syn region pgsqlFunction	start="line_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="line_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="line_vertical'(" end=")" contains=ALL
syn region pgsqlFunction	start="ln'(" end=")" contains=ALL
syn region pgsqlFunction	start="lo_close'(" end=")" contains=ALL
syn region pgsqlFunction	start="lo_create'(" end=")" contains=ALL
syn region pgsqlFunction	start="lo_creat'(" end=")" contains=ALL
syn region pgsqlFunction	start="lo_export'(" end=")" contains=ALL
syn region pgsqlFunction	start="log'(" end=")" contains=ALL
syn region pgsqlFunction	start="lo_import'(" end=")" contains=ALL
syn region pgsqlFunction	start="lo_lseek'(" end=")" contains=ALL
syn region pgsqlFunction	start="lo_open'(" end=")" contains=ALL
syn region pgsqlFunction	start="loread'(" end=")" contains=ALL
syn region pgsqlFunction	start="lo_tell'(" end=")" contains=ALL
syn region pgsqlFunction	start="lo_truncate'(" end=")" contains=ALL
syn region pgsqlFunction	start="lo_unlink'(" end=")" contains=ALL
syn region pgsqlFunction	start="lower'(" end=")" contains=ALL
syn region pgsqlFunction	start="lowrite'(" end=")" contains=ALL
syn region pgsqlFunction	start="lpad'(" end=")" contains=ALL
syn region pgsqlFunction	start="lseg_center'(" end=")" contains=ALL
syn region pgsqlFunction	start="lseg_distance'(" end=")" contains=ALL
syn region pgsqlFunction	start="lseg'(" end=")" contains=ALL
syn region pgsqlFunction	start="lseg_eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="lseg_ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="lseg_gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="lseg_horizontal'(" end=")" contains=ALL
syn region pgsqlFunction	start="lseg_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="lseg_interpt'(" end=")" contains=ALL
syn region pgsqlFunction	start="lseg_intersect'(" end=")" contains=ALL
syn region pgsqlFunction	start="lseg_le'(" end=")" contains=ALL
syn region pgsqlFunction	start="lseg_length'(" end=")" contains=ALL
syn region pgsqlFunction	start="lseg_lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="lseg_ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="lseg_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="lseg_parallel'(" end=")" contains=ALL
syn region pgsqlFunction	start="lseg_perp'(" end=")" contains=ALL
syn region pgsqlFunction	start="lseg_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="lseg_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="lseg_vertical'(" end=")" contains=ALL
syn region pgsqlFunction	start="ltrim'(" end=")" contains=ALL
syn region pgsqlFunction	start="macaddr_cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="macaddr_eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="macaddr_ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="macaddr_gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="macaddr_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="macaddr_le'(" end=")" contains=ALL
syn region pgsqlFunction	start="macaddr_lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="macaddr_ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="macaddr_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="macaddr_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="macaddr_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="makeaclitem'(" end=")" contains=ALL
syn region pgsqlFunction	start="masklen'(" end=")" contains=ALL
syn region pgsqlFunction	start="max'(" end=")" contains=ALL
syn region pgsqlFunction	start="md5'(" end=")" contains=ALL
syn region pgsqlFunction	start="mic_to_ascii'(" end=")" contains=ALL
syn region pgsqlFunction	start="mic_to_big5'(" end=")" contains=ALL
syn region pgsqlFunction	start="mic_to_euc_cn'(" end=")" contains=ALL
syn region pgsqlFunction	start="mic_to_euc_jp'(" end=")" contains=ALL
syn region pgsqlFunction	start="mic_to_euc_kr'(" end=")" contains=ALL
syn region pgsqlFunction	start="mic_to_euc_tw'(" end=")" contains=ALL
syn region pgsqlFunction	start="mic_to_iso'(" end=")" contains=ALL
syn region pgsqlFunction	start="mic_to_koi8r'(" end=")" contains=ALL
syn region pgsqlFunction	start="mic_to_latin1'(" end=")" contains=ALL
syn region pgsqlFunction	start="mic_to_latin2'(" end=")" contains=ALL
syn region pgsqlFunction	start="mic_to_latin3'(" end=")" contains=ALL
syn region pgsqlFunction	start="mic_to_latin4'(" end=")" contains=ALL
syn region pgsqlFunction	start="mic_to_sjis'(" end=")" contains=ALL
syn region pgsqlFunction	start="mic_to_win1250'(" end=")" contains=ALL
syn region pgsqlFunction	start="mic_to_win1251'(" end=")" contains=ALL
syn region pgsqlFunction	start="mic_to_win866'(" end=")" contains=ALL
syn region pgsqlFunction	start="min'(" end=")" contains=ALL
syn region pgsqlFunction	start="minus'(" end=")" contains=ALL
syn region pgsqlFunction	start="mktinterval'(" end=")" contains=ALL
syn region pgsqlFunction	start="mod'(" end=")" contains=ALL
syn region pgsqlFunction	start="mul_d_interval'(" end=")" contains=ALL
syn region pgsqlFunction	start="name'(" end=")" contains=ALL
syn region pgsqlFunction	start="nameeq'(" end=")" contains=ALL
syn region pgsqlFunction	start="namege'(" end=")" contains=ALL
syn region pgsqlFunction	start="namegt'(" end=")" contains=ALL
syn region pgsqlFunction	start="nameiclike'(" end=")" contains=ALL
syn region pgsqlFunction	start="nameicnlike'(" end=")" contains=ALL
syn region pgsqlFunction	start="nameicregexeq'(" end=")" contains=ALL
syn region pgsqlFunction	start="nameicregexne'(" end=")" contains=ALL
syn region pgsqlFunction	start="namein'(" end=")" contains=ALL
syn region pgsqlFunction	start="namele'(" end=")" contains=ALL
syn region pgsqlFunction	start="namelike'(" end=")" contains=ALL
syn region pgsqlFunction	start="namelt'(" end=")" contains=ALL
syn region pgsqlFunction	start="namene'(" end=")" contains=ALL
syn region pgsqlFunction	start="namenlike'(" end=")" contains=ALL
syn region pgsqlFunction	start="nameout'(" end=")" contains=ALL
syn region pgsqlFunction	start="namerecv'(" end=")" contains=ALL
syn region pgsqlFunction	start="nameregexeq'(" end=")" contains=ALL
syn region pgsqlFunction	start="nameregexne'(" end=")" contains=ALL
syn region pgsqlFunction	start="namesend'(" end=")" contains=ALL
syn region pgsqlFunction	start="neqjoinsel'(" end=")" contains=ALL
syn region pgsqlFunction	start="neqsel'(" end=")" contains=ALL
syn region pgsqlFunction	start="nequals'(" end=")" contains=ALL
syn region pgsqlFunction	start="netmask'(" end=")" contains=ALL
syn region pgsqlFunction	start="network_cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="network'(" end=")" contains=ALL
syn region pgsqlFunction	start="network_eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="network_ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="network_gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="network_le'(" end=")" contains=ALL
syn region pgsqlFunction	start="network_lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="network_ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="network_sub'(" end=")" contains=ALL
syn region pgsqlFunction	start="network_subeq'(" end=")" contains=ALL
syn region pgsqlFunction	start="network_sup'(" end=")" contains=ALL
syn region pgsqlFunction	start="network_supeq'(" end=")" contains=ALL
syn region pgsqlFunction	start="next'(" end=")" contains=ALL
syn region pgsqlFunction	start="nextval'(" end=")" contains=ALL
syn region pgsqlFunction	start="ninetyfive'(" end=")" contains=ALL
syn region pgsqlFunction	start="nlikejoinsel'(" end=")" contains=ALL
syn region pgsqlFunction	start="nlikesel'(" end=")" contains=ALL
syn region pgsqlFunction	start="notlike'(" end=")" contains=ALL
syn region pgsqlFunction	start="now'(" end=")" contains=ALL
syn region pgsqlFunction	start="npoints'(" end=")" contains=ALL
syn region pgsqlFunction	start="nth_value'(" end=")" contains=ALL
syn region pgsqlFunction	start="ntile'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_abs'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_accum'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_add'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_avg_accum'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_avg'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_div'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_div_trunc'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_exp'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_fac'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_inc'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_larger'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_le'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_ln'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_log'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_mod'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_mul'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_power'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_smaller'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_sqrt'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_stddev_pop'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_stddev_samp'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_sub'(" end=")" contains=ALL
syn region pgsqlFunction	start="numerictypmodin'(" end=")" contains=ALL
syn region pgsqlFunction	start="numerictypmodout'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_uminus'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_uplus'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_var_pop'(" end=")" contains=ALL
syn region pgsqlFunction	start="numeric_var_samp'(" end=")" contains=ALL
syn region pgsqlFunction	start="numnode'(" end=")" contains=ALL
syn region pgsqlFunction	start="obj_description'(" end=")" contains=ALL
syn region pgsqlFunction	start="octet_length'(" end=")" contains=ALL
syn region pgsqlFunction	start="oid'(" end=")" contains=ALL
syn region pgsqlFunction	start="oideq'(" end=")" contains=ALL
syn region pgsqlFunction	start="oidge'(" end=")" contains=ALL
syn region pgsqlFunction	start="oidgt'(" end=")" contains=ALL
syn region pgsqlFunction	start="oidin'(" end=")" contains=ALL
syn region pgsqlFunction	start="oidlarger'(" end=")" contains=ALL
syn region pgsqlFunction	start="oidle'(" end=")" contains=ALL
syn region pgsqlFunction	start="oidlt'(" end=")" contains=ALL
syn region pgsqlFunction	start="oidne'(" end=")" contains=ALL
syn region pgsqlFunction	start="oidout'(" end=")" contains=ALL
syn region pgsqlFunction	start="oidrecv'(" end=")" contains=ALL
syn region pgsqlFunction	start="oidsend'(" end=")" contains=ALL
syn region pgsqlFunction	start="oidsmaller'(" end=")" contains=ALL
syn region pgsqlFunction	start="oidvectoreq'(" end=")" contains=ALL
syn region pgsqlFunction	start="oidvectorge'(" end=")" contains=ALL
syn region pgsqlFunction	start="oidvectorgt'(" end=")" contains=ALL
syn region pgsqlFunction	start="oidvectorin'(" end=")" contains=ALL
syn region pgsqlFunction	start="oidvectorle'(" end=")" contains=ALL
syn region pgsqlFunction	start="oidvectorlt'(" end=")" contains=ALL
syn region pgsqlFunction	start="oidvectorne'(" end=")" contains=ALL
syn region pgsqlFunction	start="oidvectorout'(" end=")" contains=ALL
syn region pgsqlFunction	start="oidvectorrecv'(" end=")" contains=ALL
syn region pgsqlFunction	start="oidvectorsend'(" end=")" contains=ALL
syn region pgsqlFunction	start="oidvectortypes'(" end=")" contains=ALL
syn region pgsqlFunction	start="on_pb'(" end=")" contains=ALL
syn region pgsqlFunction	start="on_pl'(" end=")" contains=ALL
syn region pgsqlFunction	start="on_ppath'(" end=")" contains=ALL
syn region pgsqlFunction	start="on_ps'(" end=")" contains=ALL
syn region pgsqlFunction	start="on_sb'(" end=")" contains=ALL
syn region pgsqlFunction	start="on_sl'(" end=")" contains=ALL
syn region pgsqlFunction	start="opaque_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="opaque_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="overlaps'(" end=")" contains=ALL
syn region pgsqlFunction	start="overlay'(" end=")" contains=ALL
syn region pgsqlFunction	start="overleft'(" end=")" contains=ALL
syn region pgsqlFunction	start="overright'(" end=")" contains=ALL
syn region pgsqlFunction	start="path_add'(" end=")" contains=ALL
syn region pgsqlFunction	start="path_add_pt'(" end=")" contains=ALL
syn region pgsqlFunction	start="path_center'(" end=")" contains=ALL
syn region pgsqlFunction	start="path_contain_pt'(" end=")" contains=ALL
syn region pgsqlFunction	start="path_distance'(" end=")" contains=ALL
syn region pgsqlFunction	start="path_div_pt'(" end=")" contains=ALL
syn region pgsqlFunction	start="path'(" end=")" contains=ALL
syn region pgsqlFunction	start="path_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="path_inter'(" end=")" contains=ALL
syn region pgsqlFunction	start="path_length'(" end=")" contains=ALL
syn region pgsqlFunction	start="path_mul_pt'(" end=")" contains=ALL
syn region pgsqlFunction	start="path_n_eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="path_n_ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="path_n_gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="path_n_le'(" end=")" contains=ALL
syn region pgsqlFunction	start="path_n_lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="path_npoints'(" end=")" contains=ALL
syn region pgsqlFunction	start="path_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="path_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="path_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="path_sub_pt'(" end=")" contains=ALL
syn region pgsqlFunction	start="pclose'(" end=")" contains=ALL
syn region pgsqlFunction	start="percent_rank'(" end=")" contains=ALL
syn region pgsqlFunction	start="period_cc'(" end=")" contains=ALL
syn region pgsqlFunction	start="period_co'(" end=")" contains=ALL
syn region pgsqlFunction	start="period'(" end=")" contains=ALL
syn region pgsqlFunction	start="period_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="period_intersect'(" end=")" contains=ALL
syn region pgsqlFunction	start="period_oc'(" end=")" contains=ALL
syn region pgsqlFunction	start="period_offset'(" end=")" contains=ALL
syn region pgsqlFunction	start="period_offset_sec'(" end=")" contains=ALL
syn region pgsqlFunction	start="period_oo'(" end=")" contains=ALL
syn region pgsqlFunction	start="period_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="period_union'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_advisory_lock'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_advisory_lock_shared'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_advisory_unlock_all'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_advisory_unlock'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_advisory_unlock_shared'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_backend_pid'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_cancel_backend'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_char_to_encoding'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_client_encoding'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_column_size'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_conf_load_time'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_conversion_is_visible'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_current_xlog_insert_location'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_current_xlog_location'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_cursor'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_database_size'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_encoding_max_length'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_encoding_to_char'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_function_is_visible'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_get_constraintdef'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_get_expr'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_get_function_arguments'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_get_functiondef'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_get_function_identity_arguments'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_get_function_result'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_get_indexdef'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_get_keywords'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_get_ruledef'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_get_serial_sequence'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_get_triggerdef'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_get_userbyid'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_get_viewdef'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_has_role'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_indexes_size'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_is_in_recovery'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_is_other_temp_schema'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_last_xlog_receive_location'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_last_xlog_replay_location'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_listening_channels'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_lock_status'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_ls_dir'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_my_temp_schema'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_notify'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_opclass_is_visible'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_operator_is_visible'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_options_to_table'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_postmaster_start_time'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_prepared_statement'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_prepared_xact'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_read_file'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_relation_filenode'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_relation_filepath'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_relation_size'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_reload_conf'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_rotate_logfile'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_show_all_settings'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_size_pretty'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_sleep'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_start_backup'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_clear_snapshot'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_file'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_activity'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_backend_activity'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_backend_activity_start'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_backend_client_addr'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_backend_client_port'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_backend_dbid'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_backend_idset'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_backend_pid'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_backend_start'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_backend_userid'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_backend_waiting'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_backend_xact_start'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_bgwriter_buf_written_checkpoints'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_bgwriter_buf_written_clean'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_bgwriter_maxwritten_clean'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_bgwriter_requested_checkpoints'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_bgwriter_timed_checkpoints'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_blocks_fetched'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_blocks_hit'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_buf_alloc'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_buf_written_backend'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_db_blocks_fetched'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_db_blocks_hit'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_db_numbackends'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_db_tuples_deleted'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_db_tuples_fetched'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_db_tuples_inserted'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_db_tuples_returned'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_db_tuples_updated'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_db_xact_commit'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_db_xact_rollback'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_dead_tuples'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_function_calls'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_function_self_time'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_function_time'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_last_analyze_time'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_last_autoanalyze_time'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_last_autovacuum_time'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_last_vacuum_time'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_live_tuples'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_numscans'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_tuples_deleted'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_tuples_fetched'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_tuples_hot_updated'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_tuples_inserted'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_tuples_returned'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_get_tuples_updated'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_reset'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_reset_shared'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_reset_single_function_counters'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stat_reset_single_table_counters'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_stop_backup'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_switch_xlog'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_table_is_visible'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_table_size'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_tablespace_databases'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_tablespace_size'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_terminate_backend'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_timezone_abbrevs'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_timezone_names'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_total_relation_size'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_try_advisory_lock'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_try_advisory_lock_shared'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_ts_config_is_visible'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_ts_dict_is_visible'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_ts_parser_is_visible'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_ts_template_is_visible'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_type_is_visible'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_typeof'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_xlogfile_name'(" end=")" contains=ALL
syn region pgsqlFunction	start="pg_xlogfile_name_offset'(" end=")" contains=ALL
syn region pgsqlFunction	start="pi'(" end=")" contains=ALL
syn region pgsqlFunction	start="plainto_tsquery'(" end=")" contains=ALL
syn region pgsqlFunction	start="plpgsql_call_handler'(" end=")" contains=ALL
syn region pgsqlFunction	start="plpgsql_inline_handler'(" end=")" contains=ALL
syn region pgsqlFunction	start="plpgsql_validator'(" end=")" contains=ALL
syn region pgsqlFunction	start="point_above'(" end=")" contains=ALL
syn region pgsqlFunction	start="point_add'(" end=")" contains=ALL
syn region pgsqlFunction	start="point_below'(" end=")" contains=ALL
syn region pgsqlFunction	start="point_distance'(" end=")" contains=ALL
syn region pgsqlFunction	start="point_div'(" end=")" contains=ALL
syn region pgsqlFunction	start="point'(" end=")" contains=ALL
syn region pgsqlFunction	start="point_eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="point_horiz'(" end=")" contains=ALL
syn region pgsqlFunction	start="point_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="point_left'(" end=")" contains=ALL
syn region pgsqlFunction	start="point_mul'(" end=")" contains=ALL
syn region pgsqlFunction	start="point_ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="point_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="point_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="point_right'(" end=")" contains=ALL
syn region pgsqlFunction	start="point_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="point_sub'(" end=")" contains=ALL
syn region pgsqlFunction	start="point_vert'(" end=")" contains=ALL
syn region pgsqlFunction	start="poly_above'(" end=")" contains=ALL
syn region pgsqlFunction	start="poly_below'(" end=")" contains=ALL
syn region pgsqlFunction	start="poly_center'(" end=")" contains=ALL
syn region pgsqlFunction	start="poly_contained'(" end=")" contains=ALL
syn region pgsqlFunction	start="poly_contain'(" end=")" contains=ALL
syn region pgsqlFunction	start="poly_contain_pt'(" end=")" contains=ALL
syn region pgsqlFunction	start="poly_distance'(" end=")" contains=ALL
syn region pgsqlFunction	start="polygon'(" end=")" contains=ALL
syn region pgsqlFunction	start="poly_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="poly_left'(" end=")" contains=ALL
syn region pgsqlFunction	start="poly_npoints'(" end=")" contains=ALL
syn region pgsqlFunction	start="poly_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="poly_overabove'(" end=")" contains=ALL
syn region pgsqlFunction	start="poly_overbelow'(" end=")" contains=ALL
syn region pgsqlFunction	start="poly_overlap'(" end=")" contains=ALL
syn region pgsqlFunction	start="poly_overleft'(" end=")" contains=ALL
syn region pgsqlFunction	start="poly_overright'(" end=")" contains=ALL
syn region pgsqlFunction	start="poly_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="poly_right'(" end=")" contains=ALL
syn region pgsqlFunction	start="poly_same'(" end=")" contains=ALL
syn region pgsqlFunction	start="poly_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="popen'(" end=")" contains=ALL
syn region pgsqlFunction	start="position'(" end=")" contains=ALL
syn region pgsqlFunction	start="positionjoinsel'(" end=")" contains=ALL
syn region pgsqlFunction	start="positionsel'(" end=")" contains=ALL
syn region pgsqlFunction	start="postgresql_fdw_validator'(" end=")" contains=ALL
syn region pgsqlFunction	start="pow'(" end=")" contains=ALL
syn region pgsqlFunction	start="power'(" end=")" contains=ALL
syn region pgsqlFunction	start="prior'(" end=")" contains=ALL
syn region pgsqlFunction	start="prsd_end'(" end=")" contains=ALL
syn region pgsqlFunction	start="prsd_headline'(" end=")" contains=ALL
syn region pgsqlFunction	start="prsd_lextype'(" end=")" contains=ALL
syn region pgsqlFunction	start="prsd_nexttoken'(" end=")" contains=ALL
syn region pgsqlFunction	start="prsd_start'(" end=")" contains=ALL
syn region pgsqlFunction	start="pt_contained_circle'(" end=")" contains=ALL
syn region pgsqlFunction	start="pt_contained_poly'(" end=")" contains=ALL
syn region pgsqlFunction	start="query_to_xml_and_xmlschema'(" end=")" contains=ALL
syn region pgsqlFunction	start="query_to_xml'(" end=")" contains=ALL
syn region pgsqlFunction	start="query_to_xmlschema'(" end=")" contains=ALL
syn region pgsqlFunction	start="querytree'(" end=")" contains=ALL
syn region pgsqlFunction	start="quote_ident'(" end=")" contains=ALL
syn region pgsqlFunction	start="quote_literal'(" end=")" contains=ALL
syn region pgsqlFunction	start="quote_nullable'(" end=")" contains=ALL
syn region pgsqlFunction	start="radians'(" end=")" contains=ALL
syn region pgsqlFunction	start="radius'(" end=")" contains=ALL
syn region pgsqlFunction	start="random'(" end=")" contains=ALL
syn region pgsqlFunction	start="rank'(" end=")" contains=ALL
syn region pgsqlFunction	start="record_eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="record_ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="record_gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="record_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="record_le'(" end=")" contains=ALL
syn region pgsqlFunction	start="record_lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="record_ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="record_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="record_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="record_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="regclass'(" end=")" contains=ALL
syn region pgsqlFunction	start="regclassin'(" end=")" contains=ALL
syn region pgsqlFunction	start="regclassout'(" end=")" contains=ALL
syn region pgsqlFunction	start="regclassrecv'(" end=")" contains=ALL
syn region pgsqlFunction	start="regclasssend'(" end=")" contains=ALL
syn region pgsqlFunction	start="regconfigin'(" end=")" contains=ALL
syn region pgsqlFunction	start="regconfigout'(" end=")" contains=ALL
syn region pgsqlFunction	start="regconfigrecv'(" end=")" contains=ALL
syn region pgsqlFunction	start="regconfigsend'(" end=")" contains=ALL
syn region pgsqlFunction	start="regdictionaryin'(" end=")" contains=ALL
syn region pgsqlFunction	start="regdictionaryout'(" end=")" contains=ALL
syn region pgsqlFunction	start="regdictionaryrecv'(" end=")" contains=ALL
syn region pgsqlFunction	start="regdictionarysend'(" end=")" contains=ALL
syn region pgsqlFunction	start="regexeqjoinsel'(" end=")" contains=ALL
syn region pgsqlFunction	start="regexeqsel'(" end=")" contains=ALL
syn region pgsqlFunction	start="regexnejoinsel'(" end=")" contains=ALL
syn region pgsqlFunction	start="regexnesel'(" end=")" contains=ALL
syn region pgsqlFunction	start="regexp_matches'(" end=")" contains=ALL
syn region pgsqlFunction	start="regexp_replace'(" end=")" contains=ALL
syn region pgsqlFunction	start="regexp_split_to_array'(" end=")" contains=ALL
syn region pgsqlFunction	start="regexp_split_to_table'(" end=")" contains=ALL
syn region pgsqlFunction	start="regoperatorin'(" end=")" contains=ALL
syn region pgsqlFunction	start="regoperatorout'(" end=")" contains=ALL
syn region pgsqlFunction	start="regoperatorrecv'(" end=")" contains=ALL
syn region pgsqlFunction	start="regoperatorsend'(" end=")" contains=ALL
syn region pgsqlFunction	start="regoperin'(" end=")" contains=ALL
syn region pgsqlFunction	start="regoperout'(" end=")" contains=ALL
syn region pgsqlFunction	start="regoperrecv'(" end=")" contains=ALL
syn region pgsqlFunction	start="regopersend'(" end=")" contains=ALL
syn region pgsqlFunction	start="regprocedurein'(" end=")" contains=ALL
syn region pgsqlFunction	start="regprocedureout'(" end=")" contains=ALL
syn region pgsqlFunction	start="regprocedurerecv'(" end=")" contains=ALL
syn region pgsqlFunction	start="regproceduresend'(" end=")" contains=ALL
syn region pgsqlFunction	start="regprocin'(" end=")" contains=ALL
syn region pgsqlFunction	start="regprocout'(" end=")" contains=ALL
syn region pgsqlFunction	start="regprocrecv'(" end=")" contains=ALL
syn region pgsqlFunction	start="regprocsend'(" end=")" contains=ALL
syn region pgsqlFunction	start="regr_avgx'(" end=")" contains=ALL
syn region pgsqlFunction	start="regr_avgy'(" end=")" contains=ALL
syn region pgsqlFunction	start="regr_count'(" end=")" contains=ALL
syn region pgsqlFunction	start="regr_intercept'(" end=")" contains=ALL
syn region pgsqlFunction	start="regr_r2'(" end=")" contains=ALL
syn region pgsqlFunction	start="regr_slope'(" end=")" contains=ALL
syn region pgsqlFunction	start="regr_sxx'(" end=")" contains=ALL
syn region pgsqlFunction	start="regr_sxy'(" end=")" contains=ALL
syn region pgsqlFunction	start="regr_syy'(" end=")" contains=ALL
syn region pgsqlFunction	start="regtypein'(" end=")" contains=ALL
syn region pgsqlFunction	start="regtypeout'(" end=")" contains=ALL
syn region pgsqlFunction	start="regtyperecv'(" end=")" contains=ALL
syn region pgsqlFunction	start="regtypesend'(" end=")" contains=ALL
syn region pgsqlFunction	start="reltime'(" end=")" contains=ALL
syn region pgsqlFunction	start="reltimeeq'(" end=")" contains=ALL
syn region pgsqlFunction	start="reltimege'(" end=")" contains=ALL
syn region pgsqlFunction	start="reltimegt'(" end=")" contains=ALL
syn region pgsqlFunction	start="reltimein'(" end=")" contains=ALL
syn region pgsqlFunction	start="reltimele'(" end=")" contains=ALL
syn region pgsqlFunction	start="reltimelt'(" end=")" contains=ALL
syn region pgsqlFunction	start="reltimene'(" end=")" contains=ALL
syn region pgsqlFunction	start="reltimeout'(" end=")" contains=ALL
syn region pgsqlFunction	start="reltimerecv'(" end=")" contains=ALL
syn region pgsqlFunction	start="reltimesend'(" end=")" contains=ALL
syn region pgsqlFunction	start="repeat'(" end=")" contains=ALL
syn region pgsqlFunction	start="replace'(" end=")" contains=ALL
syn region pgsqlFunction	start="RI_FKey_cascade_del'(" end=")" contains=ALL
syn region pgsqlFunction	start="RI_FKey_cascade_upd'(" end=")" contains=ALL
syn region pgsqlFunction	start="RI_FKey_check_ins'(" end=")" contains=ALL
syn region pgsqlFunction	start="RI_FKey_check_upd'(" end=")" contains=ALL
syn region pgsqlFunction	start="RI_FKey_noaction_del'(" end=")" contains=ALL
syn region pgsqlFunction	start="RI_FKey_noaction_upd'(" end=")" contains=ALL
syn region pgsqlFunction	start="RI_FKey_restrict_del'(" end=")" contains=ALL
syn region pgsqlFunction	start="RI_FKey_restrict_upd'(" end=")" contains=ALL
syn region pgsqlFunction	start="RI_FKey_setdefault_del'(" end=")" contains=ALL
syn region pgsqlFunction	start="RI_FKey_setdefault_upd'(" end=")" contains=ALL
syn region pgsqlFunction	start="RI_FKey_setnull_del'(" end=")" contains=ALL
syn region pgsqlFunction	start="RI_FKey_setnull_upd'(" end=")" contains=ALL
syn region pgsqlFunction	start="round'(" end=")" contains=ALL
syn region pgsqlFunction	start="row_number'(" end=")" contains=ALL
syn region pgsqlFunction	start="rpad'(" end=")" contains=ALL
syn region pgsqlFunction	start="rtrim'(" end=")" contains=ALL
syn region pgsqlFunction	start="scalargtjoinsel'(" end=")" contains=ALL
syn region pgsqlFunction	start="scalargtsel'(" end=")" contains=ALL
syn region pgsqlFunction	start="scalarltjoinsel'(" end=")" contains=ALL
syn region pgsqlFunction	start="scalarltsel'(" end=")" contains=ALL
syn region pgsqlFunction	start="schema_to_xml_and_xmlschema'(" end=")" contains=ALL
syn region pgsqlFunction	start="schema_to_xml'(" end=")" contains=ALL
syn region pgsqlFunction	start="schema_to_xmlschema'(" end=")" contains=ALL
syn region pgsqlFunction	start="session_user'(" end=")" contains=ALL
syn region pgsqlFunction	start="set_bit'(" end=")" contains=ALL
syn region pgsqlFunction	start="set_byte'(" end=")" contains=ALL
syn region pgsqlFunction	start="set_config'(" end=")" contains=ALL
syn region pgsqlFunction	start="set_masklen'(" end=")" contains=ALL
syn region pgsqlFunction	start="setseed'(" end=")" contains=ALL
syn region pgsqlFunction	start="setval'(" end=")" contains=ALL
syn region pgsqlFunction	start="setweight'(" end=")" contains=ALL
syn region pgsqlFunction	start="shell_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="shell_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="shift_jis_2004_to_euc_jis_2004'(" end=")" contains=ALL
syn region pgsqlFunction	start="shift_jis_2004_to_utf8'(" end=")" contains=ALL
syn region pgsqlFunction	start="shobj_description'(" end=")" contains=ALL
syn region pgsqlFunction	start="sign'(" end=")" contains=ALL
syn region pgsqlFunction	start="similar_escape'(" end=")" contains=ALL
syn region pgsqlFunction	start="sin'(" end=")" contains=ALL
syn region pgsqlFunction	start="sjis_to_euc_jp'(" end=")" contains=ALL
syn region pgsqlFunction	start="sjis_to_mic'(" end=")" contains=ALL
syn region pgsqlFunction	start="sjis_to_utf8'(" end=")" contains=ALL
syn region pgsqlFunction	start="slope'(" end=")" contains=ALL
syn region pgsqlFunction	start="smgreq'(" end=")" contains=ALL
syn region pgsqlFunction	start="smgrin'(" end=")" contains=ALL
syn region pgsqlFunction	start="smgrne'(" end=")" contains=ALL
syn region pgsqlFunction	start="smgrout'(" end=")" contains=ALL
syn region pgsqlFunction	start="split_part'(" end=")" contains=ALL
syn region pgsqlFunction	start="sqrt'(" end=")" contains=ALL
syn region pgsqlFunction	start="statement_timestamp'(" end=")" contains=ALL
syn region pgsqlFunction	start="stddev'(" end=")" contains=ALL
syn region pgsqlFunction	start="stddev_pop'(" end=")" contains=ALL
syn region pgsqlFunction	start="stddev_samp'(" end=")" contains=ALL
syn region pgsqlFunction	start="string_agg_delim_transfn'(" end=")" contains=ALL
syn region pgsqlFunction	start="string_agg'(" end=")" contains=ALL
syn region pgsqlFunction	start="string_agg_finalfn'(" end=")" contains=ALL
syn region pgsqlFunction	start="string_agg_transfn'(" end=")" contains=ALL
syn region pgsqlFunction	start="string_to_array'(" end=")" contains=ALL
syn region pgsqlFunction	start="strip'(" end=")" contains=ALL
syn region pgsqlFunction	start="strpos'(" end=")" contains=ALL
syn region pgsqlFunction	start="substr'(" end=")" contains=ALL
syn region pgsqlFunction	start="substring'(" end=")" contains=ALL
syn region pgsqlFunction	start="sudoku'(" end=")" contains=ALL
syn region pgsqlFunction	start="sum'(" end=")" contains=ALL
syn region pgsqlFunction	start="suppress_redundant_updates_trigger'(" end=")" contains=ALL
syn region pgsqlFunction	start="table_to_xml_and_xmlschema'(" end=")" contains=ALL
syn region pgsqlFunction	start="table_to_xml'(" end=")" contains=ALL
syn region pgsqlFunction	start="table_to_xmlschema'(" end=")" contains=ALL
syn region pgsqlFunction	start="tan'(" end=")" contains=ALL
syn region pgsqlFunction	start="textanycat'(" end=")" contains=ALL
syn region pgsqlFunction	start="textcat'(" end=")" contains=ALL
syn region pgsqlFunction	start="text'(" end=")" contains=ALL
syn region pgsqlFunction	start="texteq'(" end=")" contains=ALL
syn region pgsqlFunction	start="text_ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="text_gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="texticlike'(" end=")" contains=ALL
syn region pgsqlFunction	start="texticnlike'(" end=")" contains=ALL
syn region pgsqlFunction	start="texticregexeq'(" end=")" contains=ALL
syn region pgsqlFunction	start="texticregexne'(" end=")" contains=ALL
syn region pgsqlFunction	start="textin'(" end=")" contains=ALL
syn region pgsqlFunction	start="text_larger'(" end=")" contains=ALL
syn region pgsqlFunction	start="text_le'(" end=")" contains=ALL
syn region pgsqlFunction	start="textlen'(" end=")" contains=ALL
syn region pgsqlFunction	start="textlike'(" end=")" contains=ALL
syn region pgsqlFunction	start="text_lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="textne'(" end=")" contains=ALL
syn region pgsqlFunction	start="textnlike'(" end=")" contains=ALL
syn region pgsqlFunction	start="textout'(" end=")" contains=ALL
syn region pgsqlFunction	start="text_pattern_ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="text_pattern_gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="text_pattern_le'(" end=")" contains=ALL
syn region pgsqlFunction	start="text_pattern_lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="textrecv'(" end=")" contains=ALL
syn region pgsqlFunction	start="textregexeq'(" end=")" contains=ALL
syn region pgsqlFunction	start="textregexne'(" end=")" contains=ALL
syn region pgsqlFunction	start="textsend'(" end=")" contains=ALL
syn region pgsqlFunction	start="text_smaller'(" end=")" contains=ALL
syn region pgsqlFunction	start="thesaurus_init'(" end=")" contains=ALL
syn region pgsqlFunction	start="thesaurus_lexize'(" end=")" contains=ALL
syn region pgsqlFunction	start="tideq'(" end=")" contains=ALL
syn region pgsqlFunction	start="tidge'(" end=")" contains=ALL
syn region pgsqlFunction	start="tidgt'(" end=")" contains=ALL
syn region pgsqlFunction	start="tidin'(" end=")" contains=ALL
syn region pgsqlFunction	start="tidlarger'(" end=")" contains=ALL
syn region pgsqlFunction	start="tidle'(" end=")" contains=ALL
syn region pgsqlFunction	start="tidlt'(" end=")" contains=ALL
syn region pgsqlFunction	start="tidne'(" end=")" contains=ALL
syn region pgsqlFunction	start="tidout'(" end=")" contains=ALL
syn region pgsqlFunction	start="tidrecv'(" end=")" contains=ALL
syn region pgsqlFunction	start="tidsend'(" end=")" contains=ALL
syn region pgsqlFunction	start="tidsmaller'(" end=")" contains=ALL
syn region pgsqlFunction	start="time_cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="timedate_pl'(" end=")" contains=ALL
syn region pgsqlFunction	start="time'(" end=")" contains=ALL
syn region pgsqlFunction	start="time_eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="time_ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="time_gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="time_hash'(" end=")" contains=ALL
syn region pgsqlFunction	start="time_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="time_larger'(" end=")" contains=ALL
syn region pgsqlFunction	start="time_le'(" end=")" contains=ALL
syn region pgsqlFunction	start="time_lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="timemi'(" end=")" contains=ALL
syn region pgsqlFunction	start="time_mi_interval'(" end=")" contains=ALL
syn region pgsqlFunction	start="time_mi_time'(" end=")" contains=ALL
syn region pgsqlFunction	start="time_ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="timenow'(" end=")" contains=ALL
syn region pgsqlFunction	start="timeofday'(" end=")" contains=ALL
syn region pgsqlFunction	start="time_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="timepl'(" end=")" contains=ALL
syn region pgsqlFunction	start="time_pl_interval'(" end=")" contains=ALL
syn region pgsqlFunction	start="time_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="time_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="time_smaller'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_cmp_date'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_cmp_timestamptz'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_eq_date'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_eq_timestamptz'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_ge_date'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_ge_timestamptz'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_gt_date'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_gt_timestamptz'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_hash'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_larger'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_le_date'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_le'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_le_timestamptz'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_lt_date'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_lt_timestamptz'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_mi'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_mi_interval'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_ne_date'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_ne_timestamptz'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_pl_interval'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamp_smaller'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptypmodin'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptypmodout'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_cmp_date'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_cmp_timestamp'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_eq_date'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_eq_timestamp'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_ge_date'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_ge_timestamp'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_gt_date'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_gt_timestamp'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_larger'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_le_date'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_le'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_le_timestamp'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_lt_date'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_lt_timestamp'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_mi'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_mi_interval'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_ne_date'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_ne_timestamp'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_pl_interval'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptz_smaller'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptztypmodin'(" end=")" contains=ALL
syn region pgsqlFunction	start="timestamptztypmodout'(" end=")" contains=ALL
syn region pgsqlFunction	start="timetypmodin'(" end=")" contains=ALL
syn region pgsqlFunction	start="timetypmodout'(" end=")" contains=ALL
syn region pgsqlFunction	start="timetz_cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="timetzdate_pl'(" end=")" contains=ALL
syn region pgsqlFunction	start="timetz'(" end=")" contains=ALL
syn region pgsqlFunction	start="timetz_eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="timetz_ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="timetz_gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="timetz_hash'(" end=")" contains=ALL
syn region pgsqlFunction	start="timetz_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="timetz_larger'(" end=")" contains=ALL
syn region pgsqlFunction	start="timetz_le'(" end=")" contains=ALL
syn region pgsqlFunction	start="timetz_lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="timetz_mi_interval'(" end=")" contains=ALL
syn region pgsqlFunction	start="timetz_ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="timetz_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="timetz_pl_interval'(" end=")" contains=ALL
syn region pgsqlFunction	start="timetz_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="timetz_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="timetz_smaller'(" end=")" contains=ALL
syn region pgsqlFunction	start="timetztypmodin'(" end=")" contains=ALL
syn region pgsqlFunction	start="timetztypmodout'(" end=")" contains=ALL
syn region pgsqlFunction	start="timezone'(" end=")" contains=ALL
syn region pgsqlFunction	start="tintervalct'(" end=")" contains=ALL
syn region pgsqlFunction	start="tinterval'(" end=")" contains=ALL
syn region pgsqlFunction	start="tintervalend'(" end=")" contains=ALL
syn region pgsqlFunction	start="tintervaleq'(" end=")" contains=ALL
syn region pgsqlFunction	start="tintervalge'(" end=")" contains=ALL
syn region pgsqlFunction	start="tintervalgt'(" end=")" contains=ALL
syn region pgsqlFunction	start="tintervalin'(" end=")" contains=ALL
syn region pgsqlFunction	start="tintervalle'(" end=")" contains=ALL
syn region pgsqlFunction	start="tintervalleneq'(" end=")" contains=ALL
syn region pgsqlFunction	start="tintervallenge'(" end=")" contains=ALL
syn region pgsqlFunction	start="tintervallengt'(" end=")" contains=ALL
syn region pgsqlFunction	start="tintervallenle'(" end=")" contains=ALL
syn region pgsqlFunction	start="tintervallenlt'(" end=")" contains=ALL
syn region pgsqlFunction	start="tintervallenne'(" end=")" contains=ALL
syn region pgsqlFunction	start="tintervallt'(" end=")" contains=ALL
syn region pgsqlFunction	start="tintervalne'(" end=")" contains=ALL
syn region pgsqlFunction	start="tintervalout'(" end=")" contains=ALL
syn region pgsqlFunction	start="tintervalov'(" end=")" contains=ALL
syn region pgsqlFunction	start="tintervalrecv'(" end=")" contains=ALL
syn region pgsqlFunction	start="tintervalrel'(" end=")" contains=ALL
syn region pgsqlFunction	start="tintervalsame'(" end=")" contains=ALL
syn region pgsqlFunction	start="tintervalsend'(" end=")" contains=ALL
syn region pgsqlFunction	start="tintervalstart'(" end=")" contains=ALL
syn region pgsqlFunction	start="to_ascii'(" end=")" contains=ALL
syn region pgsqlFunction	start="to_char'(" end=")" contains=ALL
syn region pgsqlFunction	start="to_date'(" end=")" contains=ALL
syn region pgsqlFunction	start="to_hex'(" end=")" contains=ALL
syn region pgsqlFunction	start="to_number'(" end=")" contains=ALL
syn region pgsqlFunction	start="to_timestamp'(" end=")" contains=ALL
syn region pgsqlFunction	start="to_tsquery'(" end=")" contains=ALL
syn region pgsqlFunction	start="to_tsvector'(" end=")" contains=ALL
syn region pgsqlFunction	start="transaction_timestamp'(" end=")" contains=ALL
syn region pgsqlFunction	start="translate'(" end=")" contains=ALL
syn region pgsqlFunction	start="trigger_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="trigger_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="trunc'(" end=")" contains=ALL
syn region pgsqlFunction	start="ts_debug'(" end=")" contains=ALL
syn region pgsqlFunction	start="ts_headline'(" end=")" contains=ALL
syn region pgsqlFunction	start="ts_lexize'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsmatchjoinsel'(" end=")" contains=ALL
syn region pgsqlFunction	start="ts_match_qv'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsmatchsel'(" end=")" contains=ALL
syn region pgsqlFunction	start="ts_match_tq'(" end=")" contains=ALL
syn region pgsqlFunction	start="ts_match_tt'(" end=")" contains=ALL
syn region pgsqlFunction	start="ts_match_vq'(" end=")" contains=ALL
syn region pgsqlFunction	start="ts_parse'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsq_mcontained'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsq_mcontains'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsquery_and'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsquery_cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsquery_eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsquery_ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsquery_gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsqueryin'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsquery_le'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsquery_lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsquery_ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsquery_not'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsquery_or'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsqueryout'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsqueryrecv'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsquerysend'(" end=")" contains=ALL
syn region pgsqlFunction	start="ts_rank_cd'(" end=")" contains=ALL
syn region pgsqlFunction	start="ts_rank'(" end=")" contains=ALL
syn region pgsqlFunction	start="ts_rewrite'(" end=")" contains=ALL
syn region pgsqlFunction	start="ts_stat'(" end=")" contains=ALL
syn region pgsqlFunction	start="ts_token_type'(" end=")" contains=ALL
syn region pgsqlFunction	start="ts_typanalyze'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsvector_cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsvector_concat'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsvector_eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsvector_ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsvector_gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsvectorin'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsvector_le'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsvector_lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsvector_ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsvectorout'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsvectorrecv'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsvectorsend'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsvector_update_trigger_column'(" end=")" contains=ALL
syn region pgsqlFunction	start="tsvector_update_trigger'(" end=")" contains=ALL
syn region pgsqlFunction	start="txid_current'(" end=")" contains=ALL
syn region pgsqlFunction	start="txid_current_snapshot'(" end=")" contains=ALL
syn region pgsqlFunction	start="txid_snapshot_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="txid_snapshot_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="txid_snapshot_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="txid_snapshot_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="txid_snapshot_xip'(" end=")" contains=ALL
syn region pgsqlFunction	start="txid_snapshot_xmax'(" end=")" contains=ALL
syn region pgsqlFunction	start="txid_snapshot_xmin'(" end=")" contains=ALL
syn region pgsqlFunction	start="txid_visible_in_snapshot'(" end=")" contains=ALL
syn region pgsqlFunction	start="uhc_to_utf8'(" end=")" contains=ALL
syn region pgsqlFunction	start="unique_key_recheck'(" end=")" contains=ALL
syn region pgsqlFunction	start="unknownin'(" end=")" contains=ALL
syn region pgsqlFunction	start="unknownout'(" end=")" contains=ALL
syn region pgsqlFunction	start="unknownrecv'(" end=")" contains=ALL
syn region pgsqlFunction	start="unknownsend'(" end=")" contains=ALL
syn region pgsqlFunction	start="unnest'(" end=")" contains=ALL
syn region pgsqlFunction	start="upper'(" end=")" contains=ALL
syn region pgsqlFunction	start="utf8_to_ascii'(" end=")" contains=ALL
syn region pgsqlFunction	start="utf8_to_big5'(" end=")" contains=ALL
syn region pgsqlFunction	start="utf8_to_euc_cn'(" end=")" contains=ALL
syn region pgsqlFunction	start="utf8_to_euc_jis_2004'(" end=")" contains=ALL
syn region pgsqlFunction	start="utf8_to_euc_jp'(" end=")" contains=ALL
syn region pgsqlFunction	start="utf8_to_euc_kr'(" end=")" contains=ALL
syn region pgsqlFunction	start="utf8_to_euc_tw'(" end=")" contains=ALL
syn region pgsqlFunction	start="utf8_to_gb18030'(" end=")" contains=ALL
syn region pgsqlFunction	start="utf8_to_gbk'(" end=")" contains=ALL
syn region pgsqlFunction	start="utf8_to_iso8859_1'(" end=")" contains=ALL
syn region pgsqlFunction	start="utf8_to_iso8859'(" end=")" contains=ALL
syn region pgsqlFunction	start="utf8_to_johab'(" end=")" contains=ALL
syn region pgsqlFunction	start="utf8_to_koi8r'(" end=")" contains=ALL
syn region pgsqlFunction	start="utf8_to_koi8u'(" end=")" contains=ALL
syn region pgsqlFunction	start="utf8_to_shift_jis_2004'(" end=")" contains=ALL
syn region pgsqlFunction	start="utf8_to_sjis'(" end=")" contains=ALL
syn region pgsqlFunction	start="utf8_to_uhc'(" end=")" contains=ALL
syn region pgsqlFunction	start="utf8_to_win'(" end=")" contains=ALL
syn region pgsqlFunction	start="uuid_cmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="uuid_eq'(" end=")" contains=ALL
syn region pgsqlFunction	start="uuid_ge'(" end=")" contains=ALL
syn region pgsqlFunction	start="uuid_gt'(" end=")" contains=ALL
syn region pgsqlFunction	start="uuid_hash'(" end=")" contains=ALL
syn region pgsqlFunction	start="uuid_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="uuid_le'(" end=")" contains=ALL
syn region pgsqlFunction	start="uuid_lt'(" end=")" contains=ALL
syn region pgsqlFunction	start="uuid_ne'(" end=")" contains=ALL
syn region pgsqlFunction	start="uuid_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="uuid_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="uuid_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="varbitcmp'(" end=")" contains=ALL
syn region pgsqlFunction	start="varbit'(" end=")" contains=ALL
syn region pgsqlFunction	start="varbiteq'(" end=")" contains=ALL
syn region pgsqlFunction	start="varbitge'(" end=")" contains=ALL
syn region pgsqlFunction	start="varbitgt'(" end=")" contains=ALL
syn region pgsqlFunction	start="varbit_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="varbitle'(" end=")" contains=ALL
syn region pgsqlFunction	start="varbitlt'(" end=")" contains=ALL
syn region pgsqlFunction	start="varbitne'(" end=")" contains=ALL
syn region pgsqlFunction	start="varbit_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="varbit_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="varbit_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="varbittypmodin'(" end=")" contains=ALL
syn region pgsqlFunction	start="varbittypmodout'(" end=")" contains=ALL
syn region pgsqlFunction	start="varchar'(" end=")" contains=ALL
syn region pgsqlFunction	start="varcharin'(" end=")" contains=ALL
syn region pgsqlFunction	start="varcharout'(" end=")" contains=ALL
syn region pgsqlFunction	start="varcharrecv'(" end=")" contains=ALL
syn region pgsqlFunction	start="varcharsend'(" end=")" contains=ALL
syn region pgsqlFunction	start="varchartypmodin'(" end=")" contains=ALL
syn region pgsqlFunction	start="varchartypmodout'(" end=")" contains=ALL
syn region pgsqlFunction	start="variance'(" end=")" contains=ALL
syn region pgsqlFunction	start="var_pop'(" end=")" contains=ALL
syn region pgsqlFunction	start="var_samp'(" end=")" contains=ALL
syn region pgsqlFunction	start="version'(" end=")" contains=ALL
syn region pgsqlFunction	start="void_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="void_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="width_bucket'(" end=")" contains=ALL
syn region pgsqlFunction	start="width'(" end=")" contains=ALL
syn region pgsqlFunction	start="win1250_to_latin2'(" end=")" contains=ALL
syn region pgsqlFunction	start="win1250_to_mic'(" end=")" contains=ALL
syn region pgsqlFunction	start="win1251_to_iso'(" end=")" contains=ALL
syn region pgsqlFunction	start="win1251_to_koi8r'(" end=")" contains=ALL
syn region pgsqlFunction	start="win1251_to_mic'(" end=")" contains=ALL
syn region pgsqlFunction	start="win1251_to_win866'(" end=")" contains=ALL
syn region pgsqlFunction	start="win866_to_iso'(" end=")" contains=ALL
syn region pgsqlFunction	start="win866_to_koi8r'(" end=")" contains=ALL
syn region pgsqlFunction	start="win866_to_mic'(" end=")" contains=ALL
syn region pgsqlFunction	start="win866_to_win1251'(" end=")" contains=ALL
syn region pgsqlFunction	start="win_to_utf8'(" end=")" contains=ALL
syn region pgsqlFunction	start="xideq'(" end=")" contains=ALL
syn region pgsqlFunction	start="xideqint4'(" end=")" contains=ALL
syn region pgsqlFunction	start="xidin'(" end=")" contains=ALL
syn region pgsqlFunction	start="xidout'(" end=")" contains=ALL
syn region pgsqlFunction	start="xidrecv'(" end=")" contains=ALL
syn region pgsqlFunction	start="xidsend'(" end=")" contains=ALL
syn region pgsqlFunction	start="xmlagg'(" end=")" contains=ALL
syn region pgsqlFunction	start="xmlcomment'(" end=")" contains=ALL
syn region pgsqlFunction	start="xmlconcat2'(" end=")" contains=ALL
syn region pgsqlFunction	start="xml'(" end=")" contains=ALL
syn region pgsqlFunction	start="xml_in'(" end=")" contains=ALL
syn region pgsqlFunction	start="xml_out'(" end=")" contains=ALL
syn region pgsqlFunction	start="xml_recv'(" end=")" contains=ALL
syn region pgsqlFunction	start="xml_send'(" end=")" contains=ALL
syn region pgsqlFunction	start="xmlvalidate'(" end=")" contains=ALL
syn region pgsqlFunction	start="xpath'(" end=")" contains=ALL
" }}}

" Section: Definition {{{1
" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_pgsql_syn_inits")
  if version < 508
    let did_pgsql_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink pgsqlKeyword		Statement
  HiLink pgsqlConstant		Constant
  HiLink pgsqlString		String
  HiLink pgsqlNumber		Number
  HiLink pgsqlVariable		Identifier
  HiLink pgsqlComment		Comment
  HiLink pgsqlType			Type
  HiLink pgsqlOperator		Statement
  HiLink pgsqlFlow			Statement
  HiLink pgsqlFunction		Function
  HiLink pgsqlLabel			Label
  HiLink pgsqlExtschema		Special
  HiLink pgsqlTodo			Todo
  HiLink pgsqlIdentifier	Normal
  HiLink pgsqlCopy			Normal
  HiLink pgsqlBackslash		Special
  delcommand HiLink
endif
" }}}

let b:current_syntax = "pgsql"

" Section: Modelines {{{1
" vim600: set foldmethod=marker foldlevel=0 :

endif
