if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'cql') == -1

" Vim syntax file
" Language:     cql
" Maintainer:   Eric Lubow <eric@lubow.org
" Filenames:    *.cql
" URL:          https://github.com/elubow/cql-vim
" Note:

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Always ignore case
syn case ignore

" General keywords which don't fall into other categories
syn keyword cqlKeyword         apply and batch
syn keyword cqlKeyword         column columnfamily create delete drop
syn keyword cqlKeyword         family first from
syn keyword cqlKeyword         in index insert into
syn keyword cqlKeyword         limit key keyspace
syn keyword cqlKeyword         on or primary reversed
syn keyword cqlKeyword         select set truncate
syn keyword cqlKeyword         where with update use using values
syn keyword cqlKeyword         asc desc

" CQL 3 additions
syn keyword cqlKeyword         table order by type if exists not frozen


" Column family/table options
syn keyword cqlKeyword          comparator key_cache_size row_cache_size read_repair_chance
syn keyword cqlKeyword          gc_grace_seconds default_validation min_compaction_threshold
syn keyword cqlKeyword          max_compaction_threshold row_cache_save_period_in_seconds
syn keyword cqlKeyword          key_cache_save_period_in_seconds memtable_flush_after_mins
syn keyword cqlKeyword          memtable_throughput_in_mb memtable_operations_in_millions replication_on_write
syn keyword cqlKeyword          replication_on_write default_validation_class key_validation_class
syn keyword cqlKeyword          rows_cached row_cache_save_period row_cache_keys_to_save keys_cached
syn keyword cqlKeyword          column_type key_cache_save_period gc_grace replicate_on_write
syn keyword cqlKeyword          row_cache_provider compaction_strategy column_metadata
syn keyword cqlKeyword          column_name validation_class subcomparator replication
syn keyword cqlKeyword          index_name index_type caching dclocal_read_repair_chance
syn keyword cqlKeyword          bloom_filter_fp_chance populate_io_cache_on_flush compaction
syn keyword cqlKeyword          compression class sstable_compression

" CQL 3 additions
syn keyword cqlKeyword          clustering

" Keyspace options
syn keyword cqlKeyword          placement_strategy strategy_options durable_writes replication_factor
syn keyword cqlKeyword          strategy_class

" Hadoop keywords
syn keyword cqlKeyword          currentJobTracker


" TODO Fix to use regions properly
syn keyword cqlColType          standard super
syn region cqlColumnType        start="column_type\W" end="\"'" contains=cqlColType

" TODO Fix to use regions properly
syn keyword cqlPStrategy        simplestrategy localstrategy networktopologystrategy
syn region cqlPlacementStrategy start="placement_strategy\W" end="\"'" contains=cqlPlaceStrategy

" Comments highlight the word as a keyword and comment as blue
syn region cqlKeyword start=/comment\s*=\s*'/ end=/'/ contains=cqlComment
syn region cqlKeyword start=/comment\s*=\s*"/ end=/"/ contains=cqlComment
syn region cqlComment start="/\*" end="\*/" contains=cqlComment
syn match cqlComment /'\zs\%(\\.\|[^\\']\)*\ze'/ contained
syn match cqlComment /"\zs\%(\\.\|[^\\"]\)*\ze"/ contained
syn match cqlComment "--.*$" contains=cqlComment
syn match cqlComment "//.*$" contains=cqlComment
syn match cqlComment "/\*\*/" 

" Special values
syn keyword cqlSpecial         false null true

" TODO Add ability to include entire Java class name for compaction strategies
syn keyword cqlType            SizeTieredCompactionStrategy LeveledCompactionStrategy

" Variable Types
syn keyword cqlType     bytea ascii text varchar uuid inet varint int bigint tinyint smallint
syn keyword cqlType     bytestype utf8type timeuuidtype timeuuid timestamp date time duration
syn keyword cqlType     blob boolean counter decimal double float
syn keyword cqlType     serializingcacheprovider
syn keyword cqlType     set list map tuple

" Consistency Levels
syn region cqlType      start="consistency" end="zero"
syn region cqlType      start="consistency" end="one"
syn region cqlType      start="consistency" end="quorum"
syn region cqlType      start="consistency" end="all"
syn region cqlType      start="consistency" end="local_quorum"
syn region cqlType      start="consistency" end="each_quorum"

" Numbers and hexidecimal values
syn match cqlNumber            "-\=\<[0-9]*\>"
syn match cqlNumber            "-\=\<[0-9]*\.[0-9]*\>"
syn match cqlNumber            "-\=\<[0-9][0-9]*e[+-]\=[0-9]*\>"
syn match cqlNumber            "-\=\<[0-9]*\.[0-9]*e[+-]\=[0-9]*\>"
syn match cqlNumber            "\<0x[abcdefABCDEF0-9]*\>"

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_cql_syn_inits")
  if version < 508
    let did_cql_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink cqlKeyword            Statement
  HiLink cqlSpecial            Special
  HiLink cqlString             String
  HiLink cqlNumber             Number
  HiLink cqlVariable           Identifier
  HiLink cqlComment            Comment
  HiLink cqlType               Type
  HiLink cqlOperator           Statement
  HiLink cqlConsistency        Statement
  HiLink cqlColType            Type
  HiLink cqlPStrategy          Type

  delcommand HiLink
endif

let b:current_syntax = "cql"


endif
