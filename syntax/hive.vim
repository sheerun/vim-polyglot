if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'hive') == -1

" Vim syntax file
" Language: HIVE Query Language
" Maintainer: German Lashevich <german.lashevich@gmail.com>
" Last Change: 2019-04-30

if exists("b:current_syntax")
  finish
endif

syn case ignore

syn keyword sqlSpecial  false null true

syn keyword sqlKeyword access add as asc begin check cluster column
syn keyword sqlKeyword compress connect current cursor decimal default desc
syn keyword sqlKeyword if else elsif end exception exclusive file for from
syn keyword sqlKeyword function having identified immediate increment
syn keyword sqlKeyword index initial into level loop maxextents mode modify
syn keyword sqlKeyword nocompress nowait of offline on online start
syn keyword sqlKeyword successful synonym table partition then to trigger uid
syn keyword sqlKeyword unique user validate values view whenever hivevar
syn keyword sqlKeyword where with option pctfree privileges procedure limit
syn keyword sqlKeyword public resource return row rowlabel rownum rows
syn keyword sqlKeyword session share size smallint type using cross full outer left join right inner
syn keyword sqlKeyword format delimited fields terminated collection items external window msck repair
syn keyword sqlKeyword stored sequencefile partitioned data local inpath overwrite clustered buckets sorted
syn keyword sqlKeyword keys extended textfile location distribute directory tablesample using reduce lateral
syn keyword sqlKeyword case when database serde serdeproperties inputformat outputformat over
syn keyword sqlKeyword unbounded preceding parquet tblproperties

syn keyword sqlKeyword dmin after archive before bucket cascade change
syn keyword sqlKeyword lusterstatus columns compact compactions compute
syn keyword sqlKeyword oncatenate continue databases datetime dbproperties
syn keyword sqlKeyword eferred defined dependency directories disable elem_type
syn keyword sqlKeyword nable escaped export fileformat first formatted
syn keyword sqlKeyword unctions hold_ddltime idxproperties ignore indexes
syn keyword sqlKeyword nputdriver jar key_type lines locks logical long mapjoin
syn keyword sqlKeyword aterialized metadata noscan no_drop outputdriver owner
syn keyword sqlKeyword artitions plus pretty principals protection purge read
syn keyword sqlKeyword eadonly rebuild recordreader recordwriter reload replace
syn keyword sqlKeyword eplication restrict rewrite role roles schema schemas
syn keyword sqlKeyword emi server sets shared show show_database skewed sort
syn keyword sqlKeyword sl statistics streamtable tables temporary touch
syn keyword sqlKeyword ransactions unarchive undo uniontype unlock unset
syn keyword sqlKeyword nsigned uri utc utctimestamp value_type while
syn keyword sqlKeyword uthorization both by conf cube current_timestamp
syn keyword sqlKeyword xchange fetch following group grouping import interval
syn keyword sqlKeyword ess macro more none order partialscan percent preserve
syn keyword sqlKeyword ange reads rollup uniquejoin utc_tmestamp autocommit
syn keyword sqlKeyword solation offset snapshot transaction work write only
syn keyword sqlKeyword bort key last norely novalidate nulls rely cache
syn keyword sqlKeyword onstraint foreign primary references detail dow
syn keyword sqlKeyword xpression operator quarter summary vectorization week
syn keyword sqlKeyword ears months weeks days hours minutes seconds dayofweek
syn keyword sqlKeyword xtract integer precision views timestamptz zone time
syn keyword sqlKeyword umeric sync

syn match sqlKeyword 'group\s\+by'
syn match sqlKeyword 'order\s\+by'

syn keyword sqlOperator not and or < <= == >= > <> != is
syn keyword sqlOperator in any some all between exists
syn keyword sqlOperator like escape rlike regexp
syn keyword sqlOperator union intersect minus
syn keyword sqlOperator prior distinct isnull count
syn keyword sqlOperator sysdate out
syn keyword sqlOperator round floor ceil rand concat substr upper ucase
syn keyword sqlOperator lower lcase trim ltrim rtrim regexp_replace size
syn keyword sqlOperator coalesce cast from_unixtime to_date year month day get_json_object
syn keyword sqlOperator current_date add_months row_number date_format first_value
syn keyword sqlOperator sum avg min max transform
syn keyword sqlOperator variance var_samp stddev_pop stddev_samp
syn keyword sqlOperator covar_pop covar_samp corr percentile percentil_approx
syn keyword sqlOperator histogram_numeric collect_set inline explode
syn keyword sqlOperator exp ln log10 log2 log pow sqrt bin hex unhex conv
syn keyword sqlOperator abs pmod sin asin cos acos tan atan degrees radians
syn keyword sqlOperator positive negative sign e pi binary
syn keyword sqlOperator map_keys map_values array_contains sort_array
syn keyword sqlOperator unix_timestamp dayofmonth hour minute second weekofyear
syn keyword sqlOperator datediff date_add date_sub from_utc_timestamp to_utc_timestamp
syn keyword sqlOperator ascii context_ngrams concate_ws find_in_set format_number
syn keyword sqlOperator in_file instr length locate lpad ltrim ngrams parse_url
syn keyword sqlOperator printf regexp_extract repeat reverse rpad trim sentences
syn keyword sqlOperator space split str_to_map translate trim java_method reflect
syn keyword sqlOperator xpath xpath_string xpath_boolean xpath_short xpath_int xpath_long xpath_float xpath_double xpath_number

syn keyword sqlStatement alter analyze audit comment commit create
syn keyword sqlStatement delete drop execute explain grant insert lock noaudit
syn keyword sqlStatement rename revoke rollback savepoint select set
syn keyword sqlStatement truncate update describe load use

syn keyword sqlType tinyint smallint int bigint float double boolean string
syn keyword sqlType array map struct named_struct create_union timestamp date varchar char

syn match hiveVar     "hive\.[a-zA-Z.]\+"
syn match hiveVar     "mapred\.[a-zA-Z.]\+"

" Strings and characters:
syn region sqlString  start=+"+  skip=+\\\\\|\\"+  end=+"+
syn region sqlString  start=+'+  skip=+\\\\\|\\'+  end=+'+

" Numbers:
syn match sqlNumber  "[-+]\=\d\+[ISL]\="
" Floating point number with decimal no E or e
syn match sqlNumber '[-+]\=\d\+\.\d\+'
" Floating point like number with E and no decimal point (+,-)
syn match sqlNumber '[-+]\=\d[[:digit:]]*[eE][\-+]\=\d\+'
syn match sqlNumber '\d[[:digit:]]*[eE][\-+]\=\d\+'
" Floating point like number with E and decimal point (+,-)
syn match sqlNumber '[-+]\=\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+'
syn match sqlNumber '\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+'

" Comments:
syn region sqlComment    start="/\*"  end="\*/" contains=sqlTodo
syn match sqlComment "--.*$" contains=sqlTodo

syn sync ccomment sqlComment

" Todo
syn keyword sqlTodo contained TODO FIXME XXX DEBUG NOTE

hi link sqlComment Comment
hi link sqlKeyword Identifier
hi link sqlNumber Number
hi link sqlOperator Constant
hi link sqlSpecial Special
hi link sqlStatement Statement
hi link sqlString String
hi link sqlType Type
hi link sqlTodo Todo
hi link hiveVar Special

let b:current_syntax = "hive"

" vim: ts=4

endif
