if polyglot#init#is_disabled(expand('<sfile>:p'), 'pgsql', 'syntax/pgsql.vim')
  finish
endif

" Vim syntax file
" Language:     SQL (PostgreSQL dialect), PL/pgSQL, PL/…, PostGIS, …
" Maintainer:   Lifepillar
" Version:      2.3.1
" License:      Vim license (see `:help license`)

" Based on PostgreSQL 13.2
" Automatically generated on 2021-04-22 at 08:36:13

if exists("b:current_syntax")
  finish
endif

syn case ignore
syn sync minlines=100
if has('patch-7.4.1142')
  syn iskeyword @,48-57,192-255,_
else
  setlocal iskeyword=@,48-57,192-255,_
endif

syn match sqlIsKeyword  /\<\h\w*\>/   contains=sqlStatement,sqlKeyword,sqlCatalog,sqlConstant,sqlSpecial,sqlOption,sqlErrorCode,sqlType,sqlTable,sqlView
syn match sqlIsFunction /\<\h\w*\ze(/ contains=sqlFunction,sqlKeyword,sqlType
syn region sqlIsPsql    start=/^\s*\\/ end=/\n/ oneline contains=sqlPsqlCommand,sqlPsqlKeyword,sqlNumber,sqlString

syn keyword sqlSpecial contained false null true

" Statements
syn keyword sqlStatement contained abort add alter analyze begin checkpoint close cluster comment
syn keyword sqlStatement contained commit constraints copy deallocate declare delete discard do drop end
syn keyword sqlStatement contained execute explain fetch grant import insert label listen load lock move
syn keyword sqlStatement contained notify prepare prepared reassign refresh reindex release reset revoke
syn keyword sqlStatement contained rollback savepoint security select select set show start transaction
syn keyword sqlStatement contained truncate unlisten update vacuum values work
syn match sqlStatement contained /\<create\%(\_s\+or\_s\+replace\)\=\>/
" Types
syn keyword sqlType contained aclitem addbandarg addr addr_gid_seq addrfeat addrfeat_gid_seq
syn keyword sqlType contained agg_count agg_samealignment anyarray anycompatible
syn keyword sqlType contained anycompatiblearray anycompatiblenonarray anycompatiblerange anyelement
syn keyword sqlType contained anyenum anynonarray anyrange bg bg_gid_seq bit bool box box2d box2df box3d
syn keyword sqlType contained bpchar bytea cardinal_number char character_data cid cidr circle
syn keyword sqlType contained citext county county_gid_seq county_lookup countysub_lookup cousub
syn keyword sqlType contained cousub_gid_seq cstring cube date daterange dblink_pkey_results
syn keyword sqlType contained direction_lookup ean13 earth edges edges_gid_seq errcodes
syn keyword sqlType contained event_trigger faces faces_gid_seq fdw_handler featnames featnames_gid_seq
syn keyword sqlType contained float4 float8 gbtreekey16 gbtreekey32 gbtreekey4 gbtreekey8
syn keyword sqlType contained gbtreekey_var geocode_settings geocode_settings_default geography
syn keyword sqlType contained geography_columns geometry geometry_columns geometry_dump geomval
syn keyword sqlType contained getfaceedges_returntype ghstore gidx gtrgm gtsvector hstore
syn keyword sqlType contained index_am_handler inet int2 int2vector int4 int4range int8 int8range
syn keyword sqlType contained intbig_gkey internal interval isbn isbn13 ismn ismn13 issn issn13 json
syn keyword sqlType contained jsonb jsonpath language_handler layer line lo loader_lookuptables
syn keyword sqlType contained loader_platform loader_variables lquery lseg ltree ltree_gist
syn keyword sqlType contained ltxtquery macaddr macaddr8 money norm_addy numeric numrange oid
syn keyword sqlType contained oidvector pagc_gaz pagc_gaz_id_seq pagc_lex pagc_lex_id_seq pagc_rules
syn keyword sqlType contained pagc_rules_id_seq path pg_all_foreign_keys pg_ddl_command
syn keyword sqlType contained pg_dependencies pg_lsn pg_mcv_list pg_ndistinct pg_node_tree
syn keyword sqlType contained pg_snapshot place place_gid_seq place_lookup point polygon query_int
syn keyword sqlType contained rastbandarg raster raster_columns raster_overviews reclassarg record
syn keyword sqlType contained refcursor regclass regcollation regconfig regdictionary
syn keyword sqlType contained regnamespace regoper regoperator regproc regprocedure regrole regtype
syn keyword sqlType contained secondary_unit_lookup seg spatial_ref_sys spheroid sql_identifier state
syn keyword sqlType contained state_gid_seq state_lookup stdaddr street_type_lookup
syn keyword sqlType contained summarystats tabblock tabblock_gid_seq table_am_handler
syn keyword sqlType contained tablefunc_crosstab_2 tablefunc_crosstab_3 tablefunc_crosstab_4 tap_funky text
syn keyword sqlType contained tid time time_stamp timestamp timestamptz timetz topoelement
syn keyword sqlType contained topoelementarray topogeometry topology topology_id_seq tract
syn keyword sqlType contained tract_gid_seq tsm_handler tsquery tsrange tstzrange tsvector txid_snapshot
syn keyword sqlType contained unionarg upc us_gaz us_gaz_id_seq us_lex us_lex_id_seq us_rules
syn keyword sqlType contained us_rules_id_seq uuid valid_detail validatetopology_returntype
syn keyword sqlType contained varbit varchar void xid xid8 xml yes_or_no zcta5 zcta5_gid_seq
syn keyword sqlType contained zip_lookup zip_lookup_all zip_lookup_base zip_state zip_state_loc
syn match sqlType /\<pg_toast_\d\+\>/
syn match sqlType /\<time\%[stamp]\s\+with\%[out]\>/
syn match sqlKeyword /\<with\s\+grant\>/
syn match sqlKeyword /\<on\s\+\%(tables\|sequences\|routines\)\>/
syn match sqlType /\<text\>/
syn match sqlKeyword /\<text\s\+search\>/
" Additional types
syn keyword sqlType contained array at bigint bigserial bit boolean character cube decimal double
syn keyword sqlType contained int integer interval numeric precision real serial serial2 serial4
syn keyword sqlType contained serial8 smallint smallserial timestamp varying xml zone
" Keywords
syn keyword sqlKeyword contained absolute access action admin after aggregate all also always
syn keyword sqlKeyword contained analyse and any as asc assertion assignment asymmetric attach attribute
syn keyword sqlKeyword contained authorization backward basetype before between binary both by
syn keyword sqlKeyword contained bypassrls cache call called cascade cascaded case cast catalog century chain
syn keyword sqlKeyword contained characteristics check class coalesce collate collation column
syn keyword sqlKeyword contained columns combinefunc comments committed concurrently configuration
syn keyword sqlKeyword contained conflict connection constraint content continue conversion cost
syn keyword sqlKeyword contained createdb createrole cross csv current current_catalog current_date
syn keyword sqlKeyword contained current_role current_schema current_time current_timestamp
syn keyword sqlKeyword contained current_user cursor cycle data database day dec decade default defaults
syn keyword sqlKeyword contained deferrable deferred definer delimiter delimiters depends desc
syn keyword sqlKeyword contained deserialfunc detach dictionary disable distinct document domain dow doy each
syn keyword sqlKeyword contained else enable encoding encrypted enum epoch escape event except exclude
syn keyword sqlKeyword contained excluding exclusive exists expression extension external extract
syn keyword sqlKeyword contained false family filter finalfunc finalfunc_extra finalfunc_modify
syn keyword sqlKeyword contained first float following for force foreign forward freeze from full function
syn keyword sqlKeyword contained functions generated global granted greatest group grouping groups
syn keyword sqlKeyword contained handler having header hold hour hypothetical identity if ilike
syn keyword sqlKeyword contained immediate immutable implicit in include including increment index indexes
syn keyword sqlKeyword contained inherit inherits initcond initially inline inner inout input
syn keyword sqlKeyword contained insensitive instead intersect into invoker is isnull isodow isolation
syn keyword sqlKeyword contained isoyear join key language large last lateral lc_collate lc_ctype leading
syn keyword sqlKeyword contained leakproof least left level like limit local locale localtime
syn keyword sqlKeyword contained localtimestamp location locked logged login mapping match materialized
syn keyword sqlKeyword contained maxvalue method mfinalfunc mfinalfunc_extra mfinalfunc_modify
syn keyword sqlKeyword contained microseconds millennium milliseconds minitcond minute minvalue
syn keyword sqlKeyword contained minvfunc mode month msfunc msspace mstype name names national natural nchar
syn keyword sqlKeyword contained new next nfc nfd nfkc nfkd no nobypassrls nocreatedb nocreaterole
syn keyword sqlKeyword contained noinherit nologin none noreplication normalize normalized nosuperuser
syn keyword sqlKeyword contained not nothing notnull nowait null nullif nulls object of off offset oids
syn keyword sqlKeyword contained old on only operator option options or order ordinality others out
syn keyword sqlKeyword contained outer over overlaps overlay overriding owned owner parallel parser
syn keyword sqlKeyword contained partial partition passing password permissive placing plans policy
syn keyword sqlKeyword contained position preceding preserve primary prior privileges procedural
syn keyword sqlKeyword contained procedure procedures program provider public publication quarter quote
syn keyword sqlKeyword contained range read read_write readonly recheck recursive ref references
syn keyword sqlKeyword contained referencing relative rename repeatable replace replica replication
syn keyword sqlKeyword contained restart restrict restricted restrictive returning returns right role
syn keyword sqlKeyword contained rollup routine routines row rows rule safe schema schemas scroll search
syn keyword sqlKeyword contained second sequence sequences serialfunc serializable server session
syn keyword sqlKeyword contained session_user setof sets sfunc share shareable similar simple skip
syn keyword sqlKeyword contained snapshot some sortop sql sspace stable standalone statement statistics
syn keyword sqlKeyword contained stdin stdout storage stored strict strip stype subscription
syn keyword sqlKeyword contained substring superuser support symmetric sysid system table tables
syn keyword sqlKeyword contained tablesample tablespace temp template temporary then ties timezone
syn keyword sqlKeyword contained timezone_hour timezone_minute to trailing transform treat trigger trim true
syn keyword sqlKeyword contained trusted type types uescape unbounded uncommitted unencrypted union
syn keyword sqlKeyword contained unique unknown unlogged unsafe until usage user using valid validate
syn keyword sqlKeyword contained validator value variadic verbose version view views volatile week when
syn keyword sqlKeyword contained where whitespace window with within without wrapper write
syn keyword sqlKeyword contained xmlattributes xmlconcat xmlelement xmlexists xmlforest xmlnamespaces
syn keyword sqlKeyword contained xmlparse xmlpi xmlroot xmlserialize xmltable year yes
syn keyword sqlConstant contained information_schema pg_catalog
" Built-in functions
syn keyword sqlFunction contained RI_FKey_cascade_del RI_FKey_cascade_upd RI_FKey_check_ins
syn keyword sqlFunction contained RI_FKey_check_upd RI_FKey_noaction_del RI_FKey_noaction_upd
syn keyword sqlFunction contained RI_FKey_restrict_del RI_FKey_restrict_upd RI_FKey_setdefault_del
syn keyword sqlFunction contained RI_FKey_setdefault_upd RI_FKey_setnull_del RI_FKey_setnull_upd
syn keyword sqlFunction contained abbrev abs aclcontains acldefault aclexplode aclinsert aclitemeq
syn keyword sqlFunction contained aclitemin aclitemout aclremove acos acosd acosh age amvalidate any_in
syn keyword sqlFunction contained any_out anyarray_in anyarray_out anyarray_recv anyarray_send
syn keyword sqlFunction contained anycompatible_in anycompatible_out anycompatiblearray_in
syn keyword sqlFunction contained anycompatiblearray_out anycompatiblearray_recv
syn keyword sqlFunction contained anycompatiblearray_send anycompatiblenonarray_in anycompatiblenonarray_out
syn keyword sqlFunction contained anycompatiblerange_in anycompatiblerange_out anyelement_in
syn keyword sqlFunction contained anyelement_out anyenum_in anyenum_out anynonarray_in anynonarray_out
syn keyword sqlFunction contained anyrange_in anyrange_out anytextcat area areajoinsel areasel array_agg
syn keyword sqlFunction contained array_agg_array_finalfn array_agg_array_transfn
syn keyword sqlFunction contained array_agg_finalfn array_agg_transfn array_append array_cat array_dims array_eq
syn keyword sqlFunction contained array_fill array_ge array_gt array_in array_larger array_le
syn keyword sqlFunction contained array_length array_lower array_lt array_ndims array_ne array_out
syn keyword sqlFunction contained array_position array_positions array_prepend array_recv array_remove
syn keyword sqlFunction contained array_replace array_send array_smaller array_to_json
syn keyword sqlFunction contained array_to_string array_to_tsvector array_typanalyze array_unnest_support
syn keyword sqlFunction contained array_upper arraycontained arraycontains arraycontjoinsel
syn keyword sqlFunction contained arraycontsel arrayoverlap ascii asin asind asinh atan atan2 atan2d atand
syn keyword sqlFunction contained atanh avg bernoulli big5_to_euc_tw big5_to_mic big5_to_utf8
syn keyword sqlFunction contained binary_upgrade_create_empty_extension
syn keyword sqlFunction contained binary_upgrade_set_missing_value binary_upgrade_set_next_array_pg_type_oid
syn keyword sqlFunction contained binary_upgrade_set_next_heap_pg_class_oid
syn keyword sqlFunction contained binary_upgrade_set_next_index_pg_class_oid binary_upgrade_set_next_pg_authid_oid
syn keyword sqlFunction contained binary_upgrade_set_next_pg_enum_oid binary_upgrade_set_next_pg_type_oid
syn keyword sqlFunction contained binary_upgrade_set_next_toast_pg_class_oid
syn keyword sqlFunction contained binary_upgrade_set_next_toast_pg_type_oid binary_upgrade_set_record_init_privs
syn keyword sqlFunction contained bit bit_and bit_in bit_length bit_or bit_out bit_recv bit_send bitand
syn keyword sqlFunction contained bitcat bitcmp biteq bitge bitgt bitle bitlt bitne bitnot bitor
syn keyword sqlFunction contained bitshiftleft bitshiftright bittypmodin bittypmodout bitxor bool
syn keyword sqlFunction contained bool_accum bool_accum_inv bool_alltrue bool_and bool_anytrue bool_or
syn keyword sqlFunction contained booland_statefunc booleq boolge boolgt boolin boolle boollt boolne
syn keyword sqlFunction contained boolor_statefunc boolout boolrecv boolsend bound_box box box_above
syn keyword sqlFunction contained box_above_eq box_add box_below box_below_eq box_center box_contain
syn keyword sqlFunction contained box_contain_pt box_contained box_distance box_div box_eq box_ge
syn keyword sqlFunction contained box_gt box_in box_intersect box_le box_left box_lt box_mul box_out
syn keyword sqlFunction contained box_overabove box_overbelow box_overlap box_overleft
syn keyword sqlFunction contained box_overright box_recv box_right box_same box_send box_sub bpchar
syn keyword sqlFunction contained bpchar_larger bpchar_pattern_ge bpchar_pattern_gt bpchar_pattern_le
syn keyword sqlFunction contained bpchar_pattern_lt bpchar_smaller bpchar_sortsupport bpcharcmp
syn keyword sqlFunction contained bpchareq bpcharge bpchargt bpchariclike bpcharicnlike bpcharicregexeq
syn keyword sqlFunction contained bpcharicregexne bpcharin bpcharle bpcharlike bpcharlt bpcharne
syn keyword sqlFunction contained bpcharnlike bpcharout bpcharrecv bpcharregexeq bpcharregexne
syn keyword sqlFunction contained bpcharsend bpchartypmodin bpchartypmodout brin_desummarize_range
syn keyword sqlFunction contained brin_inclusion_add_value brin_inclusion_consistent
syn keyword sqlFunction contained brin_inclusion_opcinfo brin_inclusion_union brin_minmax_add_value
syn keyword sqlFunction contained brin_minmax_consistent brin_minmax_opcinfo brin_minmax_union
syn keyword sqlFunction contained brin_summarize_new_values brin_summarize_range brinhandler broadcast
syn keyword sqlFunction contained btarraycmp btboolcmp btbpchar_pattern_cmp
syn keyword sqlFunction contained btbpchar_pattern_sortsupport btcharcmp btequalimage btfloat48cmp btfloat4cmp
syn keyword sqlFunction contained btfloat4sortsupport btfloat84cmp btfloat8cmp btfloat8sortsupport bthandler
syn keyword sqlFunction contained btint24cmp btint28cmp btint2cmp btint2sortsupport btint42cmp
syn keyword sqlFunction contained btint48cmp btint4cmp btint4sortsupport btint82cmp btint84cmp
syn keyword sqlFunction contained btint8cmp btint8sortsupport btnamecmp btnamesortsupport btnametextcmp
syn keyword sqlFunction contained btoidcmp btoidsortsupport btoidvectorcmp btrecordcmp
syn keyword sqlFunction contained btrecordimagecmp btrim bttext_pattern_cmp bttext_pattern_sortsupport
syn keyword sqlFunction contained bttextcmp bttextnamecmp bttextsortsupport bttidcmp btvarstrequalimage
syn keyword sqlFunction contained bytea_sortsupport bytea_string_agg_finalfn
syn keyword sqlFunction contained bytea_string_agg_transfn byteacat byteacmp byteaeq byteage byteagt byteain byteale
syn keyword sqlFunction contained bytealike bytealt byteane byteanlike byteaout bytearecv byteasend
syn keyword sqlFunction contained cardinality cash_cmp cash_div_cash cash_div_flt4 cash_div_flt8
syn keyword sqlFunction contained cash_div_int2 cash_div_int4 cash_div_int8 cash_eq cash_ge cash_gt
syn keyword sqlFunction contained cash_in cash_le cash_lt cash_mi cash_mul_flt4 cash_mul_flt8
syn keyword sqlFunction contained cash_mul_int2 cash_mul_int4 cash_mul_int8 cash_ne cash_out cash_pl
syn keyword sqlFunction contained cash_recv cash_send cash_words cashlarger cashsmaller cbrt ceil ceiling
syn keyword sqlFunction contained center char_length character_length chareq charge chargt charin
syn keyword sqlFunction contained charle charlt charne charout charrecv charsend chr cideq cidin cidout
syn keyword sqlFunction contained cidr cidr_in cidr_out cidr_recv cidr_send cidrecv cidsend circle
syn keyword sqlFunction contained circle_above circle_add_pt circle_below circle_center
syn keyword sqlFunction contained circle_contain circle_contain_pt circle_contained circle_distance
syn keyword sqlFunction contained circle_div_pt circle_eq circle_ge circle_gt circle_in circle_le
syn keyword sqlFunction contained circle_left circle_lt circle_mul_pt circle_ne circle_out circle_overabove
syn keyword sqlFunction contained circle_overbelow circle_overlap circle_overleft
syn keyword sqlFunction contained circle_overright circle_recv circle_right circle_same circle_send circle_sub_pt
syn keyword sqlFunction contained clock_timestamp close_lb close_ls close_lseg close_pb close_pl
syn keyword sqlFunction contained close_ps close_sb close_sl col_description concat concat_ws
syn keyword sqlFunction contained contjoinsel contsel convert convert_from convert_to corr cos cosd cosh cot
syn keyword sqlFunction contained cotd count covar_pop covar_samp cstring_in cstring_out
syn keyword sqlFunction contained cstring_recv cstring_send cume_dist cume_dist_final current_database
syn keyword sqlFunction contained current_query current_schema current_schemas current_setting
syn keyword sqlFunction contained current_user currtid currtid2 currval cursor_to_xml cursor_to_xmlschema
syn keyword sqlFunction contained database_to_xml database_to_xml_and_xmlschema
syn keyword sqlFunction contained database_to_xmlschema date date_cmp date_cmp_timestamp date_cmp_timestamptz
syn keyword sqlFunction contained date_eq date_eq_timestamp date_eq_timestamptz date_ge
syn keyword sqlFunction contained date_ge_timestamp date_ge_timestamptz date_gt date_gt_timestamp
syn keyword sqlFunction contained date_gt_timestamptz date_in date_larger date_le date_le_timestamp
syn keyword sqlFunction contained date_le_timestamptz date_lt date_lt_timestamp date_lt_timestamptz date_mi
syn keyword sqlFunction contained date_mi_interval date_mii date_ne date_ne_timestamp
syn keyword sqlFunction contained date_ne_timestamptz date_out date_part date_pl_interval date_pli date_recv
syn keyword sqlFunction contained date_send date_smaller date_sortsupport date_trunc daterange
syn keyword sqlFunction contained daterange_canonical daterange_subdiff datetime_pl datetimetz_pl
syn keyword sqlFunction contained dcbrt decode degrees dense_rank dense_rank_final dexp diagonal
syn keyword sqlFunction contained diameter dispell_init dispell_lexize dist_bl dist_bp dist_bs
syn keyword sqlFunction contained dist_cpoint dist_cpoly dist_lb dist_lp dist_ls dist_pathp dist_pb dist_pc
syn keyword sqlFunction contained dist_pl dist_polyc dist_polyp dist_ppath dist_ppoly dist_ps dist_sb
syn keyword sqlFunction contained dist_sl dist_sp div dlog1 dlog10 domain_in domain_recv dpow dround
syn keyword sqlFunction contained dsimple_init dsimple_lexize dsnowball_init dsnowball_lexize dsqrt
syn keyword sqlFunction contained dsynonym_init dsynonym_lexize dtrunc elem_contained_by_range
syn keyword sqlFunction contained encode enum_cmp enum_eq enum_first enum_ge enum_gt enum_in
syn keyword sqlFunction contained enum_larger enum_last enum_le enum_lt enum_ne enum_out enum_range enum_recv
syn keyword sqlFunction contained enum_send enum_smaller eqjoinsel eqsel euc_cn_to_mic
syn keyword sqlFunction contained euc_cn_to_utf8 euc_jis_2004_to_shift_jis_2004 euc_jis_2004_to_utf8
syn keyword sqlFunction contained euc_jp_to_mic euc_jp_to_sjis euc_jp_to_utf8 euc_kr_to_mic
syn keyword sqlFunction contained euc_kr_to_utf8 euc_tw_to_big5 euc_tw_to_mic euc_tw_to_utf8
syn keyword sqlFunction contained event_trigger_in event_trigger_out every exp factorial family fdw_handler_in
syn keyword sqlFunction contained fdw_handler_out first_value float4 float48div float48eq float48ge
syn keyword sqlFunction contained float48gt float48le float48lt float48mi float48mul float48ne
syn keyword sqlFunction contained float48pl float4_accum float4abs float4div float4eq float4ge float4gt
syn keyword sqlFunction contained float4in float4larger float4le float4lt float4mi float4mul float4ne
syn keyword sqlFunction contained float4out float4pl float4recv float4send float4smaller float4um
syn keyword sqlFunction contained float4up float8 float84div float84eq float84ge float84gt float84le
syn keyword sqlFunction contained float84lt float84mi float84mul float84ne float84pl float8_accum
syn keyword sqlFunction contained float8_avg float8_combine float8_corr float8_covar_pop
syn keyword sqlFunction contained float8_covar_samp float8_regr_accum float8_regr_avgx float8_regr_avgy
syn keyword sqlFunction contained float8_regr_combine float8_regr_intercept float8_regr_r2
syn keyword sqlFunction contained float8_regr_slope float8_regr_sxx float8_regr_sxy float8_regr_syy
syn keyword sqlFunction contained float8_stddev_pop float8_stddev_samp float8_var_pop float8_var_samp
syn keyword sqlFunction contained float8abs float8div float8eq float8ge float8gt float8in
syn keyword sqlFunction contained float8larger float8le float8lt float8mi float8mul float8ne float8out
syn keyword sqlFunction contained float8pl float8recv float8send float8smaller float8um float8up floor
syn keyword sqlFunction contained flt4_mul_cash flt8_mul_cash fmgr_c_validator
syn keyword sqlFunction contained fmgr_internal_validator fmgr_sql_validator format format_type gb18030_to_utf8
syn keyword sqlFunction contained gbk_to_utf8 gcd gen_random_uuid generate_series
syn keyword sqlFunction contained generate_series_int4_support generate_series_int8_support generate_subscripts
syn keyword sqlFunction contained get_bit get_byte get_current_ts_config getdatabaseencoding
syn keyword sqlFunction contained getpgusername gin_clean_pending_list gin_cmp_prefix gin_cmp_tslexeme
syn keyword sqlFunction contained gin_compare_jsonb gin_consistent_jsonb gin_consistent_jsonb_path
syn keyword sqlFunction contained gin_extract_jsonb gin_extract_jsonb_path
syn keyword sqlFunction contained gin_extract_jsonb_query gin_extract_jsonb_query_path gin_extract_tsquery
syn keyword sqlFunction contained gin_extract_tsvector gin_triconsistent_jsonb
syn keyword sqlFunction contained gin_triconsistent_jsonb_path gin_tsquery_consistent gin_tsquery_triconsistent
syn keyword sqlFunction contained ginarrayconsistent ginarrayextract ginarraytriconsistent ginhandler
syn keyword sqlFunction contained ginqueryarrayextract gist_box_consistent gist_box_distance
syn keyword sqlFunction contained gist_box_penalty gist_box_picksplit gist_box_same gist_box_union
syn keyword sqlFunction contained gist_circle_compress gist_circle_consistent gist_circle_distance
syn keyword sqlFunction contained gist_point_compress gist_point_consistent gist_point_distance
syn keyword sqlFunction contained gist_point_fetch gist_poly_compress gist_poly_consistent
syn keyword sqlFunction contained gist_poly_distance gisthandler gtsquery_compress gtsquery_consistent
syn keyword sqlFunction contained gtsquery_penalty gtsquery_picksplit gtsquery_same
syn keyword sqlFunction contained gtsquery_union gtsvector_compress gtsvector_consistent gtsvector_decompress
syn keyword sqlFunction contained gtsvector_options gtsvector_penalty gtsvector_picksplit
syn keyword sqlFunction contained gtsvector_same gtsvector_union gtsvectorin gtsvectorout
syn keyword sqlFunction contained has_any_column_privilege has_column_privilege has_database_privilege
syn keyword sqlFunction contained has_foreign_data_wrapper_privilege has_function_privilege
syn keyword sqlFunction contained has_language_privilege has_schema_privilege has_sequence_privilege
syn keyword sqlFunction contained has_server_privilege has_table_privilege has_tablespace_privilege
syn keyword sqlFunction contained has_type_privilege hash_aclitem hash_aclitem_extended
syn keyword sqlFunction contained hash_array hash_array_extended hash_numeric hash_numeric_extended
syn keyword sqlFunction contained hash_range hash_range_extended hashbpchar hashbpcharextended
syn keyword sqlFunction contained hashchar hashcharextended hashenum hashenumextended hashfloat4
syn keyword sqlFunction contained hashfloat4extended hashfloat8 hashfloat8extended hashhandler hashinet
syn keyword sqlFunction contained hashinetextended hashint2 hashint2extended hashint4
syn keyword sqlFunction contained hashint4extended hashint8 hashint8extended hashmacaddr hashmacaddr8
syn keyword sqlFunction contained hashmacaddr8extended hashmacaddrextended hashname hashnameextended
syn keyword sqlFunction contained hashoid hashoidextended hashoidvector hashoidvectorextended hashtext
syn keyword sqlFunction contained hashtextextended hashtid hashtidextended hashvarlena
syn keyword sqlFunction contained hashvarlenaextended heap_tableam_handler height host hostmask
syn keyword sqlFunction contained iclikejoinsel iclikesel icnlikejoinsel icnlikesel icregexeqjoinsel
syn keyword sqlFunction contained icregexeqsel icregexnejoinsel icregexnesel in_range index_am_handler_in
syn keyword sqlFunction contained index_am_handler_out inet_client_addr inet_client_port
syn keyword sqlFunction contained inet_gist_compress inet_gist_consistent inet_gist_fetch
syn keyword sqlFunction contained inet_gist_penalty inet_gist_picksplit inet_gist_same inet_gist_union inet_in
syn keyword sqlFunction contained inet_merge inet_out inet_recv inet_same_family inet_send
syn keyword sqlFunction contained inet_server_addr inet_server_port inet_spg_choose inet_spg_config
syn keyword sqlFunction contained inet_spg_inner_consistent inet_spg_leaf_consistent
syn keyword sqlFunction contained inet_spg_picksplit inetand inetmi inetmi_int8 inetnot inetor inetpl initcap int2
syn keyword sqlFunction contained int24div int24eq int24ge int24gt int24le int24lt int24mi int24mul
syn keyword sqlFunction contained int24ne int24pl int28div int28eq int28ge int28gt int28le int28lt
syn keyword sqlFunction contained int28mi int28mul int28ne int28pl int2_accum int2_accum_inv
syn keyword sqlFunction contained int2_avg_accum int2_avg_accum_inv int2_mul_cash int2_sum int2abs int2and
syn keyword sqlFunction contained int2div int2eq int2ge int2gt int2in int2int4_sum int2larger int2le
syn keyword sqlFunction contained int2lt int2mi int2mod int2mul int2ne int2not int2or int2out int2pl
syn keyword sqlFunction contained int2recv int2send int2shl int2shr int2smaller int2um int2up
syn keyword sqlFunction contained int2vectorin int2vectorout int2vectorrecv int2vectorsend int2xor int4
syn keyword sqlFunction contained int42div int42eq int42ge int42gt int42le int42lt int42mi int42mul
syn keyword sqlFunction contained int42ne int42pl int48div int48eq int48ge int48gt int48le int48lt int48mi
syn keyword sqlFunction contained int48mul int48ne int48pl int4_accum int4_accum_inv int4_avg_accum
syn keyword sqlFunction contained int4_avg_accum_inv int4_avg_combine int4_mul_cash int4_sum
syn keyword sqlFunction contained int4abs int4and int4div int4eq int4ge int4gt int4in int4inc int4larger
syn keyword sqlFunction contained int4le int4lt int4mi int4mod int4mul int4ne int4not int4or int4out
syn keyword sqlFunction contained int4pl int4range int4range_canonical int4range_subdiff int4recv
syn keyword sqlFunction contained int4send int4shl int4shr int4smaller int4um int4up int4xor int8
syn keyword sqlFunction contained int82div int82eq int82ge int82gt int82le int82lt int82mi int82mul
syn keyword sqlFunction contained int82ne int82pl int84div int84eq int84ge int84gt int84le int84lt int84mi
syn keyword sqlFunction contained int84mul int84ne int84pl int8_accum int8_accum_inv int8_avg
syn keyword sqlFunction contained int8_avg_accum int8_avg_accum_inv int8_avg_combine
syn keyword sqlFunction contained int8_avg_deserialize int8_avg_serialize int8_mul_cash int8_sum int8abs int8and
syn keyword sqlFunction contained int8dec int8dec_any int8div int8eq int8ge int8gt int8in int8inc
syn keyword sqlFunction contained int8inc_any int8inc_float8_float8 int8larger int8le int8lt int8mi
syn keyword sqlFunction contained int8mod int8mul int8ne int8not int8or int8out int8pl int8pl_inet
syn keyword sqlFunction contained int8range int8range_canonical int8range_subdiff int8recv int8send
syn keyword sqlFunction contained int8shl int8shr int8smaller int8um int8up int8xor integer_pl_date
syn keyword sqlFunction contained inter_lb inter_sb inter_sl internal_in internal_out interval
syn keyword sqlFunction contained interval_accum interval_accum_inv interval_avg interval_cmp
syn keyword sqlFunction contained interval_combine interval_div interval_eq interval_ge interval_gt
syn keyword sqlFunction contained interval_hash interval_hash_extended interval_in interval_larger
syn keyword sqlFunction contained interval_le interval_lt interval_mi interval_mul interval_ne
syn keyword sqlFunction contained interval_out interval_pl interval_pl_date interval_pl_time
syn keyword sqlFunction contained interval_pl_timestamp interval_pl_timestamptz interval_pl_timetz
syn keyword sqlFunction contained interval_recv interval_send interval_smaller interval_support interval_um
syn keyword sqlFunction contained intervaltypmodin intervaltypmodout is_normalized isclosed isempty
syn keyword sqlFunction contained isfinite ishorizontal iso8859_1_to_utf8 iso8859_to_utf8
syn keyword sqlFunction contained iso_to_koi8r iso_to_mic iso_to_win1251 iso_to_win866 isopen isparallel
syn keyword sqlFunction contained isperp isvertical johab_to_utf8 json_agg json_agg_finalfn
syn keyword sqlFunction contained json_agg_transfn json_array_element json_array_element_text
syn keyword sqlFunction contained json_array_elements json_array_elements_text json_array_length
syn keyword sqlFunction contained json_build_array json_build_object json_each json_each_text
syn keyword sqlFunction contained json_extract_path json_extract_path_text json_in json_object
syn keyword sqlFunction contained json_object_agg json_object_agg_finalfn json_object_agg_transfn
syn keyword sqlFunction contained json_object_field json_object_field_text json_object_keys json_out
syn keyword sqlFunction contained json_populate_record json_populate_recordset json_recv json_send
syn keyword sqlFunction contained json_strip_nulls json_to_record json_to_recordset json_to_tsvector
syn keyword sqlFunction contained json_typeof jsonb_agg jsonb_agg_finalfn jsonb_agg_transfn
syn keyword sqlFunction contained jsonb_array_element jsonb_array_element_text jsonb_array_elements
syn keyword sqlFunction contained jsonb_array_elements_text jsonb_array_length jsonb_build_array
syn keyword sqlFunction contained jsonb_build_object jsonb_cmp jsonb_concat jsonb_contained
syn keyword sqlFunction contained jsonb_contains jsonb_delete jsonb_delete_path jsonb_each
syn keyword sqlFunction contained jsonb_each_text jsonb_eq jsonb_exists jsonb_exists_all jsonb_exists_any
syn keyword sqlFunction contained jsonb_extract_path jsonb_extract_path_text jsonb_ge jsonb_gt
syn keyword sqlFunction contained jsonb_hash jsonb_hash_extended jsonb_in jsonb_insert jsonb_le jsonb_lt
syn keyword sqlFunction contained jsonb_ne jsonb_object jsonb_object_agg
syn keyword sqlFunction contained jsonb_object_agg_finalfn jsonb_object_agg_transfn jsonb_object_field
syn keyword sqlFunction contained jsonb_object_field_text jsonb_object_keys jsonb_out jsonb_path_exists
syn keyword sqlFunction contained jsonb_path_exists_opr jsonb_path_exists_tz jsonb_path_match
syn keyword sqlFunction contained jsonb_path_match_opr jsonb_path_match_tz jsonb_path_query
syn keyword sqlFunction contained jsonb_path_query_array jsonb_path_query_array_tz jsonb_path_query_first
syn keyword sqlFunction contained jsonb_path_query_first_tz jsonb_path_query_tz
syn keyword sqlFunction contained jsonb_populate_record jsonb_populate_recordset jsonb_pretty jsonb_recv jsonb_send
syn keyword sqlFunction contained jsonb_set jsonb_set_lax jsonb_strip_nulls jsonb_to_record
syn keyword sqlFunction contained jsonb_to_recordset jsonb_to_tsvector jsonb_typeof jsonpath_in
syn keyword sqlFunction contained jsonpath_out jsonpath_recv jsonpath_send justify_days justify_hours
syn keyword sqlFunction contained justify_interval koi8r_to_iso koi8r_to_mic koi8r_to_utf8
syn keyword sqlFunction contained koi8r_to_win1251 koi8r_to_win866 koi8u_to_utf8 lag language_handler_in
syn keyword sqlFunction contained language_handler_out last_value lastval latin1_to_mic
syn keyword sqlFunction contained latin2_to_mic latin2_to_win1250 latin3_to_mic latin4_to_mic lcm lead left
syn keyword sqlFunction contained length like like_escape likejoinsel likesel line line_distance line_eq
syn keyword sqlFunction contained line_horizontal line_in line_interpt line_intersect line_out
syn keyword sqlFunction contained line_parallel line_perp line_recv line_send line_vertical ln
syn keyword sqlFunction contained lo_close lo_creat lo_create lo_export lo_from_bytea lo_get lo_import
syn keyword sqlFunction contained lo_lseek lo_lseek64 lo_open lo_put lo_tell lo_tell64 lo_truncate
syn keyword sqlFunction contained lo_truncate64 lo_unlink log log10 loread lower lower_inc lower_inf
syn keyword sqlFunction contained lowrite lpad lseg lseg_center lseg_distance lseg_eq lseg_ge lseg_gt
syn keyword sqlFunction contained lseg_horizontal lseg_in lseg_interpt lseg_intersect lseg_le
syn keyword sqlFunction contained lseg_length lseg_lt lseg_ne lseg_out lseg_parallel lseg_perp lseg_recv
syn keyword sqlFunction contained lseg_send lseg_vertical ltrim macaddr macaddr8 macaddr8_and
syn keyword sqlFunction contained macaddr8_cmp macaddr8_eq macaddr8_ge macaddr8_gt macaddr8_in macaddr8_le
syn keyword sqlFunction contained macaddr8_lt macaddr8_ne macaddr8_not macaddr8_or macaddr8_out
syn keyword sqlFunction contained macaddr8_recv macaddr8_send macaddr8_set7bit macaddr_and
syn keyword sqlFunction contained macaddr_cmp macaddr_eq macaddr_ge macaddr_gt macaddr_in macaddr_le
syn keyword sqlFunction contained macaddr_lt macaddr_ne macaddr_not macaddr_or macaddr_out macaddr_recv
syn keyword sqlFunction contained macaddr_send macaddr_sortsupport make_date make_interval
syn keyword sqlFunction contained make_time make_timestamp make_timestamptz makeaclitem masklen
syn keyword sqlFunction contained matchingjoinsel matchingsel max md5 mic_to_big5 mic_to_euc_cn
syn keyword sqlFunction contained mic_to_euc_jp mic_to_euc_kr mic_to_euc_tw mic_to_iso mic_to_koi8r
syn keyword sqlFunction contained mic_to_latin1 mic_to_latin2 mic_to_latin3 mic_to_latin4 mic_to_sjis
syn keyword sqlFunction contained mic_to_win1250 mic_to_win1251 mic_to_win866 min min_scale mod mode
syn keyword sqlFunction contained mode_final money mul_d_interval mxid_age name nameconcatoid nameeq
syn keyword sqlFunction contained nameeqtext namege namegetext namegt namegttext nameiclike nameicnlike
syn keyword sqlFunction contained nameicregexeq nameicregexne namein namele nameletext namelike
syn keyword sqlFunction contained namelt namelttext namene namenetext namenlike nameout namerecv
syn keyword sqlFunction contained nameregexeq nameregexne namesend neqjoinsel neqsel netmask network
syn keyword sqlFunction contained network_cmp network_eq network_ge network_gt network_larger
syn keyword sqlFunction contained network_le network_lt network_ne network_overlap network_smaller
syn keyword sqlFunction contained network_sortsupport network_sub network_subeq network_subset_support
syn keyword sqlFunction contained network_sup network_supeq networkjoinsel networksel nextval
syn keyword sqlFunction contained nlikejoinsel nlikesel normalize notlike now npoints nth_value ntile
syn keyword sqlFunction contained num_nonnulls num_nulls numeric numeric_abs numeric_accum
syn keyword sqlFunction contained numeric_accum_inv numeric_add numeric_avg numeric_avg_accum
syn keyword sqlFunction contained numeric_avg_combine numeric_avg_deserialize numeric_avg_serialize numeric_cmp
syn keyword sqlFunction contained numeric_combine numeric_deserialize numeric_div
syn keyword sqlFunction contained numeric_div_trunc numeric_eq numeric_exp numeric_fac numeric_ge numeric_gt
syn keyword sqlFunction contained numeric_in numeric_inc numeric_larger numeric_le numeric_ln
syn keyword sqlFunction contained numeric_log numeric_lt numeric_mod numeric_mul numeric_ne numeric_out
syn keyword sqlFunction contained numeric_poly_avg numeric_poly_combine numeric_poly_deserialize
syn keyword sqlFunction contained numeric_poly_serialize numeric_poly_stddev_pop
syn keyword sqlFunction contained numeric_poly_stddev_samp numeric_poly_sum numeric_poly_var_pop
syn keyword sqlFunction contained numeric_poly_var_samp numeric_power numeric_recv numeric_send
syn keyword sqlFunction contained numeric_serialize numeric_smaller numeric_sortsupport numeric_sqrt
syn keyword sqlFunction contained numeric_stddev_pop numeric_stddev_samp numeric_sub numeric_sum
syn keyword sqlFunction contained numeric_support numeric_uminus numeric_uplus numeric_var_pop
syn keyword sqlFunction contained numeric_var_samp numerictypmodin numerictypmodout numnode numrange
syn keyword sqlFunction contained numrange_subdiff obj_description octet_length oid oideq oidge oidgt oidin
syn keyword sqlFunction contained oidlarger oidle oidlt oidne oidout oidrecv oidsend oidsmaller
syn keyword sqlFunction contained oidvectoreq oidvectorge oidvectorgt oidvectorin oidvectorle oidvectorlt
syn keyword sqlFunction contained oidvectorne oidvectorout oidvectorrecv oidvectorsend
syn keyword sqlFunction contained oidvectortypes on_pb on_pl on_ppath on_ps on_sb on_sl ordered_set_transition
syn keyword sqlFunction contained ordered_set_transition_multi overlaps overlay parse_ident path
syn keyword sqlFunction contained path_add path_add_pt path_center path_contain_pt path_distance
syn keyword sqlFunction contained path_div_pt path_in path_inter path_length path_mul_pt path_n_eq
syn keyword sqlFunction contained path_n_ge path_n_gt path_n_le path_n_lt path_npoints path_out
syn keyword sqlFunction contained path_recv path_send path_sub_pt pclose percent_rank percent_rank_final
syn keyword sqlFunction contained percentile_cont percentile_cont_float8_final
syn keyword sqlFunction contained percentile_cont_float8_multi_final percentile_cont_interval_final
syn keyword sqlFunction contained percentile_cont_interval_multi_final percentile_disc
syn keyword sqlFunction contained percentile_disc_final percentile_disc_multi_final pg_advisory_lock
syn keyword sqlFunction contained pg_advisory_lock_shared pg_advisory_unlock pg_advisory_unlock_all
syn keyword sqlFunction contained pg_advisory_unlock_shared pg_advisory_xact_lock
syn keyword sqlFunction contained pg_advisory_xact_lock_shared pg_available_extension_versions pg_available_extensions
syn keyword sqlFunction contained pg_backend_pid pg_backup_start_time pg_blocking_pids
syn keyword sqlFunction contained pg_cancel_backend pg_char_to_encoding pg_client_encoding
syn keyword sqlFunction contained pg_collation_actual_version pg_collation_for pg_collation_is_visible
syn keyword sqlFunction contained pg_column_is_updatable pg_column_size pg_conf_load_time pg_config
syn keyword sqlFunction contained pg_control_checkpoint pg_control_init pg_control_recovery
syn keyword sqlFunction contained pg_control_system pg_conversion_is_visible
syn keyword sqlFunction contained pg_copy_logical_replication_slot pg_copy_physical_replication_slot
syn keyword sqlFunction contained pg_create_logical_replication_slot pg_create_physical_replication_slot
syn keyword sqlFunction contained pg_create_restore_point pg_current_logfile pg_current_snapshot
syn keyword sqlFunction contained pg_current_wal_flush_lsn pg_current_wal_insert_lsn pg_current_wal_lsn
syn keyword sqlFunction contained pg_current_xact_id pg_current_xact_id_if_assigned pg_cursor
syn keyword sqlFunction contained pg_database_size pg_ddl_command_in pg_ddl_command_out
syn keyword sqlFunction contained pg_ddl_command_recv pg_ddl_command_send pg_dependencies_in
syn keyword sqlFunction contained pg_dependencies_out pg_dependencies_recv pg_dependencies_send
syn keyword sqlFunction contained pg_describe_object pg_drop_replication_slot pg_encoding_max_length
syn keyword sqlFunction contained pg_encoding_to_char pg_event_trigger_ddl_commands
syn keyword sqlFunction contained pg_event_trigger_dropped_objects pg_event_trigger_table_rewrite_oid
syn keyword sqlFunction contained pg_event_trigger_table_rewrite_reason pg_export_snapshot
syn keyword sqlFunction contained pg_extension_config_dump pg_extension_update_paths pg_file_rename pg_file_sync
syn keyword sqlFunction contained pg_file_unlink pg_file_write pg_filenode_relation
syn keyword sqlFunction contained pg_function_is_visible pg_get_constraintdef pg_get_expr
syn keyword sqlFunction contained pg_get_function_arg_default pg_get_function_arguments
syn keyword sqlFunction contained pg_get_function_identity_arguments pg_get_function_result pg_get_functiondef
syn keyword sqlFunction contained pg_get_indexdef pg_get_keywords pg_get_multixact_members
syn keyword sqlFunction contained pg_get_object_address pg_get_partition_constraintdef pg_get_partkeydef
syn keyword sqlFunction contained pg_get_publication_tables pg_get_replica_identity_index
syn keyword sqlFunction contained pg_get_replication_slots pg_get_ruledef pg_get_serial_sequence
syn keyword sqlFunction contained pg_get_shmem_allocations pg_get_statisticsobjdef pg_get_triggerdef
syn keyword sqlFunction contained pg_get_userbyid pg_get_viewdef pg_has_role pg_hba_file_rules
syn keyword sqlFunction contained pg_identify_object pg_identify_object_as_address
syn keyword sqlFunction contained pg_import_system_collations pg_index_column_has_property pg_index_has_property
syn keyword sqlFunction contained pg_indexam_has_property pg_indexam_progress_phasename
syn keyword sqlFunction contained pg_indexes_size pg_is_in_backup pg_is_in_recovery pg_is_other_temp_schema
syn keyword sqlFunction contained pg_is_wal_replay_paused pg_isolation_test_session_is_blocked
syn keyword sqlFunction contained pg_jit_available pg_last_committed_xact
syn keyword sqlFunction contained pg_last_wal_receive_lsn pg_last_wal_replay_lsn pg_last_xact_replay_timestamp
syn keyword sqlFunction contained pg_listening_channels pg_lock_status pg_logdir_ls
syn keyword sqlFunction contained pg_logical_emit_message pg_logical_slot_get_binary_changes
syn keyword sqlFunction contained pg_logical_slot_get_changes pg_logical_slot_peek_binary_changes
syn keyword sqlFunction contained pg_logical_slot_peek_changes pg_ls_archive_statusdir pg_ls_dir pg_ls_logdir
syn keyword sqlFunction contained pg_ls_tmpdir pg_ls_waldir pg_lsn_cmp pg_lsn_eq pg_lsn_ge pg_lsn_gt
syn keyword sqlFunction contained pg_lsn_hash pg_lsn_hash_extended pg_lsn_in pg_lsn_larger
syn keyword sqlFunction contained pg_lsn_le pg_lsn_lt pg_lsn_mi pg_lsn_ne pg_lsn_out pg_lsn_recv
syn keyword sqlFunction contained pg_lsn_send pg_lsn_smaller pg_mcv_list_in pg_mcv_list_items
syn keyword sqlFunction contained pg_mcv_list_out pg_mcv_list_recv pg_mcv_list_send pg_my_temp_schema
syn keyword sqlFunction contained pg_ndistinct_in pg_ndistinct_out pg_ndistinct_recv pg_ndistinct_send
syn keyword sqlFunction contained pg_nextoid pg_node_tree_in pg_node_tree_out pg_node_tree_recv
syn keyword sqlFunction contained pg_node_tree_send pg_notification_queue_usage pg_notify
syn keyword sqlFunction contained pg_opclass_is_visible pg_operator_is_visible pg_opfamily_is_visible
syn keyword sqlFunction contained pg_options_to_table pg_partition_ancestors pg_partition_root
syn keyword sqlFunction contained pg_partition_tree pg_postmaster_start_time pg_prepared_statement
syn keyword sqlFunction contained pg_prepared_xact pg_promote pg_read_binary_file pg_read_file
syn keyword sqlFunction contained pg_read_file_old pg_relation_filenode pg_relation_filepath
syn keyword sqlFunction contained pg_relation_is_publishable pg_relation_is_updatable
syn keyword sqlFunction contained pg_relation_size pg_reload_conf pg_replication_origin_advance
syn keyword sqlFunction contained pg_replication_origin_create pg_replication_origin_drop
syn keyword sqlFunction contained pg_replication_origin_oid pg_replication_origin_progress
syn keyword sqlFunction contained pg_replication_origin_session_is_setup pg_replication_origin_session_progress
syn keyword sqlFunction contained pg_replication_origin_session_reset
syn keyword sqlFunction contained pg_replication_origin_session_setup pg_replication_origin_xact_reset
syn keyword sqlFunction contained pg_replication_origin_xact_setup pg_replication_slot_advance pg_rotate_logfile
syn keyword sqlFunction contained pg_rotate_logfile_old pg_safe_snapshot_blocking_pids
syn keyword sqlFunction contained pg_sequence_last_value pg_sequence_parameters pg_show_all_file_settings
syn keyword sqlFunction contained pg_show_all_settings pg_show_replication_origin_status
syn keyword sqlFunction contained pg_size_bytes pg_size_pretty pg_sleep pg_sleep_for pg_sleep_until
syn keyword sqlFunction contained pg_snapshot_in pg_snapshot_out pg_snapshot_recv pg_snapshot_send
syn keyword sqlFunction contained pg_snapshot_xip pg_snapshot_xmax pg_snapshot_xmin pg_start_backup
syn keyword sqlFunction contained pg_stat_clear_snapshot pg_stat_file pg_stat_get_activity
syn keyword sqlFunction contained pg_stat_get_analyze_count pg_stat_get_archiver
syn keyword sqlFunction contained pg_stat_get_autoanalyze_count pg_stat_get_autovacuum_count
syn keyword sqlFunction contained pg_stat_get_backend_activity pg_stat_get_backend_activity_start
syn keyword sqlFunction contained pg_stat_get_backend_client_addr pg_stat_get_backend_client_port
syn keyword sqlFunction contained pg_stat_get_backend_dbid pg_stat_get_backend_idset pg_stat_get_backend_pid
syn keyword sqlFunction contained pg_stat_get_backend_start pg_stat_get_backend_userid
syn keyword sqlFunction contained pg_stat_get_backend_wait_event pg_stat_get_backend_wait_event_type
syn keyword sqlFunction contained pg_stat_get_backend_xact_start
syn keyword sqlFunction contained pg_stat_get_bgwriter_buf_written_checkpoints pg_stat_get_bgwriter_buf_written_clean
syn keyword sqlFunction contained pg_stat_get_bgwriter_maxwritten_clean
syn keyword sqlFunction contained pg_stat_get_bgwriter_requested_checkpoints pg_stat_get_bgwriter_stat_reset_time
syn keyword sqlFunction contained pg_stat_get_bgwriter_timed_checkpoints pg_stat_get_blocks_fetched
syn keyword sqlFunction contained pg_stat_get_blocks_hit pg_stat_get_buf_alloc
syn keyword sqlFunction contained pg_stat_get_buf_fsync_backend pg_stat_get_buf_written_backend
syn keyword sqlFunction contained pg_stat_get_checkpoint_sync_time pg_stat_get_checkpoint_write_time
syn keyword sqlFunction contained pg_stat_get_db_blk_read_time pg_stat_get_db_blk_write_time
syn keyword sqlFunction contained pg_stat_get_db_blocks_fetched pg_stat_get_db_blocks_hit
syn keyword sqlFunction contained pg_stat_get_db_checksum_failures pg_stat_get_db_checksum_last_failure
syn keyword sqlFunction contained pg_stat_get_db_conflict_all pg_stat_get_db_conflict_bufferpin
syn keyword sqlFunction contained pg_stat_get_db_conflict_lock pg_stat_get_db_conflict_snapshot
syn keyword sqlFunction contained pg_stat_get_db_conflict_startup_deadlock pg_stat_get_db_conflict_tablespace
syn keyword sqlFunction contained pg_stat_get_db_deadlocks pg_stat_get_db_numbackends
syn keyword sqlFunction contained pg_stat_get_db_stat_reset_time pg_stat_get_db_temp_bytes
syn keyword sqlFunction contained pg_stat_get_db_temp_files pg_stat_get_db_tuples_deleted
syn keyword sqlFunction contained pg_stat_get_db_tuples_fetched pg_stat_get_db_tuples_inserted
syn keyword sqlFunction contained pg_stat_get_db_tuples_returned pg_stat_get_db_tuples_updated
syn keyword sqlFunction contained pg_stat_get_db_xact_commit pg_stat_get_db_xact_rollback pg_stat_get_dead_tuples
syn keyword sqlFunction contained pg_stat_get_function_calls pg_stat_get_function_self_time
syn keyword sqlFunction contained pg_stat_get_function_total_time pg_stat_get_ins_since_vacuum
syn keyword sqlFunction contained pg_stat_get_last_analyze_time pg_stat_get_last_autoanalyze_time
syn keyword sqlFunction contained pg_stat_get_last_autovacuum_time pg_stat_get_last_vacuum_time
syn keyword sqlFunction contained pg_stat_get_live_tuples pg_stat_get_mod_since_analyze
syn keyword sqlFunction contained pg_stat_get_numscans pg_stat_get_progress_info pg_stat_get_slru
syn keyword sqlFunction contained pg_stat_get_snapshot_timestamp pg_stat_get_subscription
syn keyword sqlFunction contained pg_stat_get_tuples_deleted pg_stat_get_tuples_fetched
syn keyword sqlFunction contained pg_stat_get_tuples_hot_updated pg_stat_get_tuples_inserted
syn keyword sqlFunction contained pg_stat_get_tuples_returned pg_stat_get_tuples_updated pg_stat_get_vacuum_count
syn keyword sqlFunction contained pg_stat_get_wal_receiver pg_stat_get_wal_senders
syn keyword sqlFunction contained pg_stat_get_xact_blocks_fetched pg_stat_get_xact_blocks_hit
syn keyword sqlFunction contained pg_stat_get_xact_function_calls pg_stat_get_xact_function_self_time
syn keyword sqlFunction contained pg_stat_get_xact_function_total_time pg_stat_get_xact_numscans
syn keyword sqlFunction contained pg_stat_get_xact_tuples_deleted pg_stat_get_xact_tuples_fetched
syn keyword sqlFunction contained pg_stat_get_xact_tuples_hot_updated
syn keyword sqlFunction contained pg_stat_get_xact_tuples_inserted pg_stat_get_xact_tuples_returned
syn keyword sqlFunction contained pg_stat_get_xact_tuples_updated pg_stat_reset pg_stat_reset_shared
syn keyword sqlFunction contained pg_stat_reset_single_function_counters pg_stat_reset_single_table_counters
syn keyword sqlFunction contained pg_stat_reset_slru pg_statistics_obj_is_visible pg_stop_backup
syn keyword sqlFunction contained pg_switch_wal pg_table_is_visible pg_table_size
syn keyword sqlFunction contained pg_tablespace_databases pg_tablespace_location pg_tablespace_size
syn keyword sqlFunction contained pg_terminate_backend pg_timezone_abbrevs pg_timezone_names
syn keyword sqlFunction contained pg_total_relation_size pg_trigger_depth pg_try_advisory_lock
syn keyword sqlFunction contained pg_try_advisory_lock_shared pg_try_advisory_xact_lock
syn keyword sqlFunction contained pg_try_advisory_xact_lock_shared pg_ts_config_is_visible pg_ts_dict_is_visible
syn keyword sqlFunction contained pg_ts_parser_is_visible pg_ts_template_is_visible
syn keyword sqlFunction contained pg_type_is_visible pg_typeof pg_visible_in_snapshot pg_wal_lsn_diff
syn keyword sqlFunction contained pg_wal_replay_pause pg_wal_replay_resume pg_walfile_name
syn keyword sqlFunction contained pg_walfile_name_offset pg_xact_commit_timestamp pg_xact_status
syn keyword sqlFunction contained phraseto_tsquery pi plainto_tsquery plperl_call_handler plperl_inline_handler
syn keyword sqlFunction contained plperl_validator plperlu_call_handler plperlu_inline_handler
syn keyword sqlFunction contained plperlu_validator plpgsql_call_handler plpgsql_inline_handler
syn keyword sqlFunction contained plpgsql_validator pltcl_call_handler pltclu_call_handler point
syn keyword sqlFunction contained point_above point_add point_below point_distance point_div
syn keyword sqlFunction contained point_eq point_horiz point_in point_left point_mul point_ne point_out
syn keyword sqlFunction contained point_recv point_right point_send point_sub point_vert poly_above
syn keyword sqlFunction contained poly_below poly_center poly_contain poly_contain_pt
syn keyword sqlFunction contained poly_contained poly_distance poly_in poly_left poly_npoints poly_out
syn keyword sqlFunction contained poly_overabove poly_overbelow poly_overlap poly_overleft poly_overright
syn keyword sqlFunction contained poly_recv poly_right poly_same poly_send polygon popen position
syn keyword sqlFunction contained positionjoinsel positionsel postgresql_fdw_validator pow power
syn keyword sqlFunction contained prefixjoinsel prefixsel prsd_end prsd_headline prsd_lextype
syn keyword sqlFunction contained prsd_nexttoken prsd_start pt_contained_circle pt_contained_poly
syn keyword sqlFunction contained query_to_xml query_to_xml_and_xmlschema query_to_xmlschema querytree
syn keyword sqlFunction contained quote_ident quote_literal quote_nullable radians radius random
syn keyword sqlFunction contained range_adjacent range_after range_before range_cmp
syn keyword sqlFunction contained range_contained_by range_contains range_contains_elem range_eq range_ge
syn keyword sqlFunction contained range_gist_consistent range_gist_penalty range_gist_picksplit
syn keyword sqlFunction contained range_gist_same range_gist_union range_gt range_in range_intersect
syn keyword sqlFunction contained range_le range_lt range_merge range_minus range_ne range_out
syn keyword sqlFunction contained range_overlaps range_overleft range_overright range_recv range_send
syn keyword sqlFunction contained range_typanalyze range_union rangesel rank rank_final record_eq
syn keyword sqlFunction contained record_ge record_gt record_image_eq record_image_ge record_image_gt
syn keyword sqlFunction contained record_image_le record_image_lt record_image_ne record_in
syn keyword sqlFunction contained record_le record_lt record_ne record_out record_recv record_send
syn keyword sqlFunction contained regclass regclassin regclassout regclassrecv regclasssend
syn keyword sqlFunction contained regcollationin regcollationout regcollationrecv regcollationsend regconfigin
syn keyword sqlFunction contained regconfigout regconfigrecv regconfigsend regdictionaryin
syn keyword sqlFunction contained regdictionaryout regdictionaryrecv regdictionarysend regexeqjoinsel
syn keyword sqlFunction contained regexeqsel regexnejoinsel regexnesel regexp_match regexp_matches
syn keyword sqlFunction contained regexp_replace regexp_split_to_array regexp_split_to_table
syn keyword sqlFunction contained regnamespacein regnamespaceout regnamespacerecv regnamespacesend
syn keyword sqlFunction contained regoperatorin regoperatorout regoperatorrecv regoperatorsend
syn keyword sqlFunction contained regoperin regoperout regoperrecv regopersend regprocedurein
syn keyword sqlFunction contained regprocedureout regprocedurerecv regproceduresend regprocin regprocout
syn keyword sqlFunction contained regprocrecv regprocsend regr_avgx regr_avgy regr_count
syn keyword sqlFunction contained regr_intercept regr_r2 regr_slope regr_sxx regr_sxy regr_syy regrolein
syn keyword sqlFunction contained regroleout regrolerecv regrolesend regtypein regtypeout regtyperecv
syn keyword sqlFunction contained regtypesend repeat replace reverse right round row_number
syn keyword sqlFunction contained row_security_active row_to_json rpad rtrim satisfies_hash_partition
syn keyword sqlFunction contained scalargejoinsel scalargesel scalargtjoinsel scalargtsel
syn keyword sqlFunction contained scalarlejoinsel scalarlesel scalarltjoinsel scalarltsel scale schema_to_xml
syn keyword sqlFunction contained schema_to_xml_and_xmlschema schema_to_xmlschema session_user
syn keyword sqlFunction contained set_bit set_byte set_config set_masklen setseed setval setweight
syn keyword sqlFunction contained sha224 sha256 sha384 sha512 shell_in shell_out
syn keyword sqlFunction contained shift_jis_2004_to_euc_jis_2004 shift_jis_2004_to_utf8 shobj_description sign
syn keyword sqlFunction contained similar_escape similar_to_escape sin sind sinh sjis_to_euc_jp
syn keyword sqlFunction contained sjis_to_mic sjis_to_utf8 slope spg_bbox_quad_config spg_box_quad_choose
syn keyword sqlFunction contained spg_box_quad_config spg_box_quad_inner_consistent
syn keyword sqlFunction contained spg_box_quad_leaf_consistent spg_box_quad_picksplit spg_kd_choose
syn keyword sqlFunction contained spg_kd_config spg_kd_inner_consistent spg_kd_picksplit
syn keyword sqlFunction contained spg_poly_quad_compress spg_quad_choose spg_quad_config
syn keyword sqlFunction contained spg_quad_inner_consistent spg_quad_leaf_consistent spg_quad_picksplit
syn keyword sqlFunction contained spg_range_quad_choose spg_range_quad_config spg_range_quad_inner_consistent
syn keyword sqlFunction contained spg_range_quad_leaf_consistent spg_range_quad_picksplit
syn keyword sqlFunction contained spg_text_choose spg_text_config spg_text_inner_consistent
syn keyword sqlFunction contained spg_text_leaf_consistent spg_text_picksplit spghandler split_part sqrt
syn keyword sqlFunction contained starts_with statement_timestamp stddev stddev_pop stddev_samp
syn keyword sqlFunction contained string_agg string_agg_finalfn string_agg_transfn string_to_array
syn keyword sqlFunction contained strip strpos substr substring sum
syn keyword sqlFunction contained suppress_redundant_updates_trigger system table_am_handler_in table_am_handler_out table_to_xml
syn keyword sqlFunction contained table_to_xml_and_xmlschema table_to_xmlschema tan tand tanh text
syn keyword sqlFunction contained text_ge text_gt text_larger text_le text_lt text_pattern_ge
syn keyword sqlFunction contained text_pattern_gt text_pattern_le text_pattern_lt text_smaller
syn keyword sqlFunction contained textanycat textcat texteq texteqname textgename textgtname texticlike
syn keyword sqlFunction contained texticlike_support texticnlike texticregexeq texticregexeq_support
syn keyword sqlFunction contained texticregexne textin textlen textlename textlike
syn keyword sqlFunction contained textlike_support textltname textne textnename textnlike textout textrecv
syn keyword sqlFunction contained textregexeq textregexeq_support textregexne textsend thesaurus_init
syn keyword sqlFunction contained thesaurus_lexize tideq tidge tidgt tidin tidlarger tidle tidlt tidne
syn keyword sqlFunction contained tidout tidrecv tidsend tidsmaller time time_cmp time_eq time_ge
syn keyword sqlFunction contained time_gt time_hash time_hash_extended time_in time_larger time_le
syn keyword sqlFunction contained time_lt time_mi_interval time_mi_time time_ne time_out
syn keyword sqlFunction contained time_pl_interval time_recv time_send time_smaller time_support timedate_pl
syn keyword sqlFunction contained timeofday timestamp timestamp_cmp timestamp_cmp_date
syn keyword sqlFunction contained timestamp_cmp_timestamptz timestamp_eq timestamp_eq_date
syn keyword sqlFunction contained timestamp_eq_timestamptz timestamp_ge timestamp_ge_date timestamp_ge_timestamptz
syn keyword sqlFunction contained timestamp_gt timestamp_gt_date timestamp_gt_timestamptz
syn keyword sqlFunction contained timestamp_hash timestamp_hash_extended timestamp_in timestamp_larger
syn keyword sqlFunction contained timestamp_le timestamp_le_date timestamp_le_timestamptz
syn keyword sqlFunction contained timestamp_lt timestamp_lt_date timestamp_lt_timestamptz timestamp_mi
syn keyword sqlFunction contained timestamp_mi_interval timestamp_ne timestamp_ne_date
syn keyword sqlFunction contained timestamp_ne_timestamptz timestamp_out timestamp_pl_interval
syn keyword sqlFunction contained timestamp_recv timestamp_send timestamp_smaller timestamp_sortsupport
syn keyword sqlFunction contained timestamp_support timestamptypmodin timestamptypmodout timestamptz
syn keyword sqlFunction contained timestamptz_cmp timestamptz_cmp_date timestamptz_cmp_timestamp
syn keyword sqlFunction contained timestamptz_eq timestamptz_eq_date timestamptz_eq_timestamp
syn keyword sqlFunction contained timestamptz_ge timestamptz_ge_date timestamptz_ge_timestamp
syn keyword sqlFunction contained timestamptz_gt timestamptz_gt_date timestamptz_gt_timestamp
syn keyword sqlFunction contained timestamptz_in timestamptz_larger timestamptz_le timestamptz_le_date
syn keyword sqlFunction contained timestamptz_le_timestamp timestamptz_lt timestamptz_lt_date
syn keyword sqlFunction contained timestamptz_lt_timestamp timestamptz_mi timestamptz_mi_interval
syn keyword sqlFunction contained timestamptz_ne timestamptz_ne_date timestamptz_ne_timestamp
syn keyword sqlFunction contained timestamptz_out timestamptz_pl_interval timestamptz_recv
syn keyword sqlFunction contained timestamptz_send timestamptz_smaller timestamptztypmodin
syn keyword sqlFunction contained timestamptztypmodout timetypmodin timetypmodout timetz timetz_cmp timetz_eq
syn keyword sqlFunction contained timetz_ge timetz_gt timetz_hash timetz_hash_extended timetz_in
syn keyword sqlFunction contained timetz_larger timetz_le timetz_lt timetz_mi_interval timetz_ne
syn keyword sqlFunction contained timetz_out timetz_pl_interval timetz_recv timetz_send
syn keyword sqlFunction contained timetz_smaller timetzdate_pl timetztypmodin timetztypmodout timezone
syn keyword sqlFunction contained to_ascii to_char to_date to_hex to_json to_jsonb to_number to_regclass
syn keyword sqlFunction contained to_regcollation to_regnamespace to_regoper to_regoperator
syn keyword sqlFunction contained to_regproc to_regprocedure to_regrole to_regtype to_timestamp to_tsquery
syn keyword sqlFunction contained to_tsvector transaction_timestamp translate trigger_in
syn keyword sqlFunction contained trigger_out trim_scale trunc ts_debug ts_delete ts_filter ts_headline
syn keyword sqlFunction contained ts_lexize ts_match_qv ts_match_tq ts_match_tt ts_match_vq ts_parse
syn keyword sqlFunction contained ts_rank ts_rank_cd ts_rewrite ts_stat ts_token_type ts_typanalyze
syn keyword sqlFunction contained tsm_handler_in tsm_handler_out tsmatchjoinsel tsmatchsel
syn keyword sqlFunction contained tsq_mcontained tsq_mcontains tsquery_and tsquery_cmp tsquery_eq
syn keyword sqlFunction contained tsquery_ge tsquery_gt tsquery_le tsquery_lt tsquery_ne tsquery_not
syn keyword sqlFunction contained tsquery_or tsquery_phrase tsqueryin tsqueryout tsqueryrecv
syn keyword sqlFunction contained tsquerysend tsrange tsrange_subdiff tstzrange tstzrange_subdiff
syn keyword sqlFunction contained tsvector_cmp tsvector_concat tsvector_eq tsvector_ge tsvector_gt
syn keyword sqlFunction contained tsvector_le tsvector_lt tsvector_ne tsvector_to_array
syn keyword sqlFunction contained tsvector_update_trigger tsvector_update_trigger_column tsvectorin tsvectorout
syn keyword sqlFunction contained tsvectorrecv tsvectorsend txid_current txid_current_if_assigned
syn keyword sqlFunction contained txid_current_snapshot txid_snapshot_in txid_snapshot_out
syn keyword sqlFunction contained txid_snapshot_recv txid_snapshot_send txid_snapshot_xip
syn keyword sqlFunction contained txid_snapshot_xmax txid_snapshot_xmin txid_status txid_visible_in_snapshot
syn keyword sqlFunction contained uhc_to_utf8 unique_key_recheck unknownin unknownout unknownrecv
syn keyword sqlFunction contained unknownsend unnest upper upper_inc upper_inf utf8_to_big5
syn keyword sqlFunction contained utf8_to_euc_cn utf8_to_euc_jis_2004 utf8_to_euc_jp utf8_to_euc_kr
syn keyword sqlFunction contained utf8_to_euc_tw utf8_to_gb18030 utf8_to_gbk utf8_to_iso8859
syn keyword sqlFunction contained utf8_to_iso8859_1 utf8_to_johab utf8_to_koi8r utf8_to_koi8u
syn keyword sqlFunction contained utf8_to_shift_jis_2004 utf8_to_sjis utf8_to_uhc utf8_to_win uuid_cmp uuid_eq
syn keyword sqlFunction contained uuid_ge uuid_gt uuid_hash uuid_hash_extended uuid_in uuid_le
syn keyword sqlFunction contained uuid_lt uuid_ne uuid_out uuid_recv uuid_send uuid_sortsupport var_pop
syn keyword sqlFunction contained var_samp varbit varbit_in varbit_out varbit_recv varbit_send
syn keyword sqlFunction contained varbit_support varbitcmp varbiteq varbitge varbitgt varbitle varbitlt
syn keyword sqlFunction contained varbitne varbittypmodin varbittypmodout varchar_support
syn keyword sqlFunction contained varcharin varcharout varcharrecv varcharsend varchartypmodin
syn keyword sqlFunction contained varchartypmodout variance version void_in void_out void_recv void_send
syn keyword sqlFunction contained websearch_to_tsquery width width_bucket win1250_to_latin2
syn keyword sqlFunction contained win1250_to_mic win1251_to_iso win1251_to_koi8r win1251_to_mic
syn keyword sqlFunction contained win1251_to_win866 win866_to_iso win866_to_koi8r win866_to_mic
syn keyword sqlFunction contained win866_to_win1251 win_to_utf8 xid xid8cmp xid8eq xid8ge xid8gt xid8in xid8le
syn keyword sqlFunction contained xid8lt xid8ne xid8out xid8recv xid8send xideq xideqint4 xidin xidneq
syn keyword sqlFunction contained xidneqint4 xidout xidrecv xidsend xml xml_in xml_is_well_formed
syn keyword sqlFunction contained xml_is_well_formed_content xml_is_well_formed_document xml_out
syn keyword sqlFunction contained xml_recv xml_send xmlagg xmlcomment xmlconcat2 xmlexists xmlvalidate
syn keyword sqlFunction contained xpath xpath_exists
" Extensions names
syn keyword sqlConstant contained address_standardizer address_standardizer_data_us adminpack
syn keyword sqlConstant contained amcheck autoinc bloom bool_plperl bool_plperlu btree_gin
syn keyword sqlConstant contained btree_gist citext cube dblink dict_int dict_xsyn earthdistance file_fdw
syn keyword sqlConstant contained fuzzystrmatch hstore hstore_plperl hstore_plperlu insert_username
syn keyword sqlConstant contained intagg intarray isn jsonb_plperl jsonb_plperlu lo ltree moddatetime
syn keyword sqlConstant contained pageinspect pg_buffercache pg_freespacemap pg_prewarm
syn keyword sqlConstant contained pg_stat_statements pg_trgm pg_visibility pgcrypto pgrouting pgrowlocks
syn keyword sqlConstant contained pgstattuple pgtap plperl plperlu plpgsql pltcl pltclu postgis
syn keyword sqlConstant contained postgis_raster postgis_sfcgal postgis_tiger_geocoder postgis_topology
syn keyword sqlConstant contained postgres_fdw refint seg sslinfo tablefunc tcn temporal_tables
syn keyword sqlConstant contained tsm_system_rows tsm_system_time unaccent xml2
" Legacy extensions names
syn keyword sqlConstant contained chkpass hstore_plpython2u hstore_plpython3u hstore_plpythonu
syn keyword sqlConstant contained jsonb_plpython3u ltree_plpython2u ltree_plpython3u
syn keyword sqlConstant contained ltree_plpythonu pldbgapi plpython2u plpython3u plpythonu
" Extension: refint (v1.0)
if index(get(g:, 'pgsql_disabled_extensions', []), 'refint') == -1
  syn keyword sqlFunction contained check_foreign_key check_primary_key
endif " refint
" Extension: postgis (v3.1.1)
if index(get(g:, 'pgsql_disabled_extensions', []), 'postgis') == -1
  syn keyword sqlFunction contained addauth addgeometrycolumn box
  syn keyword sqlFunction contained box2d box2d_in box2d_out box2df_in
  syn keyword sqlFunction contained box2df_out box3d box3d_in box3d_out
  syn keyword sqlFunction contained box3dtobox bytea checkauth checkauthtrigger
  syn keyword sqlFunction contained contains_2d disablelongtransactions
  syn keyword sqlFunction contained dropgeometrycolumn dropgeometrytable
  syn keyword sqlFunction contained enablelongtransactions equals find_srid
  syn keyword sqlFunction contained geog_brin_inclusion_add_value geography geography_analyze
  syn keyword sqlFunction contained geography_cmp geography_distance_knn
  syn keyword sqlFunction contained geography_eq geography_ge geography_gist_compress
  syn keyword sqlFunction contained geography_gist_consistent geography_gist_decompress
  syn keyword sqlFunction contained geography_gist_distance geography_gist_penalty
  syn keyword sqlFunction contained geography_gist_picksplit geography_gist_same
  syn keyword sqlFunction contained geography_gist_union geography_gt
  syn keyword sqlFunction contained geography_in geography_le geography_lt
  syn keyword sqlFunction contained geography_out geography_overlaps geography_recv
  syn keyword sqlFunction contained geography_send geography_spgist_choose_nd
  syn keyword sqlFunction contained geography_spgist_compress_nd geography_spgist_config_nd
  syn keyword sqlFunction contained geography_spgist_inner_consistent_nd
  syn keyword sqlFunction contained geography_spgist_leaf_consistent_nd geography_spgist_picksplit_nd
  syn keyword sqlFunction contained geography_typmod_in geography_typmod_out
  syn keyword sqlFunction contained geom2d_brin_inclusion_add_value
  syn keyword sqlFunction contained geom3d_brin_inclusion_add_value geom4d_brin_inclusion_add_value
  syn keyword sqlFunction contained geometry geometry_above geometry_analyze
  syn keyword sqlFunction contained geometry_below geometry_cmp geometry_contained_3d
  syn keyword sqlFunction contained geometry_contains geometry_contains_3d
  syn keyword sqlFunction contained geometry_contains_nd geometry_distance_box
  syn keyword sqlFunction contained geometry_distance_centroid geometry_distance_centroid_nd
  syn keyword sqlFunction contained geometry_distance_cpa geometry_eq geometry_ge
  syn keyword sqlFunction contained geometry_gist_compress_2d
  syn keyword sqlFunction contained geometry_gist_compress_nd geometry_gist_consistent_2d
  syn keyword sqlFunction contained geometry_gist_consistent_nd geometry_gist_decompress_2d
  syn keyword sqlFunction contained geometry_gist_decompress_nd geometry_gist_distance_2d
  syn keyword sqlFunction contained geometry_gist_distance_nd geometry_gist_penalty_2d
  syn keyword sqlFunction contained geometry_gist_penalty_nd
  syn keyword sqlFunction contained geometry_gist_picksplit_2d geometry_gist_picksplit_nd
  syn keyword sqlFunction contained geometry_gist_same_2d geometry_gist_same_nd
  syn keyword sqlFunction contained geometry_gist_union_2d geometry_gist_union_nd geometry_gt
  syn keyword sqlFunction contained geometry_hash geometry_in geometry_le
  syn keyword sqlFunction contained geometry_left geometry_lt geometry_out
  syn keyword sqlFunction contained geometry_overabove geometry_overbelow
  syn keyword sqlFunction contained geometry_overlaps geometry_overlaps_3d geometry_overlaps_nd
  syn keyword sqlFunction contained geometry_overleft geometry_overright
  syn keyword sqlFunction contained geometry_recv geometry_right geometry_same
  syn keyword sqlFunction contained geometry_same_3d geometry_same_nd geometry_send
  syn keyword sqlFunction contained geometry_sortsupport geometry_spgist_choose_2d
  syn keyword sqlFunction contained geometry_spgist_choose_3d geometry_spgist_choose_nd
  syn keyword sqlFunction contained geometry_spgist_compress_2d
  syn keyword sqlFunction contained geometry_spgist_compress_3d geometry_spgist_compress_nd
  syn keyword sqlFunction contained geometry_spgist_config_2d geometry_spgist_config_3d
  syn keyword sqlFunction contained geometry_spgist_config_nd
  syn keyword sqlFunction contained geometry_spgist_inner_consistent_2d geometry_spgist_inner_consistent_3d
  syn keyword sqlFunction contained geometry_spgist_inner_consistent_nd
  syn keyword sqlFunction contained geometry_spgist_leaf_consistent_2d geometry_spgist_leaf_consistent_3d
  syn keyword sqlFunction contained geometry_spgist_leaf_consistent_nd
  syn keyword sqlFunction contained geometry_spgist_picksplit_2d geometry_spgist_picksplit_3d
  syn keyword sqlFunction contained geometry_spgist_picksplit_nd geometry_typmod_in
  syn keyword sqlFunction contained geometry_typmod_out geometry_within
  syn keyword sqlFunction contained geometry_within_nd geometrytype geomfromewkb geomfromewkt
  syn keyword sqlFunction contained get_proj4_from_srid gettransactionid
  syn keyword sqlFunction contained gidx_in gidx_out gserialized_gist_joinsel_2d
  syn keyword sqlFunction contained gserialized_gist_joinsel_nd gserialized_gist_sel_2d
  syn keyword sqlFunction contained gserialized_gist_sel_nd is_contained_2d
  syn keyword sqlFunction contained json jsonb lockrow longtransactionsenabled
  syn keyword sqlFunction contained overlaps_2d overlaps_geog overlaps_nd
  syn keyword sqlFunction contained path pgis_asgeobuf_finalfn
  syn keyword sqlFunction contained pgis_asgeobuf_transfn pgis_asmvt_combinefn pgis_asmvt_deserialfn
  syn keyword sqlFunction contained pgis_asmvt_finalfn pgis_asmvt_serialfn
  syn keyword sqlFunction contained pgis_asmvt_transfn pgis_geometry_accum_transfn
  syn keyword sqlFunction contained pgis_geometry_clusterintersecting_finalfn
  syn keyword sqlFunction contained pgis_geometry_clusterwithin_finalfn pgis_geometry_collect_finalfn
  syn keyword sqlFunction contained pgis_geometry_makeline_finalfn
  syn keyword sqlFunction contained pgis_geometry_polygonize_finalfn pgis_geometry_union_finalfn
  syn keyword sqlFunction contained point polygon populate_geometry_columns
  syn keyword sqlFunction contained postgis_addbbox postgis_cache_bbox
  syn keyword sqlFunction contained postgis_constraint_dims postgis_constraint_srid
  syn keyword sqlFunction contained postgis_constraint_type postgis_dropbbox
  syn keyword sqlFunction contained postgis_extensions_upgrade postgis_full_version postgis_geos_noop
  syn keyword sqlFunction contained postgis_geos_version postgis_getbbox
  syn keyword sqlFunction contained postgis_hasbbox postgis_index_supportfn
  syn keyword sqlFunction contained postgis_lib_build_date postgis_lib_revision
  syn keyword sqlFunction contained postgis_lib_version postgis_libjson_version
  syn keyword sqlFunction contained postgis_liblwgeom_version postgis_libprotobuf_version
  syn keyword sqlFunction contained postgis_libxml_version postgis_noop postgis_proj_version
  syn keyword sqlFunction contained postgis_scripts_build_date
  syn keyword sqlFunction contained postgis_scripts_installed postgis_scripts_released
  syn keyword sqlFunction contained postgis_svn_version postgis_transform_geometry
  syn keyword sqlFunction contained postgis_type_name postgis_typmod_dims postgis_typmod_srid
  syn keyword sqlFunction contained postgis_typmod_type postgis_version
  syn keyword sqlFunction contained postgis_wagyu_version spheroid_in spheroid_out
  syn keyword sqlFunction contained st_3dclosestpoint st_3ddfullywithin st_3ddistance
  syn keyword sqlFunction contained st_3ddwithin st_3dextent st_3dintersects
  syn keyword sqlFunction contained st_3dlength st_3dlineinterpolatepoint
  syn keyword sqlFunction contained st_3dlongestline st_3dmakebox st_3dmaxdistance
  syn keyword sqlFunction contained st_3dperimeter st_3dshortestline
  syn keyword sqlFunction contained st_addmeasure st_addpoint st_affine st_angle
  syn keyword sqlFunction contained st_area st_area2d st_asbinary
  syn keyword sqlFunction contained st_asencodedpolyline st_asewkb st_asewkt st_asgeobuf
  syn keyword sqlFunction contained st_asgeojson st_asgml st_ashexewkb
  syn keyword sqlFunction contained st_askml st_aslatlontext st_asmvt
  syn keyword sqlFunction contained st_asmvtgeom st_assvg st_astext st_astwkb
  syn keyword sqlFunction contained st_asx3d st_azimuth st_bdmpolyfromtext
  syn keyword sqlFunction contained st_bdpolyfromtext st_boundary st_boundingdiagonal
  syn keyword sqlFunction contained st_box2dfromgeohash st_buffer
  syn keyword sqlFunction contained st_buildarea st_centroid st_chaikinsmoothing
  syn keyword sqlFunction contained st_cleangeometry st_clipbybox2d st_closestpoint
  syn keyword sqlFunction contained st_closestpointofapproach st_clusterdbscan
  syn keyword sqlFunction contained st_clusterintersecting st_clusterkmeans
  syn keyword sqlFunction contained st_clusterwithin st_collect st_collectionextract
  syn keyword sqlFunction contained st_collectionhomogenize st_combinebbox
  syn keyword sqlFunction contained st_concavehull st_contains st_containsproperly
  syn keyword sqlFunction contained st_convexhull st_coorddim st_coveredby
  syn keyword sqlFunction contained st_covers st_cpawithin st_crosses st_curvetoline
  syn keyword sqlFunction contained st_delaunaytriangles st_dfullywithin
  syn keyword sqlFunction contained st_difference st_dimension st_disjoint
  syn keyword sqlFunction contained st_distance st_distancecpa st_distancesphere
  syn keyword sqlFunction contained st_distancespheroid st_dump st_dumppoints
  syn keyword sqlFunction contained st_dumprings st_dwithin st_endpoint
  syn keyword sqlFunction contained st_envelope st_equals st_estimatedextent
  syn keyword sqlFunction contained st_expand st_extent st_exteriorring
  syn keyword sqlFunction contained st_filterbym st_findextent st_flipcoordinates
  syn keyword sqlFunction contained st_force2d st_force3d st_force3dm st_force3dz
  syn keyword sqlFunction contained st_force4d st_forcecollection
  syn keyword sqlFunction contained st_forcecurve st_forcepolygonccw st_forcepolygoncw
  syn keyword sqlFunction contained st_forcerhr st_forcesfs st_frechetdistance
  syn keyword sqlFunction contained st_generatepoints st_geogfromtext
  syn keyword sqlFunction contained st_geogfromwkb st_geographyfromtext st_geohash
  syn keyword sqlFunction contained st_geomcollfromtext st_geomcollfromwkb
  syn keyword sqlFunction contained st_geometricmedian st_geometryfromtext st_geometryn
  syn keyword sqlFunction contained st_geometrytype st_geomfromewkb st_geomfromewkt
  syn keyword sqlFunction contained st_geomfromgeohash st_geomfromgeojson
  syn keyword sqlFunction contained st_geomfromgml st_geomfromkml st_geomfromtext
  syn keyword sqlFunction contained st_geomfromtwkb st_geomfromwkb st_gmltosql
  syn keyword sqlFunction contained st_hasarc st_hausdorffdistance st_hexagon
  syn keyword sqlFunction contained st_hexagongrid st_interiorringn
  syn keyword sqlFunction contained st_interpolatepoint st_intersection st_intersects
  syn keyword sqlFunction contained st_isclosed st_iscollection st_isempty
  syn keyword sqlFunction contained st_ispolygonccw st_ispolygoncw st_isring
  syn keyword sqlFunction contained st_issimple st_isvalid st_isvaliddetail
  syn keyword sqlFunction contained st_isvalidreason st_isvalidtrajectory st_length
  syn keyword sqlFunction contained st_length2d st_length2dspheroid
  syn keyword sqlFunction contained st_lengthspheroid st_linecrossingdirection
  syn keyword sqlFunction contained st_linefromencodedpolyline st_linefrommultipoint st_linefromtext
  syn keyword sqlFunction contained st_linefromwkb st_lineinterpolatepoint
  syn keyword sqlFunction contained st_lineinterpolatepoints st_linelocatepoint
  syn keyword sqlFunction contained st_linemerge st_linestringfromwkb st_linesubstring
  syn keyword sqlFunction contained st_linetocurve st_locatealong
  syn keyword sqlFunction contained st_locatebetween st_locatebetweenelevations st_longestline
  syn keyword sqlFunction contained st_m st_makebox2d st_makeenvelope
  syn keyword sqlFunction contained st_makeline st_makepoint st_makepointm
  syn keyword sqlFunction contained st_makepolygon st_makevalid st_maxdistance
  syn keyword sqlFunction contained st_maximuminscribedcircle st_memcollect
  syn keyword sqlFunction contained st_memsize st_memunion st_minimumboundingcircle
  syn keyword sqlFunction contained st_minimumboundingradius st_minimumclearance
  syn keyword sqlFunction contained st_minimumclearanceline st_mlinefromtext
  syn keyword sqlFunction contained st_mlinefromwkb st_mpointfromtext st_mpointfromwkb
  syn keyword sqlFunction contained st_mpolyfromtext st_mpolyfromwkb st_multi
  syn keyword sqlFunction contained st_multilinefromwkb st_multilinestringfromtext
  syn keyword sqlFunction contained st_multipointfromtext st_multipointfromwkb
  syn keyword sqlFunction contained st_multipolyfromwkb st_multipolygonfromtext
  syn keyword sqlFunction contained st_ndims st_node st_normalize st_npoints
  syn keyword sqlFunction contained st_nrings st_numgeometries st_numinteriorring
  syn keyword sqlFunction contained st_numinteriorrings st_numpatches
  syn keyword sqlFunction contained st_numpoints st_offsetcurve st_orderingequals
  syn keyword sqlFunction contained st_orientedenvelope st_overlaps st_patchn
  syn keyword sqlFunction contained st_perimeter st_perimeter2d st_point
  syn keyword sqlFunction contained st_pointfromgeohash st_pointfromtext st_pointfromwkb
  syn keyword sqlFunction contained st_pointinsidecircle st_pointn
  syn keyword sqlFunction contained st_pointonsurface st_points st_polyfromtext
  syn keyword sqlFunction contained st_polyfromwkb st_polygon st_polygonfromtext
  syn keyword sqlFunction contained st_polygonfromwkb st_polygonize st_project
  syn keyword sqlFunction contained st_quantizecoordinates st_reduceprecision
  syn keyword sqlFunction contained st_relate st_relatematch st_removepoint
  syn keyword sqlFunction contained st_removerepeatedpoints st_reverse st_rotate
  syn keyword sqlFunction contained st_rotatex st_rotatey st_rotatez st_scale
  syn keyword sqlFunction contained st_segmentize st_seteffectivearea
  syn keyword sqlFunction contained st_setpoint st_setsrid st_sharedpaths
  syn keyword sqlFunction contained st_shiftlongitude st_shortestline st_simplify
  syn keyword sqlFunction contained st_simplifypreservetopology st_simplifyvw st_snap
  syn keyword sqlFunction contained st_snaptogrid st_split st_square
  syn keyword sqlFunction contained st_squaregrid st_srid st_startpoint
  syn keyword sqlFunction contained st_subdivide st_summary st_swapordinates
  syn keyword sqlFunction contained st_symdifference st_symmetricdifference st_tileenvelope
  syn keyword sqlFunction contained st_touches st_transform st_translate
  syn keyword sqlFunction contained st_transscale st_unaryunion st_union
  syn keyword sqlFunction contained st_voronoilines st_voronoipolygons st_within
  syn keyword sqlFunction contained st_wkbtosql st_wkttosql st_wrapx st_x
  syn keyword sqlFunction contained st_xmax st_xmin st_y st_ymax
  syn keyword sqlFunction contained st_ymin st_z st_zmax st_zmflag
  syn keyword sqlFunction contained st_zmin text unlockrows updategeometrysrid
  syn keyword sqlTable contained spatial_ref_sys
  syn keyword sqlType contained box2d box2df box3d geography
  syn keyword sqlType contained geometry geometry_dump gidx spheroid
  syn keyword sqlType contained valid_detail
  syn keyword sqlView contained geography_columns geometry_columns
  syn keyword sqlFunction contained geometry_eq pgis_abs_in pgis_abs_out pgis_abs
endif " postgis
" Extension: unaccent (v1.1)
if index(get(g:, 'pgsql_disabled_extensions', []), 'unaccent') == -1
  syn keyword sqlFunction contained unaccent unaccent_init unaccent_lexize
endif " unaccent
" Extension: btree_gin (v1.3)
if index(get(g:, 'pgsql_disabled_extensions', []), 'btree_gin') == -1
  syn keyword sqlFunction contained gin_btree_consistent
  syn keyword sqlFunction contained gin_compare_prefix_anyenum gin_compare_prefix_bit
  syn keyword sqlFunction contained gin_compare_prefix_bool gin_compare_prefix_bpchar
  syn keyword sqlFunction contained gin_compare_prefix_bytea gin_compare_prefix_char
  syn keyword sqlFunction contained gin_compare_prefix_cidr gin_compare_prefix_date
  syn keyword sqlFunction contained gin_compare_prefix_float4 gin_compare_prefix_float8
  syn keyword sqlFunction contained gin_compare_prefix_inet gin_compare_prefix_int2
  syn keyword sqlFunction contained gin_compare_prefix_int4 gin_compare_prefix_int8
  syn keyword sqlFunction contained gin_compare_prefix_interval gin_compare_prefix_macaddr
  syn keyword sqlFunction contained gin_compare_prefix_macaddr8 gin_compare_prefix_money
  syn keyword sqlFunction contained gin_compare_prefix_name
  syn keyword sqlFunction contained gin_compare_prefix_numeric gin_compare_prefix_oid
  syn keyword sqlFunction contained gin_compare_prefix_text gin_compare_prefix_time
  syn keyword sqlFunction contained gin_compare_prefix_timestamp gin_compare_prefix_timestamptz
  syn keyword sqlFunction contained gin_compare_prefix_timetz gin_compare_prefix_uuid
  syn keyword sqlFunction contained gin_compare_prefix_varbit gin_enum_cmp
  syn keyword sqlFunction contained gin_extract_query_anyenum gin_extract_query_bit
  syn keyword sqlFunction contained gin_extract_query_bool gin_extract_query_bpchar
  syn keyword sqlFunction contained gin_extract_query_bytea gin_extract_query_char
  syn keyword sqlFunction contained gin_extract_query_cidr gin_extract_query_date
  syn keyword sqlFunction contained gin_extract_query_float4 gin_extract_query_float8
  syn keyword sqlFunction contained gin_extract_query_inet gin_extract_query_int2
  syn keyword sqlFunction contained gin_extract_query_int4 gin_extract_query_int8
  syn keyword sqlFunction contained gin_extract_query_interval gin_extract_query_macaddr
  syn keyword sqlFunction contained gin_extract_query_macaddr8 gin_extract_query_money
  syn keyword sqlFunction contained gin_extract_query_name gin_extract_query_numeric
  syn keyword sqlFunction contained gin_extract_query_oid gin_extract_query_text
  syn keyword sqlFunction contained gin_extract_query_time gin_extract_query_timestamp
  syn keyword sqlFunction contained gin_extract_query_timestamptz
  syn keyword sqlFunction contained gin_extract_query_timetz gin_extract_query_uuid
  syn keyword sqlFunction contained gin_extract_query_varbit gin_extract_value_anyenum
  syn keyword sqlFunction contained gin_extract_value_bit gin_extract_value_bool
  syn keyword sqlFunction contained gin_extract_value_bpchar gin_extract_value_bytea
  syn keyword sqlFunction contained gin_extract_value_char gin_extract_value_cidr
  syn keyword sqlFunction contained gin_extract_value_date gin_extract_value_float4
  syn keyword sqlFunction contained gin_extract_value_float8 gin_extract_value_inet
  syn keyword sqlFunction contained gin_extract_value_int2 gin_extract_value_int4
  syn keyword sqlFunction contained gin_extract_value_int8 gin_extract_value_interval
  syn keyword sqlFunction contained gin_extract_value_macaddr gin_extract_value_macaddr8
  syn keyword sqlFunction contained gin_extract_value_money gin_extract_value_name
  syn keyword sqlFunction contained gin_extract_value_numeric gin_extract_value_oid
  syn keyword sqlFunction contained gin_extract_value_text gin_extract_value_time
  syn keyword sqlFunction contained gin_extract_value_timestamp gin_extract_value_timestamptz
  syn keyword sqlFunction contained gin_extract_value_timetz
  syn keyword sqlFunction contained gin_extract_value_uuid gin_extract_value_varbit gin_numeric_cmp
endif " btree_gin
" Extension: ltree (v1.2)
if index(get(g:, 'pgsql_disabled_extensions', []), 'ltree') == -1
  syn keyword sqlFunction contained index lca lquery_in lquery_out
  syn keyword sqlFunction contained lquery_recv lquery_send lt_q_regex
  syn keyword sqlFunction contained lt_q_rregex ltq_regex ltq_rregex ltree2text
  syn keyword sqlFunction contained ltree_addltree ltree_addtext ltree_cmp
  syn keyword sqlFunction contained ltree_compress ltree_consistent
  syn keyword sqlFunction contained ltree_decompress ltree_eq ltree_ge ltree_gist_in
  syn keyword sqlFunction contained ltree_gist_options ltree_gist_out ltree_gt
  syn keyword sqlFunction contained ltree_in ltree_isparent ltree_le
  syn keyword sqlFunction contained ltree_lt ltree_ne ltree_out ltree_penalty
  syn keyword sqlFunction contained ltree_picksplit ltree_recv ltree_risparent
  syn keyword sqlFunction contained ltree_same ltree_send ltree_textadd
  syn keyword sqlFunction contained ltree_union ltreeparentsel ltxtq_exec
  syn keyword sqlFunction contained ltxtq_in ltxtq_out ltxtq_recv ltxtq_rexec
  syn keyword sqlFunction contained ltxtq_send nlevel subltree subpath
  syn keyword sqlFunction contained text2ltree
  syn keyword sqlType contained lquery ltree ltree_gist ltxtquery
endif " ltree
" Extension: tsm_system_rows (v1.0)
if index(get(g:, 'pgsql_disabled_extensions', []), 'tsm_system_rows') == -1
  syn keyword sqlFunction contained system_rows
endif " tsm_system_rows
" Extension: temporal_tables (v1.2.0)
if index(get(g:, 'pgsql_disabled_extensions', []), 'temporal_tables') == -1
  syn keyword sqlFunction contained set_system_time versioning
endif " temporal_tables
" Extension: jsonb_plperl (v1.0)
if index(get(g:, 'pgsql_disabled_extensions', []), 'jsonb_plperl') == -1
  syn keyword sqlFunction contained jsonb_to_plperl plperl_to_jsonb
endif " jsonb_plperl
" Extension: adminpack (v2.1)
if index(get(g:, 'pgsql_disabled_extensions', []), 'adminpack') == -1
  syn keyword sqlFunction contained pg_file_rename pg_file_sync pg_file_unlink pg_file_write
  syn keyword sqlFunction contained pg_logdir_ls
endif " adminpack
" Extension: dict_xsyn (v1.0)
if index(get(g:, 'pgsql_disabled_extensions', []), 'dict_xsyn') == -1
  syn keyword sqlFunction contained dxsyn_init dxsyn_lexize
endif " dict_xsyn
" Extension: bool_plperlu (v1.0)
if index(get(g:, 'pgsql_disabled_extensions', []), 'bool_plperlu') == -1
  syn keyword sqlFunction contained bool_to_plperlu plperlu_to_bool
endif " bool_plperlu
" Extension: address_standardizer (v3.1.1)
if index(get(g:, 'pgsql_disabled_extensions', []), 'address_standardizer') == -1
  syn keyword sqlFunction contained parse_address standardize_address
  syn keyword sqlType contained stdaddr
endif " address_standardizer
" Extension: hstore_plperlu (v1.0)
if index(get(g:, 'pgsql_disabled_extensions', []), 'hstore_plperlu') == -1
  syn keyword sqlFunction contained hstore_to_plperlu plperlu_to_hstore
endif " hstore_plperlu
" Extension: xml2 (v1.1)
if index(get(g:, 'pgsql_disabled_extensions', []), 'xml2') == -1
  syn keyword sqlFunction contained xml_encode_special_chars xml_valid
  syn keyword sqlFunction contained xpath_bool xpath_list xpath_nodeset
  syn keyword sqlFunction contained xpath_number xpath_string xpath_table xslt_process
endif " xml2
" Extension: hstore (v1.7)
if index(get(g:, 'pgsql_disabled_extensions', []), 'hstore') == -1
  syn keyword sqlFunction contained akeys avals defined delete
  syn keyword sqlFunction contained each exist exists_all exists_any
  syn keyword sqlFunction contained fetchval ghstore_compress ghstore_consistent
  syn keyword sqlFunction contained ghstore_decompress ghstore_in ghstore_options
  syn keyword sqlFunction contained ghstore_out ghstore_penalty
  syn keyword sqlFunction contained ghstore_picksplit ghstore_same ghstore_union
  syn keyword sqlFunction contained gin_consistent_hstore gin_extract_hstore
  syn keyword sqlFunction contained gin_extract_hstore_query hs_concat hs_contained
  syn keyword sqlFunction contained hs_contains hstore hstore_cmp hstore_eq
  syn keyword sqlFunction contained hstore_ge hstore_gt hstore_hash
  syn keyword sqlFunction contained hstore_hash_extended hstore_in hstore_le hstore_lt
  syn keyword sqlFunction contained hstore_ne hstore_out hstore_recv
  syn keyword sqlFunction contained hstore_send hstore_to_array hstore_to_json
  syn keyword sqlFunction contained hstore_to_json_loose hstore_to_jsonb
  syn keyword sqlFunction contained hstore_to_jsonb_loose hstore_to_matrix hstore_version_diag
  syn keyword sqlFunction contained isdefined isexists populate_record
  syn keyword sqlFunction contained skeys slice slice_array svals
  syn keyword sqlFunction contained tconvert
  syn keyword sqlType contained ghstore hstore
endif " hstore
" Extension: pg_visibility (v1.2)
if index(get(g:, 'pgsql_disabled_extensions', []), 'pg_visibility') == -1
  syn keyword sqlFunction contained pg_check_frozen pg_check_visible
  syn keyword sqlFunction contained pg_truncate_visibility_map pg_visibility
  syn keyword sqlFunction contained pg_visibility_map pg_visibility_map_summary
endif " pg_visibility
" Extension: cube (v1.4)
if index(get(g:, 'pgsql_disabled_extensions', []), 'cube') == -1
  syn keyword sqlFunction contained cube cube_cmp cube_contained
  syn keyword sqlFunction contained cube_contains cube_coord cube_coord_llur
  syn keyword sqlFunction contained cube_dim cube_distance cube_enlarge cube_eq
  syn keyword sqlFunction contained cube_ge cube_gt cube_in cube_inter
  syn keyword sqlFunction contained cube_is_point cube_le cube_ll_coord
  syn keyword sqlFunction contained cube_lt cube_ne cube_out cube_overlap
  syn keyword sqlFunction contained cube_size cube_subset cube_union
  syn keyword sqlFunction contained cube_ur_coord distance_chebyshev distance_taxicab
  syn keyword sqlFunction contained g_cube_consistent g_cube_distance
  syn keyword sqlFunction contained g_cube_penalty g_cube_picksplit g_cube_same
  syn keyword sqlFunction contained g_cube_union
  syn keyword sqlType contained cube
  syn keyword sqlFunction contained g_cube_compress g_cube_decompress
endif " cube
" Extension: postgis_tiger_geocoder (v3.1.1)
if index(get(g:, 'pgsql_disabled_extensions', []), 'postgis_tiger_geocoder') == -1
  syn keyword sqlFunction contained count_words create_census_base_tables
  syn keyword sqlFunction contained cull_null diff_zip
  syn keyword sqlFunction contained drop_dupe_featnames_generate_script drop_indexes_generate_script
  syn keyword sqlFunction contained drop_nation_tables_generate_script drop_state_tables_generate_script
  syn keyword sqlFunction contained end_soundex geocode geocode_address
  syn keyword sqlFunction contained geocode_intersection geocode_location
  syn keyword sqlFunction contained get_geocode_setting get_last_words get_tract greatest_hn
  syn keyword sqlFunction contained includes_address install_geocode_settings
  syn keyword sqlFunction contained install_missing_indexes install_pagc_tables
  syn keyword sqlFunction contained interpolate_from_address is_pretype least_hn
  syn keyword sqlFunction contained levenshtein_ignore_case loader_generate_census_script
  syn keyword sqlFunction contained loader_generate_nation_script loader_generate_script
  syn keyword sqlFunction contained loader_load_staged_data loader_macro_replace
  syn keyword sqlFunction contained location_extract location_extract_countysub_exact
  syn keyword sqlFunction contained location_extract_countysub_fuzzy
  syn keyword sqlFunction contained location_extract_place_exact location_extract_place_fuzzy
  syn keyword sqlFunction contained missing_indexes_generate_script normalize_address
  syn keyword sqlFunction contained nullable_levenshtein numeric_streets_equal
  syn keyword sqlFunction contained pagc_normalize_address pprint_addy rate_attributes
  syn keyword sqlFunction contained reverse_geocode set_geocode_setting setsearchpathforinstall
  syn keyword sqlFunction contained state_extract topology_load_tiger utmzone
  syn keyword sqlFunction contained zip_range
  syn keyword sqlTable contained addr addrfeat bg county
  syn keyword sqlTable contained county_lookup countysub_lookup cousub
  syn keyword sqlTable contained direction_lookup edges faces featnames
  syn keyword sqlTable contained geocode_settings geocode_settings_default loader_lookuptables
  syn keyword sqlTable contained loader_platform loader_variables pagc_gaz
  syn keyword sqlTable contained pagc_lex pagc_rules place place_lookup
  syn keyword sqlTable contained secondary_unit_lookup state state_lookup
  syn keyword sqlTable contained street_type_lookup tabblock tract zcta5
  syn keyword sqlTable contained zip_lookup zip_lookup_all zip_lookup_base
  syn keyword sqlTable contained zip_state zip_state_loc
  syn keyword sqlType contained norm_addy
endif " postgis_tiger_geocoder
" Extension: seg (v1.3)
if index(get(g:, 'pgsql_disabled_extensions', []), 'seg') == -1
  syn keyword sqlFunction contained gseg_consistent gseg_penalty
  syn keyword sqlFunction contained gseg_picksplit gseg_same gseg_union seg_center
  syn keyword sqlFunction contained seg_cmp seg_contained seg_contains
  syn keyword sqlFunction contained seg_different seg_ge seg_gt seg_in
  syn keyword sqlFunction contained seg_inter seg_le seg_left seg_lower
  syn keyword sqlFunction contained seg_lt seg_out seg_over_left seg_over_right
  syn keyword sqlFunction contained seg_overlap seg_right seg_same
  syn keyword sqlFunction contained seg_size seg_union seg_upper
  syn keyword sqlType contained seg
  syn keyword sqlFunction contained gseg_compress gseg_decompress
endif " seg
" Extension: intagg (v1.1)
if index(get(g:, 'pgsql_disabled_extensions', []), 'intagg') == -1
  syn keyword sqlFunction contained int_agg_final_array int_agg_state
  syn keyword sqlFunction contained int_array_aggregate int_array_enum
endif " intagg
" Extension: tcn (v1.0)
if index(get(g:, 'pgsql_disabled_extensions', []), 'tcn') == -1
  syn keyword sqlFunction contained triggered_change_notification
endif " tcn
" Extension: isn (v1.2)
if index(get(g:, 'pgsql_disabled_extensions', []), 'isn') == -1
  syn keyword sqlFunction contained btean13cmp btisbn13cmp btisbncmp
  syn keyword sqlFunction contained btismn13cmp btismncmp btissn13cmp
  syn keyword sqlFunction contained btissncmp btupccmp ean13_in ean13_out
  syn keyword sqlFunction contained hashean13 hashisbn hashisbn13 hashismn
  syn keyword sqlFunction contained hashismn13 hashissn hashissn13 hashupc
  syn keyword sqlFunction contained is_valid isbn isbn13 isbn13_in
  syn keyword sqlFunction contained isbn_in ismn ismn13 ismn13_in
  syn keyword sqlFunction contained ismn_in isn_out isn_weak isneq isnge
  syn keyword sqlFunction contained isngt isnle isnlt isnne issn
  syn keyword sqlFunction contained issn13 issn13_in issn_in make_valid
  syn keyword sqlFunction contained upc upc_in
  syn keyword sqlType contained ean13 isbn isbn13 ismn
  syn keyword sqlType contained ismn13 issn issn13 upc
endif " isn
" Extension: tsm_system_time (v1.0)
if index(get(g:, 'pgsql_disabled_extensions', []), 'tsm_system_time') == -1
  syn keyword sqlFunction contained system_time
endif " tsm_system_time
" Extension: lo (v1.1)
if index(get(g:, 'pgsql_disabled_extensions', []), 'lo') == -1
  syn keyword sqlFunction contained lo_manage lo_oid
  syn keyword sqlType contained lo
endif " lo
" Extension: pgrowlocks (v1.2)
if index(get(g:, 'pgsql_disabled_extensions', []), 'pgrowlocks') == -1
  syn keyword sqlFunction contained pgrowlocks
endif " pgrowlocks
" Extension: sslinfo (v1.2)
if index(get(g:, 'pgsql_disabled_extensions', []), 'sslinfo') == -1
  syn keyword sqlFunction contained ssl_cipher ssl_client_cert_present
  syn keyword sqlFunction contained ssl_client_dn ssl_client_dn_field ssl_client_serial
  syn keyword sqlFunction contained ssl_extension_info ssl_is_used
  syn keyword sqlFunction contained ssl_issuer_dn ssl_issuer_field ssl_version
endif " sslinfo
" Extension: pgstattuple (v1.5)
if index(get(g:, 'pgsql_disabled_extensions', []), 'pgstattuple') == -1
  syn keyword sqlFunction contained pg_relpages pgstatginindex
  syn keyword sqlFunction contained pgstathashindex pgstatindex pgstattuple
  syn keyword sqlFunction contained pgstattuple_approx
endif " pgstattuple
" Extension: autoinc (v1.0)
if index(get(g:, 'pgsql_disabled_extensions', []), 'autoinc') == -1
  syn keyword sqlFunction contained autoinc
endif " autoinc
" Extension: address_standardizer_data_us (v3.1.1)
if index(get(g:, 'pgsql_disabled_extensions', []), 'address_standardizer_data_us') == -1
  syn keyword sqlTable contained us_gaz us_lex us_rules
endif " address_standardizer_data_us
" Extension: postgis_topology (v3.1.1)
if index(get(g:, 'pgsql_disabled_extensions', []), 'postgis_topology') == -1
  syn keyword sqlFunction contained addedge addface addnode
  syn keyword sqlFunction contained addtopogeometrycolumn addtosearchpath asgml
  syn keyword sqlFunction contained astopojson cleartopogeom
  syn keyword sqlFunction contained copytopology createtopogeom createtopology
  syn keyword sqlFunction contained droptopogeometrycolumn droptopology equals
  syn keyword sqlFunction contained geometry geometrytype getedgebypoint
  syn keyword sqlFunction contained getfacebypoint getnodebypoint
  syn keyword sqlFunction contained getnodeedges getringedges
  syn keyword sqlFunction contained gettopogeomelementarray gettopogeomelements gettopologyid
  syn keyword sqlFunction contained gettopologyname gettopologysrid intersects
  syn keyword sqlFunction contained layertrigger polygonize
  syn keyword sqlFunction contained populate_topology_layer postgis_topology_scripts_installed
  syn keyword sqlFunction contained relationtrigger st_addedgemodface
  syn keyword sqlFunction contained st_addedgenewfaces st_addisoedge st_addisonode
  syn keyword sqlFunction contained st_changeedgegeom st_createtopogeo
  syn keyword sqlFunction contained st_geometrytype st_getfaceedges
  syn keyword sqlFunction contained st_getfacegeometry st_inittopogeo st_modedgeheal
  syn keyword sqlFunction contained st_modedgesplit st_moveisonode
  syn keyword sqlFunction contained st_newedgeheal st_newedgessplit st_remedgemodface
  syn keyword sqlFunction contained st_remedgenewface st_remisonode
  syn keyword sqlFunction contained st_removeisoedge st_removeisonode st_simplify
  syn keyword sqlFunction contained topoelementarray_agg topoelementarray_append
  syn keyword sqlFunction contained topogeo_addgeometry topogeo_addlinestring
  syn keyword sqlFunction contained topogeo_addpoint topogeo_addpolygon
  syn keyword sqlFunction contained topogeom_addelement topogeom_remelement
  syn keyword sqlFunction contained topologysummary totopogeom validatetopology
  syn keyword sqlTable contained layer topology
  syn keyword sqlType contained getfaceedges_returntype topoelement
  syn keyword sqlType contained topoelementarray topogeometry
  syn keyword sqlType contained validatetopology_returntype
endif " postgis_topology
" Extension: postgis_raster (v3.1.1)
if index(get(g:, 'pgsql_disabled_extensions', []), 'postgis_raster') == -1
  syn keyword sqlFunction contained addoverviewconstraints addrasterconstraints
  syn keyword sqlFunction contained box3d bytea dropoverviewconstraints
  syn keyword sqlFunction contained droprasterconstraints geometry_contained_by_raster
  syn keyword sqlFunction contained geometry_raster_contain geometry_raster_overlap
  syn keyword sqlFunction contained postgis_gdal_version postgis_noop
  syn keyword sqlFunction contained postgis_raster_lib_build_date postgis_raster_lib_version
  syn keyword sqlFunction contained postgis_raster_scripts_installed raster_above
  syn keyword sqlFunction contained raster_below raster_contain raster_contained
  syn keyword sqlFunction contained raster_contained_by_geometry raster_eq
  syn keyword sqlFunction contained raster_geometry_contain raster_geometry_overlap
  syn keyword sqlFunction contained raster_hash raster_in raster_left
  syn keyword sqlFunction contained raster_out raster_overabove raster_overbelow
  syn keyword sqlFunction contained raster_overlap raster_overleft raster_overright
  syn keyword sqlFunction contained raster_right raster_same st_addband
  syn keyword sqlFunction contained st_approxcount st_approxhistogram
  syn keyword sqlFunction contained st_approxquantile st_approxsummarystats st_asbinary
  syn keyword sqlFunction contained st_asgdalraster st_ashexwkb st_asjpeg
  syn keyword sqlFunction contained st_aspect st_aspng st_asraster st_astiff
  syn keyword sqlFunction contained st_aswkb st_band st_bandfilesize
  syn keyword sqlFunction contained st_bandfiletimestamp st_bandisnodata st_bandmetadata
  syn keyword sqlFunction contained st_bandnodatavalue st_bandpath
  syn keyword sqlFunction contained st_bandpixeltype st_clip st_colormap st_contains
  syn keyword sqlFunction contained st_containsproperly st_convexhull st_count
  syn keyword sqlFunction contained st_countagg st_coveredby st_covers
  syn keyword sqlFunction contained st_createoverview st_dfullywithin st_disjoint
  syn keyword sqlFunction contained st_distinct4ma st_dumpaspolygons st_dumpvalues
  syn keyword sqlFunction contained st_dwithin st_envelope st_fromgdalraster
  syn keyword sqlFunction contained st_gdaldrivers st_georeference
  syn keyword sqlFunction contained st_geotransform st_grayscale st_hasnoband
  syn keyword sqlFunction contained st_height st_hillshade st_histogram
  syn keyword sqlFunction contained st_intersection st_intersects st_invdistweight4ma
  syn keyword sqlFunction contained st_iscoveragetile st_isempty st_makeemptycoverage
  syn keyword sqlFunction contained st_makeemptyraster st_mapalgebra
  syn keyword sqlFunction contained st_mapalgebraexpr st_mapalgebrafct st_mapalgebrafctngb
  syn keyword sqlFunction contained st_max4ma st_mean4ma st_memsize
  syn keyword sqlFunction contained st_metadata st_min4ma st_minconvexhull
  syn keyword sqlFunction contained st_mindist4ma st_minpossiblevalue st_nearestvalue
  syn keyword sqlFunction contained st_neighborhood st_notsamealignmentreason
  syn keyword sqlFunction contained st_numbands st_overlaps st_pixelascentroid
  syn keyword sqlFunction contained st_pixelascentroids st_pixelaspoint
  syn keyword sqlFunction contained st_pixelaspoints st_pixelaspolygon st_pixelaspolygons
  syn keyword sqlFunction contained st_pixelheight st_pixelofvalue st_pixelwidth
  syn keyword sqlFunction contained st_polygon st_quantile st_range4ma
  syn keyword sqlFunction contained st_rastertoworldcoord st_rastertoworldcoordx
  syn keyword sqlFunction contained st_rastertoworldcoordy st_rastfromhexwkb
  syn keyword sqlFunction contained st_rastfromwkb st_reclass st_resample st_rescale
  syn keyword sqlFunction contained st_resize st_reskew st_retile
  syn keyword sqlFunction contained st_rotation st_roughness st_samealignment
  syn keyword sqlFunction contained st_scalex st_scaley st_setbandindex
  syn keyword sqlFunction contained st_setbandisnodata st_setbandnodatavalue st_setbandpath
  syn keyword sqlFunction contained st_setgeoreference st_setgeotransform
  syn keyword sqlFunction contained st_setrotation st_setscale st_setskew
  syn keyword sqlFunction contained st_setsrid st_setupperleft st_setvalue
  syn keyword sqlFunction contained st_setvalues st_skewx st_skewy st_slope
  syn keyword sqlFunction contained st_snaptogrid st_srid st_stddev4ma st_sum4ma
  syn keyword sqlFunction contained st_summary st_summarystats
  syn keyword sqlFunction contained st_summarystatsagg st_tile st_touches st_tpi
  syn keyword sqlFunction contained st_transform st_tri st_union st_upperleftx
  syn keyword sqlFunction contained st_upperlefty st_value st_valuecount
  syn keyword sqlFunction contained st_valuepercent st_width st_within
  syn keyword sqlFunction contained st_worldtorastercoord st_worldtorastercoordx
  syn keyword sqlFunction contained st_worldtorastercoordy updaterastersrid
  syn keyword sqlType contained addbandarg agg_count agg_samealignment
  syn keyword sqlType contained geomval rastbandarg raster
  syn keyword sqlType contained reclassarg summarystats unionarg
  syn keyword sqlView contained raster_columns raster_overviews
endif " postgis_raster
" Extension: pg_freespacemap (v1.2)
if index(get(g:, 'pgsql_disabled_extensions', []), 'pg_freespacemap') == -1
  syn keyword sqlFunction contained pg_freespace
endif " pg_freespacemap
" Extension: file_fdw (v1.0)
if index(get(g:, 'pgsql_disabled_extensions', []), 'file_fdw') == -1
  syn keyword sqlFunction contained file_fdw_handler file_fdw_validator
endif " file_fdw
" Extension: pg_buffercache (v1.3)
if index(get(g:, 'pgsql_disabled_extensions', []), 'pg_buffercache') == -1
  syn keyword sqlFunction contained pg_buffercache_pages
  syn keyword sqlView contained pg_buffercache
endif " pg_buffercache
" Extension: dblink (v1.2)
if index(get(g:, 'pgsql_disabled_extensions', []), 'dblink') == -1
  syn keyword sqlFunction contained dblink dblink_build_sql_delete
  syn keyword sqlFunction contained dblink_build_sql_insert dblink_build_sql_update
  syn keyword sqlFunction contained dblink_cancel_query dblink_close dblink_connect
  syn keyword sqlFunction contained dblink_connect_u dblink_current_query
  syn keyword sqlFunction contained dblink_disconnect dblink_error_message dblink_exec
  syn keyword sqlFunction contained dblink_fdw_validator dblink_fetch
  syn keyword sqlFunction contained dblink_get_connections dblink_get_notify dblink_get_pkey
  syn keyword sqlFunction contained dblink_get_result dblink_is_busy
  syn keyword sqlFunction contained dblink_open dblink_send_query
  syn keyword sqlType contained dblink_pkey_results
endif " dblink
" Extension: pg_stat_statements (v1.8)
if index(get(g:, 'pgsql_disabled_extensions', []), 'pg_stat_statements') == -1
  syn keyword sqlFunction contained pg_stat_statements pg_stat_statements_reset
  syn keyword sqlView contained pg_stat_statements
endif " pg_stat_statements
" Extension: insert_username (v1.0)
if index(get(g:, 'pgsql_disabled_extensions', []), 'insert_username') == -1
  syn keyword sqlFunction contained insert_username
endif " insert_username
" Extension: pg_prewarm (v1.2)
if index(get(g:, 'pgsql_disabled_extensions', []), 'pg_prewarm') == -1
  syn keyword sqlFunction contained autoprewarm_dump_now autoprewarm_start_worker
  syn keyword sqlFunction contained pg_prewarm
endif " pg_prewarm
" Extension: pgtap (v1.1.0)
if index(get(g:, 'pgsql_disabled_extensions', []), 'pgtap') == -1
  syn keyword sqlFunction contained is add_result alike
  syn keyword sqlFunction contained any_column_privs_are bag_eq bag_has bag_hasnt
  syn keyword sqlFunction contained bag_ne can cast_context_is casts_are
  syn keyword sqlFunction contained check_test cmp_ok col_default_is
  syn keyword sqlFunction contained col_has_check col_has_default col_hasnt_default
  syn keyword sqlFunction contained col_is_fk col_is_null col_is_pk
  syn keyword sqlFunction contained col_is_unique col_isnt_fk col_isnt_pk
  syn keyword sqlFunction contained col_not_null col_type_is collect_tap
  syn keyword sqlFunction contained column_privs_are columns_are composite_owner_is
  syn keyword sqlFunction contained database_privs_are db_owner_is diag
  syn keyword sqlFunction contained diag_test_name display_oper do_tap doesnt_imatch
  syn keyword sqlFunction contained doesnt_match domain_type_is domain_type_isnt
  syn keyword sqlFunction contained domains_are enum_has_labels enums_are
  syn keyword sqlFunction contained extensions_are fail fdw_privs_are
  syn keyword sqlFunction contained findfuncs finish fk_ok foreign_table_owner_is
  syn keyword sqlFunction contained foreign_tables_are function_lang_is
  syn keyword sqlFunction contained function_owner_is function_privs_are
  syn keyword sqlFunction contained function_returns functions_are groups_are has_cast
  syn keyword sqlFunction contained has_check has_column has_composite
  syn keyword sqlFunction contained has_domain has_enum has_extension has_fk
  syn keyword sqlFunction contained has_foreign_table has_function has_group
  syn keyword sqlFunction contained has_index has_inherited_tables has_language
  syn keyword sqlFunction contained has_leftop has_materialized_view
  syn keyword sqlFunction contained has_opclass has_operator has_pk has_relation
  syn keyword sqlFunction contained has_rightop has_role has_rule has_schema
  syn keyword sqlFunction contained has_sequence has_table has_tablespace
  syn keyword sqlFunction contained has_trigger has_type has_unique
  syn keyword sqlFunction contained has_user has_view hasnt_cast hasnt_column
  syn keyword sqlFunction contained hasnt_composite hasnt_domain hasnt_enum
  syn keyword sqlFunction contained hasnt_extension hasnt_fk hasnt_foreign_table
  syn keyword sqlFunction contained hasnt_function hasnt_group hasnt_index
  syn keyword sqlFunction contained hasnt_inherited_tables hasnt_language
  syn keyword sqlFunction contained hasnt_materialized_view hasnt_opclass hasnt_pk
  syn keyword sqlFunction contained hasnt_relation hasnt_role hasnt_rule
  syn keyword sqlFunction contained hasnt_schema hasnt_sequence hasnt_table
  syn keyword sqlFunction contained hasnt_tablespace hasnt_trigger hasnt_type
  syn keyword sqlFunction contained hasnt_user hasnt_view ialike imatches
  syn keyword sqlFunction contained in_todo index_is_primary index_is_type
  syn keyword sqlFunction contained index_is_unique index_owner_is indexes_are
  syn keyword sqlFunction contained is_aggregate is_ancestor_of is_clustered
  syn keyword sqlFunction contained is_definer is_descendent_of is_empty
  syn keyword sqlFunction contained is_indexed is_member_of is_partition_of
  syn keyword sqlFunction contained is_partitioned is_strict is_superuser isa_ok
  syn keyword sqlFunction contained isnt isnt_aggregate isnt_ancestor_of
  syn keyword sqlFunction contained isnt_definer isnt_descendent_of isnt_empty
  syn keyword sqlFunction contained isnt_partitioned isnt_strict isnt_superuser
  syn keyword sqlFunction contained language_is_trusted language_owner_is
  syn keyword sqlFunction contained language_privs_are languages_are lives_ok
  syn keyword sqlFunction contained matches materialized_view_owner_is
  syn keyword sqlFunction contained materialized_views_are no_plan num_failed ok
  syn keyword sqlFunction contained opclass_owner_is opclasses_are operators_are
  syn keyword sqlFunction contained os_name partitions_are pass performs_ok
  syn keyword sqlFunction contained performs_within pg_version pg_version_num
  syn keyword sqlFunction contained pgtap_version plan policies_are
  syn keyword sqlFunction contained policy_cmd_is policy_roles_are relation_owner_is
  syn keyword sqlFunction contained results_eq results_ne roles_are row_eq
  syn keyword sqlFunction contained rule_is_instead rule_is_on rules_are
  syn keyword sqlFunction contained runtests schema_owner_is schema_privs_are
  syn keyword sqlFunction contained schemas_are sequence_owner_is
  syn keyword sqlFunction contained sequence_privs_are sequences_are server_privs_are
  syn keyword sqlFunction contained set_eq set_has set_hasnt set_ne skip
  syn keyword sqlFunction contained table_owner_is table_privs_are tables_are
  syn keyword sqlFunction contained tablespace_owner_is tablespace_privs_are
  syn keyword sqlFunction contained tablespaces_are throws_ilike throws_imatching
  syn keyword sqlFunction contained throws_like throws_matching throws_ok
  syn keyword sqlFunction contained todo todo_end todo_start trigger_is
  syn keyword sqlFunction contained triggers_are type_owner_is types_are
  syn keyword sqlFunction contained unalike unialike users_are view_owner_is
  syn keyword sqlFunction contained views_are volatility_is
  syn keyword sqlView contained pg_all_foreign_keys tap_funky
endif " pgtap
" Extension: earthdistance (v1.1)
if index(get(g:, 'pgsql_disabled_extensions', []), 'earthdistance') == -1
  syn keyword sqlFunction contained earth earth_box earth_distance
  syn keyword sqlFunction contained gc_to_sec geo_distance latitude ll_to_earth
  syn keyword sqlFunction contained longitude sec_to_gc
  syn keyword sqlType contained earth
endif " earthdistance
" Extension: uuid-ossp (v1.1)
if index(get(g:, 'pgsql_disabled_extensions', []), 'uuid-ossp') == -1
  syn keyword sqlFunction contained uuid_generate_v1 uuid_generate_v1mc
  syn keyword sqlFunction contained uuid_generate_v3 uuid_generate_v4 uuid_generate_v5
  syn keyword sqlFunction contained uuid_nil uuid_ns_dns uuid_ns_oid
  syn keyword sqlFunction contained uuid_ns_url uuid_ns_x500
endif " uuid-ossp
" Extension: plperlu (v1.0)
if index(get(g:, 'pgsql_disabled_extensions', []), 'plperlu') == -1
  syn keyword sqlFunction contained plperlu_call_handler plperlu_inline_handler
  syn keyword sqlFunction contained plperlu_validator
endif " plperlu
" Extension: intarray (v1.3)
if index(get(g:, 'pgsql_disabled_extensions', []), 'intarray') == -1
  syn keyword sqlFunction contained boolop bqarr_in bqarr_out
  syn keyword sqlFunction contained g_int_compress g_int_consistent g_int_decompress
  syn keyword sqlFunction contained g_int_options g_int_penalty g_int_picksplit
  syn keyword sqlFunction contained g_int_same g_int_union g_intbig_compress
  syn keyword sqlFunction contained g_intbig_consistent g_intbig_decompress
  syn keyword sqlFunction contained g_intbig_options g_intbig_penalty
  syn keyword sqlFunction contained g_intbig_picksplit g_intbig_same g_intbig_union
  syn keyword sqlFunction contained ginint4_consistent ginint4_queryextract icount idx
  syn keyword sqlFunction contained intarray_del_elem intarray_push_array
  syn keyword sqlFunction contained intarray_push_elem intset intset_subtract
  syn keyword sqlFunction contained intset_union_elem querytree rboolop sort
  syn keyword sqlFunction contained sort_asc sort_desc subarray uniq
  syn keyword sqlType contained intbig_gkey query_int
endif " intarray
" Extension: pg_trgm (v1.5)
if index(get(g:, 'pgsql_disabled_extensions', []), 'pg_trgm') == -1
  syn keyword sqlFunction contained gin_extract_query_trgm gin_extract_value_trgm
  syn keyword sqlFunction contained gin_trgm_consistent gin_trgm_triconsistent
  syn keyword sqlFunction contained gtrgm_compress gtrgm_consistent
  syn keyword sqlFunction contained gtrgm_decompress gtrgm_distance gtrgm_in
  syn keyword sqlFunction contained gtrgm_options gtrgm_out gtrgm_penalty gtrgm_picksplit
  syn keyword sqlFunction contained gtrgm_same gtrgm_union set_limit
  syn keyword sqlFunction contained show_limit show_trgm similarity
  syn keyword sqlFunction contained similarity_dist similarity_op strict_word_similarity
  syn keyword sqlFunction contained strict_word_similarity_commutator_op
  syn keyword sqlFunction contained strict_word_similarity_dist_commutator_op
  syn keyword sqlFunction contained strict_word_similarity_dist_op strict_word_similarity_op word_similarity
  syn keyword sqlFunction contained word_similarity_commutator_op
  syn keyword sqlFunction contained word_similarity_dist_commutator_op word_similarity_dist_op
  syn keyword sqlFunction contained word_similarity_op
  syn keyword sqlType contained gtrgm
endif " pg_trgm
" Extension: dict_int (v1.0)
if index(get(g:, 'pgsql_disabled_extensions', []), 'dict_int') == -1
  syn keyword sqlFunction contained dintdict_init dintdict_lexize
endif " dict_int
" Extension: amcheck (v1.2)
if index(get(g:, 'pgsql_disabled_extensions', []), 'amcheck') == -1
  syn keyword sqlFunction contained bt_index_check bt_index_parent_check
endif " amcheck
" Extension: btree_gist (v1.5)
if index(get(g:, 'pgsql_disabled_extensions', []), 'btree_gist') == -1
  syn keyword sqlFunction contained cash_dist date_dist float4_dist
  syn keyword sqlFunction contained float8_dist gbt_bit_compress gbt_bit_consistent
  syn keyword sqlFunction contained gbt_bit_penalty gbt_bit_picksplit
  syn keyword sqlFunction contained gbt_bit_same gbt_bit_union gbt_bpchar_compress
  syn keyword sqlFunction contained gbt_bpchar_consistent gbt_bytea_compress
  syn keyword sqlFunction contained gbt_bytea_consistent gbt_bytea_penalty
  syn keyword sqlFunction contained gbt_bytea_picksplit gbt_bytea_same gbt_bytea_union
  syn keyword sqlFunction contained gbt_cash_compress gbt_cash_consistent
  syn keyword sqlFunction contained gbt_cash_distance gbt_cash_fetch gbt_cash_penalty
  syn keyword sqlFunction contained gbt_cash_picksplit gbt_cash_same gbt_cash_union
  syn keyword sqlFunction contained gbt_date_compress gbt_date_consistent
  syn keyword sqlFunction contained gbt_date_distance gbt_date_fetch gbt_date_penalty
  syn keyword sqlFunction contained gbt_date_picksplit gbt_date_same
  syn keyword sqlFunction contained gbt_date_union gbt_decompress gbt_enum_compress
  syn keyword sqlFunction contained gbt_enum_consistent gbt_enum_fetch gbt_enum_penalty
  syn keyword sqlFunction contained gbt_enum_picksplit gbt_enum_same
  syn keyword sqlFunction contained gbt_enum_union gbt_float4_compress
  syn keyword sqlFunction contained gbt_float4_consistent gbt_float4_distance gbt_float4_fetch
  syn keyword sqlFunction contained gbt_float4_penalty gbt_float4_picksplit
  syn keyword sqlFunction contained gbt_float4_same gbt_float4_union gbt_float8_compress
  syn keyword sqlFunction contained gbt_float8_consistent gbt_float8_distance
  syn keyword sqlFunction contained gbt_float8_fetch gbt_float8_penalty
  syn keyword sqlFunction contained gbt_float8_picksplit gbt_float8_same gbt_float8_union
  syn keyword sqlFunction contained gbt_inet_compress gbt_inet_consistent
  syn keyword sqlFunction contained gbt_inet_penalty gbt_inet_picksplit gbt_inet_same
  syn keyword sqlFunction contained gbt_inet_union gbt_int2_compress
  syn keyword sqlFunction contained gbt_int2_consistent gbt_int2_distance gbt_int2_fetch
  syn keyword sqlFunction contained gbt_int2_penalty gbt_int2_picksplit gbt_int2_same
  syn keyword sqlFunction contained gbt_int2_union gbt_int4_compress
  syn keyword sqlFunction contained gbt_int4_consistent gbt_int4_distance gbt_int4_fetch
  syn keyword sqlFunction contained gbt_int4_penalty gbt_int4_picksplit
  syn keyword sqlFunction contained gbt_int4_same gbt_int4_union gbt_int8_compress
  syn keyword sqlFunction contained gbt_int8_consistent gbt_int8_distance
  syn keyword sqlFunction contained gbt_int8_fetch gbt_int8_penalty gbt_int8_picksplit
  syn keyword sqlFunction contained gbt_int8_same gbt_int8_union gbt_intv_compress
  syn keyword sqlFunction contained gbt_intv_consistent gbt_intv_decompress
  syn keyword sqlFunction contained gbt_intv_distance gbt_intv_fetch
  syn keyword sqlFunction contained gbt_intv_penalty gbt_intv_picksplit gbt_intv_same
  syn keyword sqlFunction contained gbt_intv_union gbt_macad8_compress
  syn keyword sqlFunction contained gbt_macad8_consistent gbt_macad8_fetch gbt_macad8_penalty
  syn keyword sqlFunction contained gbt_macad8_picksplit gbt_macad8_same
  syn keyword sqlFunction contained gbt_macad8_union gbt_macad_compress gbt_macad_consistent
  syn keyword sqlFunction contained gbt_macad_fetch gbt_macad_penalty
  syn keyword sqlFunction contained gbt_macad_picksplit gbt_macad_same gbt_macad_union
  syn keyword sqlFunction contained gbt_numeric_compress gbt_numeric_consistent
  syn keyword sqlFunction contained gbt_numeric_penalty gbt_numeric_picksplit
  syn keyword sqlFunction contained gbt_numeric_same gbt_numeric_union gbt_oid_compress
  syn keyword sqlFunction contained gbt_oid_consistent gbt_oid_distance
  syn keyword sqlFunction contained gbt_oid_fetch gbt_oid_penalty gbt_oid_picksplit
  syn keyword sqlFunction contained gbt_oid_same gbt_oid_union gbt_text_compress
  syn keyword sqlFunction contained gbt_text_consistent gbt_text_penalty
  syn keyword sqlFunction contained gbt_text_picksplit gbt_text_same gbt_text_union
  syn keyword sqlFunction contained gbt_time_compress gbt_time_consistent
  syn keyword sqlFunction contained gbt_time_distance gbt_time_fetch gbt_time_penalty
  syn keyword sqlFunction contained gbt_time_picksplit gbt_time_same
  syn keyword sqlFunction contained gbt_time_union gbt_timetz_compress gbt_timetz_consistent
  syn keyword sqlFunction contained gbt_ts_compress gbt_ts_consistent
  syn keyword sqlFunction contained gbt_ts_distance gbt_ts_fetch gbt_ts_penalty
  syn keyword sqlFunction contained gbt_ts_picksplit gbt_ts_same gbt_ts_union
  syn keyword sqlFunction contained gbt_tstz_compress gbt_tstz_consistent
  syn keyword sqlFunction contained gbt_tstz_distance gbt_uuid_compress gbt_uuid_consistent
  syn keyword sqlFunction contained gbt_uuid_fetch gbt_uuid_penalty
  syn keyword sqlFunction contained gbt_uuid_picksplit gbt_uuid_same gbt_uuid_union
  syn keyword sqlFunction contained gbt_var_decompress gbt_var_fetch gbtreekey16_in
  syn keyword sqlFunction contained gbtreekey16_out gbtreekey32_in gbtreekey32_out
  syn keyword sqlFunction contained gbtreekey4_in gbtreekey4_out
  syn keyword sqlFunction contained gbtreekey8_in gbtreekey8_out gbtreekey_var_in
  syn keyword sqlFunction contained gbtreekey_var_out int2_dist int4_dist int8_dist
  syn keyword sqlFunction contained interval_dist oid_dist time_dist
  syn keyword sqlFunction contained ts_dist tstz_dist
  syn keyword sqlType contained gbtreekey16 gbtreekey32 gbtreekey4
  syn keyword sqlType contained gbtreekey8 gbtreekey_var
endif " btree_gist
" Extension: pageinspect (v1.8)
if index(get(g:, 'pgsql_disabled_extensions', []), 'pageinspect') == -1
  syn keyword sqlFunction contained brin_metapage_info brin_page_items
  syn keyword sqlFunction contained brin_page_type brin_revmap_data bt_metap
  syn keyword sqlFunction contained bt_page_items bt_page_stats fsm_page_contents
  syn keyword sqlFunction contained get_raw_page gin_leafpage_items
  syn keyword sqlFunction contained gin_metapage_info gin_page_opaque_info hash_bitmap_info
  syn keyword sqlFunction contained hash_metapage_info hash_page_items
  syn keyword sqlFunction contained hash_page_stats hash_page_type heap_page_item_attrs
  syn keyword sqlFunction contained heap_page_items heap_tuple_infomask_flags
  syn keyword sqlFunction contained page_checksum page_header tuple_data_split
endif " pageinspect
" Extension: pltclu (v1.0)
if index(get(g:, 'pgsql_disabled_extensions', []), 'pltclu') == -1
  syn keyword sqlFunction contained pltclu_call_handler
endif " pltclu
" Extension: hstore_plperl (v1.0)
if index(get(g:, 'pgsql_disabled_extensions', []), 'hstore_plperl') == -1
  syn keyword sqlFunction contained hstore_to_plperl plperl_to_hstore
endif " hstore_plperl
" Extension: moddatetime (v1.0)
if index(get(g:, 'pgsql_disabled_extensions', []), 'moddatetime') == -1
  syn keyword sqlFunction contained moddatetime
endif " moddatetime
" Extension: fuzzystrmatch (v1.1)
if index(get(g:, 'pgsql_disabled_extensions', []), 'fuzzystrmatch') == -1
  syn keyword sqlFunction contained difference dmetaphone dmetaphone_alt
  syn keyword sqlFunction contained levenshtein levenshtein_less_equal
  syn keyword sqlFunction contained metaphone soundex text_soundex
endif " fuzzystrmatch
" Extension: pgrouting (v3.1.3)
if index(get(g:, 'pgsql_disabled_extensions', []), 'pgrouting') == -1
  syn keyword sqlFunction contained pgr_alphashape pgr_analyzegraph
  syn keyword sqlFunction contained pgr_analyzeoneway pgr_articulationpoints pgr_astar
  syn keyword sqlFunction contained pgr_astarcost pgr_astarcostmatrix
  syn keyword sqlFunction contained pgr_bdastar pgr_bdastarcost pgr_bdastarcostmatrix
  syn keyword sqlFunction contained pgr_bddijkstra pgr_bddijkstracost
  syn keyword sqlFunction contained pgr_bddijkstracostmatrix pgr_bellmanford
  syn keyword sqlFunction contained pgr_biconnectedcomponents pgr_binarybreadthfirstsearch
  syn keyword sqlFunction contained pgr_boykovkolmogorov pgr_breadthfirstsearch pgr_bridges
  syn keyword sqlFunction contained pgr_chinesepostman pgr_chinesepostmancost
  syn keyword sqlFunction contained pgr_connectedcomponents pgr_contraction
  syn keyword sqlFunction contained pgr_createtopology pgr_createverticestable
  syn keyword sqlFunction contained pgr_dagshortestpath pgr_dijkstra pgr_dijkstracost
  syn keyword sqlFunction contained pgr_dijkstracostmatrix pgr_dijkstravia
  syn keyword sqlFunction contained pgr_drivingdistance pgr_edgedisjointpaths pgr_edmondskarp
  syn keyword sqlFunction contained pgr_edwardmoore pgr_extractvertices
  syn keyword sqlFunction contained pgr_floydwarshall pgr_full_version pgr_johnson
  syn keyword sqlFunction contained pgr_kruskal pgr_kruskalbfs pgr_kruskaldd
  syn keyword sqlFunction contained pgr_kruskaldfs pgr_ksp pgr_linegraph
  syn keyword sqlFunction contained pgr_linegraphfull pgr_maxcardinalitymatch
  syn keyword sqlFunction contained pgr_maxflow pgr_maxflowmincost pgr_maxflowmincost_cost
  syn keyword sqlFunction contained pgr_nodenetwork pgr_pickdeliver
  syn keyword sqlFunction contained pgr_pickdelivereuclidean pgr_prim pgr_primbfs
  syn keyword sqlFunction contained pgr_primdd pgr_primdfs pgr_pushrelabel
  syn keyword sqlFunction contained pgr_stoerwagner pgr_strongcomponents
  syn keyword sqlFunction contained pgr_topologicalsort pgr_transitiveclosure pgr_trsp
  syn keyword sqlFunction contained pgr_trspviaedges pgr_trspviavertices pgr_tsp
  syn keyword sqlFunction contained pgr_tspeuclidean pgr_turnrestrictedpath
  syn keyword sqlFunction contained pgr_version pgr_vrponedepot pgr_withpoints
  syn keyword sqlFunction contained pgr_withpointscost pgr_withpointscostmatrix
  syn keyword sqlFunction contained pgr_withpointsdd pgr_withpointsksp
endif " pgrouting
" Extension: pgcrypto (v1.3)
if index(get(g:, 'pgsql_disabled_extensions', []), 'pgcrypto') == -1
  syn keyword sqlFunction contained armor crypt dearmor decrypt
  syn keyword sqlFunction contained decrypt_iv digest encrypt encrypt_iv
  syn keyword sqlFunction contained gen_random_bytes gen_random_uuid gen_salt
  syn keyword sqlFunction contained hmac pgp_armor_headers pgp_key_id
  syn keyword sqlFunction contained pgp_pub_decrypt pgp_pub_decrypt_bytea
  syn keyword sqlFunction contained pgp_pub_encrypt pgp_pub_encrypt_bytea pgp_sym_decrypt
  syn keyword sqlFunction contained pgp_sym_decrypt_bytea pgp_sym_encrypt
  syn keyword sqlFunction contained pgp_sym_encrypt_bytea
endif " pgcrypto
" Extension: postgis_sfcgal (v3.1.1)
if index(get(g:, 'pgsql_disabled_extensions', []), 'postgis_sfcgal') == -1
  syn keyword sqlFunction contained postgis_sfcgal_noop
  syn keyword sqlFunction contained postgis_sfcgal_scripts_installed postgis_sfcgal_version st_3darea
  syn keyword sqlFunction contained st_3ddifference st_3dintersection st_3dunion
  syn keyword sqlFunction contained st_approximatemedialaxis
  syn keyword sqlFunction contained st_constraineddelaunaytriangles st_extrude st_forcelhr
  syn keyword sqlFunction contained st_isplanar st_issolid st_makesolid st_minkowskisum
  syn keyword sqlFunction contained st_orientation st_straightskeleton
  syn keyword sqlFunction contained st_tesselate st_volume
endif " postgis_sfcgal
" Extension: jsonb_plperlu (v1.0)
if index(get(g:, 'pgsql_disabled_extensions', []), 'jsonb_plperlu') == -1
  syn keyword sqlFunction contained jsonb_to_plperlu plperlu_to_jsonb
endif " jsonb_plperlu
" Extension: plperl (v1.0)
if index(get(g:, 'pgsql_disabled_extensions', []), 'plperl') == -1
  syn keyword sqlFunction contained plperl_call_handler plperl_inline_handler plperl_validator
endif " plperl
" Extension: tablefunc (v1.0)
if index(get(g:, 'pgsql_disabled_extensions', []), 'tablefunc') == -1
  syn keyword sqlFunction contained connectby crosstab crosstab2
  syn keyword sqlFunction contained crosstab3 crosstab4 normal_rand
  syn keyword sqlType contained tablefunc_crosstab_2 tablefunc_crosstab_3
  syn keyword sqlType contained tablefunc_crosstab_4
endif " tablefunc
" Extension: postgres_fdw (v1.0)
if index(get(g:, 'pgsql_disabled_extensions', []), 'postgres_fdw') == -1
  syn keyword sqlFunction contained postgres_fdw_handler postgres_fdw_validator
endif " postgres_fdw
" Extension: bloom (v1.0)
if index(get(g:, 'pgsql_disabled_extensions', []), 'bloom') == -1
  syn keyword sqlFunction contained blhandler
endif " bloom
" Extension: pltcl (v1.0)
if index(get(g:, 'pgsql_disabled_extensions', []), 'pltcl') == -1
  syn keyword sqlFunction contained pltcl_call_handler
endif " pltcl
" Extension: citext (v1.6)
if index(get(g:, 'pgsql_disabled_extensions', []), 'citext') == -1
  syn keyword sqlFunction contained citext citext_cmp citext_eq
  syn keyword sqlFunction contained citext_ge citext_gt citext_hash
  syn keyword sqlFunction contained citext_hash_extended citext_larger citext_le citext_lt
  syn keyword sqlFunction contained citext_ne citext_pattern_cmp
  syn keyword sqlFunction contained citext_pattern_ge citext_pattern_gt citext_pattern_le
  syn keyword sqlFunction contained citext_pattern_lt citext_smaller citextin
  syn keyword sqlFunction contained citextout citextrecv citextsend max
  syn keyword sqlFunction contained min regexp_match regexp_matches
  syn keyword sqlFunction contained regexp_replace regexp_split_to_array
  syn keyword sqlFunction contained regexp_split_to_table replace split_part strpos
  syn keyword sqlFunction contained texticlike texticnlike texticregexeq
  syn keyword sqlFunction contained texticregexne translate
  syn keyword sqlType contained citext
endif " citext
" Extension: bool_plperl (v1.0)
if index(get(g:, 'pgsql_disabled_extensions', []), 'bool_plperl') == -1
  syn keyword sqlFunction contained bool_to_plperl plperl_to_bool
endif " bool_plperl
" Extension: plpgsql (v1.0)
if index(get(g:, 'pgsql_disabled_extensions', []), 'plpgsql') == -1
  syn keyword sqlFunction contained plpgsql_call_handler plpgsql_inline_handler
  syn keyword sqlFunction contained plpgsql_validator
endif " plpgsql
" Extension: plpythonu
if index(get(g:, 'pgsql_disabled_extensions', []), 'plpythonu') == -1
  syn keyword sqlFunction contained plpython_call_handler plpython_inline_handler
  syn keyword sqlFunction contained plpython_validator
endif " plpythonu
" Extension: plpython2u
if index(get(g:, 'pgsql_disabled_extensions', []), 'plpython2u') == -1
  syn keyword sqlFunction contained plpython2_call_handler plpython2_inline_handler
  syn keyword sqlFunction contained plpython2_validator
endif " plpython2u
" Extension: plpython3u
if index(get(g:, 'pgsql_disabled_extensions', []), 'plpython3u') == -1
  syn keyword sqlFunction contained plpython3_call_handler plpython3_inline_handler
  syn keyword sqlFunction contained plpython3_validator
endif " plpython3u
" Extension: hstore_plpythonu
if index(get(g:, 'pgsql_disabled_extensions', []), 'hstore_plpythonu') == -1
  syn keyword sqlFunction contained hstore_to_plpython plpython_to_hstore
endif " hstore_plpythonu
" Extension: hstore_plpython2u
if index(get(g:, 'pgsql_disabled_extensions', []), 'hstore_plpython2u') == -1
  syn keyword sqlFunction contained hstore_to_plpython2 plpython2_to_hstore
endif " hstore_plpython2u
" Extension: hstore_plpython3u
if index(get(g:, 'pgsql_disabled_extensions', []), 'hstore_plpython3u') == -1
  syn keyword sqlFunction contained hstore_to_plpython3 plpython3_to_hstore
endif " hstore_plpython3u
" Extension: jsonb_plpython3u
if index(get(g:, 'pgsql_disabled_extensions', []), 'jsonb_plpython3u') == -1
  syn keyword sqlFunction contained jsonb_to_plpython3 plpython3_to_jsonb
endif " jsonb_plpython3u
" Extension: ltree_plpythonu
if index(get(g:, 'pgsql_disabled_extensions', []), 'ltree_plpythonu') == -1
  syn keyword sqlFunction contained ltree_to_plpython
endif " ltree_plpythonu
" Extension: ltree_plpython2u
if index(get(g:, 'pgsql_disabled_extensions', []), 'ltree_plpython2u') == -1
  syn keyword sqlFunction contained ltree_to_plpython2
endif " ltree_plpython2u
" Extension: ltree_plpython3u
if index(get(g:, 'pgsql_disabled_extensions', []), 'ltree_plpython3u') == -1
  syn keyword sqlFunction contained ltree_to_plpython3
endif " ltree_plpython3u
" Extension: pldbgapi
if index(get(g:, 'pgsql_disabled_extensions', []), 'pldbgapi') == -1
  syn keyword sqlFunction contained pldbg_abort_target pldbg_attach_to_port pldbg_continue
  syn keyword sqlFunction contained pldbg_create_listener pldbg_deposit_value pldbg_drop_breakpoint
  syn keyword sqlFunction contained pldbg_get_breakpoints pldbg_get_proxy_info pldbg_get_source
  syn keyword sqlFunction contained pldbg_get_stack pldbg_get_target_info pldbg_get_variables
  syn keyword sqlFunction contained pldbg_oid_debug pldbg_select_frame pldbg_set_breakpoint
  syn keyword sqlFunction contained pldbg_set_global_breakpoint pldbg_step_into pldbg_step_over
  syn keyword sqlFunction contained pldbg_wait_for_breakpoint pldbg_wait_for_target plpgsql_oid_debug
  syn keyword sqlType contained breakpoint frame proxyinfo targetinfo var
endif " pldbgapi
" Extension: chkpass
if index(get(g:, 'pgsql_disabled_extensions', []), 'chkpass') == -1
  syn keyword sqlFunction contained chkpass_in chkpass_out eq ne raw
endif " chkpass
" Catalog tables
syn keyword sqlCatalog contained administrable_role_authorizations applicable_roles
syn keyword sqlCatalog contained attributes character_sets check_constraint_routine_usage
syn keyword sqlCatalog contained check_constraints collation_character_set_applicability collations
syn keyword sqlCatalog contained column_column_usage column_domain_usage column_options
syn keyword sqlCatalog contained column_privileges column_udt_usage columns constraint_column_usage
syn keyword sqlCatalog contained constraint_table_usage data_type_privileges domain_constraints
syn keyword sqlCatalog contained domain_udt_usage domains element_types enabled_roles
syn keyword sqlCatalog contained foreign_data_wrapper_options foreign_data_wrappers foreign_server_options
syn keyword sqlCatalog contained foreign_servers foreign_table_options foreign_tables
syn keyword sqlCatalog contained information_schema_catalog_name key_column_usage parameters pg_aggregate pg_am
syn keyword sqlCatalog contained pg_amop pg_amproc pg_attrdef pg_attribute pg_auth_members pg_authid
syn keyword sqlCatalog contained pg_available_extension_versions pg_available_extensions
syn keyword sqlCatalog contained pg_cast pg_class pg_collation pg_config pg_constraint pg_conversion
syn keyword sqlCatalog contained pg_cursors pg_database pg_db_role_setting pg_default_acl
syn keyword sqlCatalog contained pg_depend pg_description pg_enum pg_event_trigger pg_extension
syn keyword sqlCatalog contained pg_file_settings pg_foreign_data_wrapper pg_foreign_server
syn keyword sqlCatalog contained pg_foreign_table pg_group pg_hba_file_rules pg_index pg_indexes pg_inherits
syn keyword sqlCatalog contained pg_init_privs pg_language pg_largeobject
syn keyword sqlCatalog contained pg_largeobject_metadata pg_locks pg_matviews pg_namespace pg_opclass pg_operator
syn keyword sqlCatalog contained pg_opfamily pg_partitioned_table pg_policies pg_policy
syn keyword sqlCatalog contained pg_prepared_statements pg_prepared_xacts pg_proc pg_publication
syn keyword sqlCatalog contained pg_publication_rel pg_publication_tables pg_range pg_replication_origin
syn keyword sqlCatalog contained pg_replication_origin_status pg_replication_slots pg_rewrite
syn keyword sqlCatalog contained pg_roles pg_rules pg_seclabel pg_seclabels pg_sequence pg_sequences
syn keyword sqlCatalog contained pg_settings pg_shadow pg_shdepend pg_shdescription
syn keyword sqlCatalog contained pg_shmem_allocations pg_shseclabel pg_stat_activity pg_stat_all_indexes
syn keyword sqlCatalog contained pg_stat_all_tables pg_stat_archiver pg_stat_bgwriter
syn keyword sqlCatalog contained pg_stat_database pg_stat_database_conflicts pg_stat_gssapi
syn keyword sqlCatalog contained pg_stat_progress_analyze pg_stat_progress_basebackup pg_stat_progress_cluster
syn keyword sqlCatalog contained pg_stat_progress_create_index pg_stat_progress_vacuum
syn keyword sqlCatalog contained pg_stat_replication pg_stat_slru pg_stat_ssl pg_stat_subscription
syn keyword sqlCatalog contained pg_stat_sys_indexes pg_stat_sys_tables pg_stat_user_functions
syn keyword sqlCatalog contained pg_stat_user_indexes pg_stat_user_tables pg_stat_wal_receiver
syn keyword sqlCatalog contained pg_stat_xact_all_tables pg_stat_xact_sys_tables
syn keyword sqlCatalog contained pg_stat_xact_user_functions pg_stat_xact_user_tables pg_statio_all_indexes
syn keyword sqlCatalog contained pg_statio_all_sequences pg_statio_all_tables pg_statio_sys_indexes
syn keyword sqlCatalog contained pg_statio_sys_sequences pg_statio_sys_tables
syn keyword sqlCatalog contained pg_statio_user_indexes pg_statio_user_sequences pg_statio_user_tables
syn keyword sqlCatalog contained pg_statistic pg_statistic_ext pg_statistic_ext_data pg_stats
syn keyword sqlCatalog contained pg_stats_ext pg_subscription pg_subscription_rel pg_tables pg_tablespace
syn keyword sqlCatalog contained pg_timezone_abbrevs pg_timezone_names pg_transform pg_trigger
syn keyword sqlCatalog contained pg_ts_config pg_ts_config_map pg_ts_dict pg_ts_parser
syn keyword sqlCatalog contained pg_ts_template pg_type pg_user pg_user_mapping pg_user_mappings pg_views
syn keyword sqlCatalog contained referential_constraints role_column_grants role_routine_grants
syn keyword sqlCatalog contained role_table_grants role_udt_grants role_usage_grants
syn keyword sqlCatalog contained routine_privileges routines schemata sequences sql_features
syn keyword sqlCatalog contained sql_implementation_info sql_parts sql_sizing table_constraints table_privileges
syn keyword sqlCatalog contained tables transforms triggered_update_columns triggers
syn keyword sqlCatalog contained udt_privileges usage_privileges user_defined_types user_mapping_options
syn keyword sqlCatalog contained user_mappings view_column_usage view_routine_usage
syn keyword sqlCatalog contained view_table_usage views
" Error codes (Appendix A, Table A-1)
syn keyword sqlErrorCode contained active_sql_transaction admin_shutdown ambiguous_alias
syn keyword sqlErrorCode contained ambiguous_column ambiguous_function ambiguous_parameter
syn keyword sqlErrorCode contained array_subscript_error assert_failure bad_copy_file_format
syn keyword sqlErrorCode contained branch_transaction_already_active cannot_coerce cannot_connect_now
syn keyword sqlErrorCode contained cant_change_runtime_param cardinality_violation case_not_found
syn keyword sqlErrorCode contained character_not_in_repertoire check_violation collation_mismatch
syn keyword sqlErrorCode contained config_file_error configuration_limit_exceeded
syn keyword sqlErrorCode contained connection_does_not_exist connection_exception connection_failure
syn keyword sqlErrorCode contained containing_sql_not_permitted crash_shutdown data_corrupted data_exception
syn keyword sqlErrorCode contained database_dropped datatype_mismatch datetime_field_overflow
syn keyword sqlErrorCode contained deadlock_detected dependent_objects_still_exist
syn keyword sqlErrorCode contained dependent_privilege_descriptors_still_exist deprecated_feature diagnostics_exception
syn keyword sqlErrorCode contained disk_full division_by_zero duplicate_alias duplicate_column
syn keyword sqlErrorCode contained duplicate_cursor duplicate_database duplicate_file
syn keyword sqlErrorCode contained duplicate_function duplicate_json_object_key_value duplicate_object
syn keyword sqlErrorCode contained duplicate_prepared_statement duplicate_schema duplicate_table
syn keyword sqlErrorCode contained dynamic_result_sets_returned error_in_assignment
syn keyword sqlErrorCode contained escape_character_conflict event_trigger_protocol_violated exclusion_violation
syn keyword sqlErrorCode contained external_routine_exception external_routine_invocation_exception
syn keyword sqlErrorCode contained fdw_column_name_not_found fdw_dynamic_parameter_value_needed
syn keyword sqlErrorCode contained fdw_error fdw_function_sequence_error
syn keyword sqlErrorCode contained fdw_inconsistent_descriptor_information fdw_invalid_attribute_value
syn keyword sqlErrorCode contained fdw_invalid_column_name fdw_invalid_column_number fdw_invalid_data_type
syn keyword sqlErrorCode contained fdw_invalid_data_type_descriptors
syn keyword sqlErrorCode contained fdw_invalid_descriptor_field_identifier fdw_invalid_handle fdw_invalid_option_index
syn keyword sqlErrorCode contained fdw_invalid_option_name fdw_invalid_string_format
syn keyword sqlErrorCode contained fdw_invalid_string_length_or_buffer_length fdw_invalid_use_of_null_pointer
syn keyword sqlErrorCode contained fdw_no_schemas fdw_option_name_not_found fdw_out_of_memory
syn keyword sqlErrorCode contained fdw_reply_handle fdw_schema_not_found fdw_table_not_found
syn keyword sqlErrorCode contained fdw_too_many_handles fdw_unable_to_create_execution
syn keyword sqlErrorCode contained fdw_unable_to_create_reply fdw_unable_to_establish_connection feature_not_supported
syn keyword sqlErrorCode contained floating_point_exception foreign_key_violation
syn keyword sqlErrorCode contained function_executed_no_return_statement generated_always grouping_error
syn keyword sqlErrorCode contained held_cursor_requires_same_isolation_level
syn keyword sqlErrorCode contained idle_in_transaction_session_timeout implicit_zero_bit_padding in_failed_sql_transaction
syn keyword sqlErrorCode contained inappropriate_access_mode_for_branch_transaction
syn keyword sqlErrorCode contained inappropriate_isolation_level_for_branch_transaction
syn keyword sqlErrorCode contained indeterminate_collation indeterminate_datatype index_corrupted indicator_overflow
syn keyword sqlErrorCode contained insufficient_privilege insufficient_resources
syn keyword sqlErrorCode contained integrity_constraint_violation internal_error interval_field_overflow
syn keyword sqlErrorCode contained invalid_argument_for_logarithm
syn keyword sqlErrorCode contained invalid_argument_for_nth_value_function invalid_argument_for_ntile_function
syn keyword sqlErrorCode contained invalid_argument_for_power_function
syn keyword sqlErrorCode contained invalid_argument_for_sql_json_datetime_function invalid_argument_for_width_bucket_function
syn keyword sqlErrorCode contained invalid_authorization_specification invalid_binary_representation
syn keyword sqlErrorCode contained invalid_catalog_name invalid_character_value_for_cast
syn keyword sqlErrorCode contained invalid_column_definition invalid_column_reference invalid_cursor_definition
syn keyword sqlErrorCode contained invalid_cursor_name invalid_cursor_state
syn keyword sqlErrorCode contained invalid_database_definition invalid_datetime_format invalid_escape_character
syn keyword sqlErrorCode contained invalid_escape_octet invalid_escape_sequence invalid_foreign_key
syn keyword sqlErrorCode contained invalid_function_definition invalid_grant_operation
syn keyword sqlErrorCode contained invalid_grantor invalid_indicator_parameter_value invalid_json_text
syn keyword sqlErrorCode contained invalid_locator_specification invalid_name invalid_object_definition
syn keyword sqlErrorCode contained invalid_parameter_value invalid_password
syn keyword sqlErrorCode contained invalid_preceding_or_following_size invalid_prepared_statement_definition
syn keyword sqlErrorCode contained invalid_recursion invalid_regular_expression
syn keyword sqlErrorCode contained invalid_role_specification invalid_row_count_in_limit_clause
syn keyword sqlErrorCode contained invalid_row_count_in_result_offset_clause invalid_savepoint_specification
syn keyword sqlErrorCode contained invalid_schema_definition invalid_schema_name
syn keyword sqlErrorCode contained invalid_sql_json_subscript invalid_sql_statement_name invalid_sqlstate_returned
syn keyword sqlErrorCode contained invalid_table_definition invalid_tablesample_argument
syn keyword sqlErrorCode contained invalid_tablesample_repeat invalid_text_representation
syn keyword sqlErrorCode contained invalid_time_zone_displacement_value invalid_transaction_initiation
syn keyword sqlErrorCode contained invalid_transaction_state invalid_transaction_termination
syn keyword sqlErrorCode contained invalid_use_of_escape_character invalid_xml_comment invalid_xml_content
syn keyword sqlErrorCode contained invalid_xml_document invalid_xml_processing_instruction io_error
syn keyword sqlErrorCode contained locator_exception lock_file_exists lock_not_available
syn keyword sqlErrorCode contained modifying_sql_data_not_permitted more_than_one_sql_json_item
syn keyword sqlErrorCode contained most_specific_type_mismatch name_too_long no_active_sql_transaction
syn keyword sqlErrorCode contained no_active_sql_transaction_for_branch_transaction
syn keyword sqlErrorCode contained no_additional_dynamic_result_sets_returned no_data no_data_found
syn keyword sqlErrorCode contained no_sql_json_item non_numeric_sql_json_item
syn keyword sqlErrorCode contained non_unique_keys_in_a_json_object nonstandard_use_of_escape_character not_an_xml_document
syn keyword sqlErrorCode contained not_null_violation null_value_eliminated_in_set_function
syn keyword sqlErrorCode contained null_value_no_indicator_parameter null_value_not_allowed
syn keyword sqlErrorCode contained numeric_value_out_of_range object_in_use object_not_in_prerequisite_state
syn keyword sqlErrorCode contained operator_intervention out_of_memory plpgsql_error
syn keyword sqlErrorCode contained privilege_not_granted privilege_not_revoked program_limit_exceeded
syn keyword sqlErrorCode contained prohibited_sql_statement_attempted protocol_violation query_canceled
syn keyword sqlErrorCode contained raise_exception read_only_sql_transaction
syn keyword sqlErrorCode contained reading_sql_data_not_permitted reserved_name restrict_violation
syn keyword sqlErrorCode contained savepoint_exception schema_and_data_statement_mixing_not_supported
syn keyword sqlErrorCode contained sequence_generator_limit_exceeded serialization_failure
syn keyword sqlErrorCode contained singleton_sql_json_item_required snapshot_too_old sql_json_array_not_found
syn keyword sqlErrorCode contained sql_json_member_not_found sql_json_number_not_found
syn keyword sqlErrorCode contained sql_json_object_not_found sql_json_scalar_required sql_routine_exception
syn keyword sqlErrorCode contained sql_statement_not_yet_complete
syn keyword sqlErrorCode contained sqlclient_unable_to_establish_sqlconnection
syn keyword sqlErrorCode contained sqlserver_rejected_establishment_of_sqlconnection srf_protocol_violated
syn keyword sqlErrorCode contained stacked_diagnostics_accessed_without_active_handler statement_completion_unknown
syn keyword sqlErrorCode contained statement_too_complex string_data_length_mismatch
syn keyword sqlErrorCode contained string_data_right_truncation substring_error successful_completion syntax_error
syn keyword sqlErrorCode contained syntax_error_or_access_rule_violation system_error too_many_arguments
syn keyword sqlErrorCode contained too_many_columns too_many_connections
syn keyword sqlErrorCode contained too_many_json_array_elements too_many_json_object_members too_many_rows
syn keyword sqlErrorCode contained transaction_integrity_constraint_violation transaction_resolution_unknown
syn keyword sqlErrorCode contained transaction_rollback trigger_protocol_violated
syn keyword sqlErrorCode contained triggered_action_exception triggered_data_change_violation trim_error
syn keyword sqlErrorCode contained undefined_column undefined_file undefined_function undefined_object
syn keyword sqlErrorCode contained undefined_parameter undefined_table unique_violation
syn keyword sqlErrorCode contained unsafe_new_enum_value_usage unterminated_c_string
syn keyword sqlErrorCode contained untranslatable_character warning windowing_error with_check_option_violation
syn keyword sqlErrorCode contained wrong_object_type zero_length_character_string

" Legacy keywords
syn keyword sqlFunction contained gist_box_compress gist_box_decompress gist_box_fetch
syn keyword sqlFunction contained gtsquery_decompress inet_gist_decompress
syn keyword sqlFunction contained pg_file_length pg_file_read pg_logfile_rotate
syn keyword sqlFunction contained range_gist_compress range_gist_decompress range_gist_fetch

" Legacy error codes
syn keyword sqlErrorCode contained invalid_preceding_following_size

" Numbers
syn match sqlNumber "\<\d*\.\=[0-9_]\>"

" Strings
if get(g:, 'pgsql_backslash_quote', 0)
  syn region sqlString start=+E\?'+ skip=+\\\\\|\\'\|''+ end=+'+ contains=@Spell
else
  syn region sqlString start=+E'+ skip=+\\\\\|\\'\|''+ end=+'+ contains=@Spell
  syn region sqlString start=+'+ skip=+''+ end=+'+ contains=@Spell
endif
" Multi-line strings ("here" documents)
syn region sqlString start='\$\z(\w\+\)\$' end='\$\z1\$' contains=@Spell

" Escape String Constants
" Identifiers
syn region sqlIdentifier start=+\%(U&\)\?"+ end=+"+
syn keyword sqlConstant UESCAPE

" Operators
syn match sqlIsOperator "\%(^\|[^!?~#^@<=>%&|*/+-]\)\zs[!?~#^@<=>%&|*/+-]\+" contains=sqlOperator

syn match sqlOperator contained "\%(<->>>\|<<->>\|<<<->\|!\~\~\*\|\#<=\#\|\#>=\#\|<->>\|<<->\|\~<=\~\|\~>=\~\|!\~\*\)\ze\%([^!?~#^@<=>%&|*/+-]\|$\)"
syn match sqlOperator contained "\%(!\~\~\|\#<\#\|\#>\#\|\#>>\|%>>\|&&&\|&/&\|&<|\|\*<=\|\*<>\|\*>=\|->>\|-|-\|<\#>\|<->\|<<%\|<<=\)\ze\%([^!?~#^@<=>%&|*/+-]\|$\)"
syn match sqlOperator contained "\%(<<@\|<<|\|<=>\|<@>\|>>=\|?-|\|?<@\|?@>\|?||\|@-@\|@>>\|@@@\|\^<@\|\^@>\||&>\||=|\)\ze\%([^!?~#^@<=>%&|*/+-]\|$\)"
syn match sqlOperator contained "\%(|>>\|||/\|\~<\~\|\~==\|\~>\~\|\~\~\*\|\~\~=\|!!\|!\~\|\#\#\|\#-\|\#=\|\#>\|%\#\|%%\|%>\|&&\|&<\|&>\|\*<\|\*=\)\ze\%([^!?~#^@<=>%&|*/+-]\|$\)"
syn match sqlOperator contained "\%(\*>\|->\|<%\|<<\|<=\|<>\|<@\|<\^\|=>\|>=\|>>\|>\^\|?\#\|?&\|?-\|?@\|?|\|?\~\|@>\|@?\|@@\|\^?\|\^@\|\^\~\||/\)\ze\%([^!?~#^@<=>%&|*/+-]\|$\)"
syn match sqlOperator contained "\%(||\|\~\*\|\~=\|\~>\|\~\~\|!\|\#\|%\|&\|\*\|+\|-\|/\|<\|=\|>\|?\|@\|\^\||\|\~\)\ze\%([^!?~#^@<=>%&|*/+-]\|$\)"

" Comments
syn region sqlComment    start="/\*" end="\*/" contains=sqlTodo,@Spell
syn match  sqlComment    "#\s.*$"              contains=sqlTodo,@Spell
syn match  sqlComment    "--.*$"               contains=sqlTodo,@Spell

" CREATE TYPE statement
syn region sqlCreateType start=+create\s\+type.*(+ end=+)+
      \ contains=sqlIsKeyword,sqlCreateTypeKeyword,sqlIsOperator,sqlString,sqlComment,sqlNumber,sqlTodo
syn keyword sqlCreateTypeKeyword contained input output receive send typmod_in typmod_out analyze internallength passedbyvalue
syn keyword sqlCreateTypeKeyword contained alignment storage like category preferred default element delimiter collatable
syn keyword sqlCreateTypeKeyword contained collate subtype subtype_opclass canonical subtype_diff

" CREATE OPERATOR [CLASS] statements
syn region sqlCreateOperator start=+create\s\+operator.*(+ end=+)+
      \ contains=sqlIsKeyword,sqlCreateOperatorKeyword,sqlIsOperator,sqlString,sqlComment,sqlNumber,sqlTodo
syn keyword sqlCreateOperatorKeyword contained function procedure leftarg rightarg commutator negator restrict join hashes merges

" CREATE TEXT SEARCH statements
syn region sqlCreateTextSearch start=+create\s\+text\s\+search.*(+ end=+)+
      \ contains=sqlIsKeyword,sqlCreateTextSearchKeyword,sqlIsOperator,sqlString,sqlComment,sqlNumber,sqlTodo
syn keyword sqlCreateTextSearchKeyword contained text parser copy template start gettoken end lextypes headline init lexize

" Options
syn keyword sqlOption contained client_min_messages search_path

syntax case match

" Psql Keywords
syn match sqlPsqlCommand contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\[aCfHhortTxz]\>\|\\[?!]/
syn match sqlPsqlCommand contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\c\%(\%(d\|onnect\|onninfo\|opy\%(right\)\?\|rosstabview\)\?\)\>/
syn match sqlPsqlCommand contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\d\>\|\\dS\>+\?\|\\d[ao]S\?\>\|\\d[cDgiLmnOstTuvE]\%(\>\|S\>+\?\)/
syn match sqlPsqlCommand contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\d[AbClx]\>+\?\|\\d[py]\>\|\\dd[pS]\>\?\|\\de[tsuw]\>+\?\|\\df[antw]\?S\?\>+\?\|\\dF[dpt]\?\>+\?\|\\drds\>/
syn match sqlPsqlCommand contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\e\%(cho\|[fv]\|ncoding\|rrverbose\)\?\>/
syn match sqlPsqlCommand contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\g\%(exec\|set\)\?\>/
syn match sqlPsqlCommand contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\ir\?\>/
syn match sqlPsqlCommand contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\l\>+\?\|\\lo_\%(export\|import\|list\|unlink\)\>/
syn match sqlPsqlCommand contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\p\%(assword\|rompt\|set\)\?\>/
syn match sqlPsqlCommand contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\q\%(echo\)\?\>/
syn match sqlPsqlCommand contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\s\>\|\\s[fv]\>+\?\|\\set\%(env\)\?\>/
syn match sqlPsqlCommand contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\t\%(iming\)\?\>/
syn match sqlPsqlCommand contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\unset\>/
syn match sqlPsqlCommand contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\w\%(atch\)\?\>/
syn keyword sqlPsqlKeyword contained format border columns expanded fieldsep fieldsep_zero footer null
syn keyword sqlPsqlKeyword contained numericlocale recordsep recordsep_zero tuples_only title tableattr pages
syn keyword sqlPsqlKeyword contained unicode_border_linestyle unicode_column_linestyle unicode_header_linestyle
syn keyword sqlPsqlKeyword contained on off auto unaligned pager
syn keyword sqlPsqlKeyword contained AUTOCOMMIT HISTCONTROL PROMPT VERBOSITY SHOW_CONTEXT VERSION
syn keyword sqlPsqlKeyword contained DBNAME USER HOST PORT ENCODING HISTSIZE QUIET
syn keyword sqlPsqlKeyword contained from program pstdin pstdout stdin stdout to where with

" Todo
syn keyword sqlTodo contained TODO FIXME XXX DEBUG NOTE

syntax case ignore

" PL/pgSQL
syn keyword sqlPlpgsqlKeyword contained alias all array as begin by case close collate column constant
syn keyword sqlPlpgsqlKeyword contained constraint continue current current cursor datatype declare
syn keyword sqlPlpgsqlKeyword contained detail diagnostics else elsif end errcode exception execute
syn keyword sqlPlpgsqlKeyword contained exit fetch for foreach forward found from get hint if
syn keyword sqlPlpgsqlKeyword contained into last loop message move next no notice open perform prepare
syn keyword sqlPlpgsqlKeyword contained query raise relative return reverse rowtype schema
syn keyword sqlPlpgsqlKeyword contained scroll slice sqlstate stacked strict table tg_argv tg_event
syn keyword sqlPlpgsqlKeyword contained tg_level tg_name tg_nargs tg_op tg_relid tg_relname
syn keyword sqlPlpgsqlKeyword contained tg_table_name tg_table_schema tg_tag tg_when then type using
syn keyword sqlPlpgsqlKeyword contained while

" Variables (identifiers conventionally starting with an underscore)
syn match sqlPlpgsqlVariable "\<_[A-Za-z0-9][A-Za-z0-9_]*\>" contained
" Numbered arguments
syn match sqlPlpgsqlVariable "\$\d\+" contained
" @ arguments
syn match sqlPlpgsqlVariable ".\zs@[A-z0-9_]\+" contained
" PL/pgSQL operators
syn match sqlPlpgsqlOperator ":=" contained

syn region plpgsql matchgroup=sqlString start=+\$\z(pgsql\|body\|function\)\$+ end=+\$\z1\$+ keepend
  \ contains=sqlIsKeyword,sqlIsFunction,sqlComment,sqlPlpgsqlKeyword,sqlPlpgsqlVariable,sqlPlpgsqlOperator,sqlNumber,sqlIsOperator,sqlString,sqlTodo
if get(g:, 'pgsql_dollar_strings', 0)
  syn region sqlString start=+\$\$+ end=+\$\$+ contains=@Spell
else
  syn region plpgsql matchgroup=sqlString start=+\$\$+ end=+\$\$+ keepend
    \ contains=sqlIsKeyword,sqlIsFunction,sqlComment,sqlPlpgsqlKeyword,sqlPlpgsqlVariable,sqlPlpgsqlOperator,sqlNumber,sqlIsOperator,sqlString,sqlTodo
endif

let s:plgroups = 'plpgsql'

" PL/<any other language>
fun! s:add_syntax(s)
  execute 'syn include @PL' . a:s . ' syntax/' . a:s . '.vim'
  unlet b:current_syntax
  execute 'syn region pgsqlpl' . a:s . ' matchgroup=sqlString start=+\$' . a:s . '\$+ end=+\$' . a:s . '\$+ keepend contains=@PL' .. a:s
  let s:plgroups .= ',pgsqlpl' . a:s
endf

for pl in get(b:, 'pgsql_pl', get(g:, 'pgsql_pl', []))
  call s:add_syntax(pl)
endfor

" Folding
if get(g:, 'pgsql_fold_functions_only', 0)

    execute 'syn region sqlFold start=/^\s*\zs\c\%(create\s\+[a-z ]*\%(function\|procedure\)\|do\)\>/ end=/;$/ transparent fold '
        \ . "contains=sqlIsKeyword,sqlIsFunction,sqlComment,sqlIdentifier,sqlNumber,sqlOperator,sqlSpecial,sqlString,sqlTodo," . s:plgroups

else

    execute 'syn region sqlFold start=/^\s*\zs\c\(create\|update\|alter\|select\|insert\|do\)\>/ end=/;$/ transparent fold '
        \ . "contains=sqlIsKeyword,sqlIsFunction,sqlComment,sqlIdentifier,sqlNumber,sqlOperator,sqlSpecial,sqlString,sqlTodo," . s:plgroups

endif

unlet s:plgroups

" Default highlighting
hi def link sqlCatalog        Constant
hi def link sqlComment        Comment
hi def link sqlConstant       Constant
hi def link sqlErrorCode      Special
hi def link sqlFunction       Function
hi def link sqlIdentifier     Identifier
hi def link sqlKeyword        sqlSpecial
hi def link sqlPlpgsqlKeyword sqlSpecial
hi def link sqlPlpgsqlVariable Identifier
hi def link sqlPlpgsqlOperator sqlOperator
hi def link sqlNumber         Number
hi def link sqlOperator       sqlStatement
hi def link sqlOption         Define
hi def link sqlSpecial        Special
hi def link sqlStatement      Statement
hi def link sqlString         String
hi def link sqlTable          Identifier
hi def link sqlType           Type
hi def link sqlView           sqlTable
hi def link sqlTodo           Todo
hi def link sqlPsqlCommand    SpecialKey
hi def link sqlPsqlKeyword    Keyword
hi def link sqlCreateTypeKeyword sqlKeyword
hi def link sqlCreateOperatorKeyword sqlKeyword
hi def link sqlCreateTextSearchKeyword sqlKeyword

let b:current_syntax = "sql"

