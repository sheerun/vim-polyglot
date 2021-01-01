if polyglot#init#is_disabled(expand('<sfile>:p'), 'rspec', 'after/syntax/rspec.vim')
  finish
endif

"
" An rspec syntax file
" Originally from http://www.vim.org/scripts/script.php?script_id=2286
"
"

runtime! syntax/ruby.vim
unlet! b:current_syntax

setlocal commentstring=#\ %s

syntax keyword rspecGroupMethods
      \ aggregate_failures
      \ context
      \ describe
      \ example
      \ feature
      \ fcontext
      \ fdescribe
      \ fexample
      \ fit
      \ focus
      \ fspecify
      \ Given
      \ given\!
      \ include_context
      \ include_examples
      \ Invariant
      \ it
      \ it_behaves_like
      \ it_should_behave_like
      \ its
      \ let
      \ let\!
      \ pending
      \ scenario
      \ shared_examples
      \ shared_examples_for
      \ skip
      \ specify
      \ subject
      \ Then
      \ When

syntax keyword rspecBeforeAndAfter
      \ after
      \ after_suite_parts
      \ append_after
      \ append_before
      \ around
      \ before
      \ before_suite_parts
      \ prepend_after
      \ prepend_before

syntax keyword rspecMocks
      \ double
      \ instance_double
      \ instance_spy
      \ mock
      \ spy
      \ stub
      \ stub_chain
      \ stub_const

syntax keyword rspecMockMethods
      \ and_call_original
      \ and_raise
      \ and_return
      \ and_throw
      \ and_yield
      \ build_child
      \ called_max_times
      \ expected_args
      \ invoke
      \ matches

syntax keyword rspecKeywords
      \ should
      \ should_not
      \ should_not_receive
      \ should_receive

syntax keyword rspecMatchers
      \ all
      \ allow
      \ allow_any_instance_of
      \ assigns
      \ be
      \ change
      \ described_class
      \ eq
      \ eql
      \ equal
      \ errors_on
      \ exist
      \ expect
      \ expect_any_instance_of
      \ have
      \ have_at_least
      \ have_at_most
      \ have_exactly
      \ include
      \ is_expected
      \ match
      \ match_array
      \ matcher
      \ not_to
      \ raise_error
      \ raise_exception
      \ receive
      \ receive_messages
      \ receive_message_chain
      \ respond_to
      \ satisfy
      \ throw_symbol
      \ to
      \ to_not
      \ when
      \ wrap_expectation

" rspec-mongoid exclusive matchers
syntax keyword rspecMatchers
      \ accept_nested_attributes_for
      \ belong_to
      \ custom_validate
      \ embed_many
      \ embed_one
      \ validate_associated
      \ validate_exclusion_of
      \ validate_format_of
      \ validate_inclusion_of
      \ validate_length_of

" shoulda matchers
syntax keyword rspecMatchers
      \ allow_mass_assignment_of
      \ allow_value
      \ ensure_exclusion_of
      \ ensure_length_of
      \ have_secure_password
      \ validate_absence_of
      \ validate_acceptance_of
      \ validate_confirmation_of
      \ validate_numericality_of
      \ validate_presence_of
      \ validate_uniqueness_of

syntax keyword rspecMessageExpectation
      \ advise
      \ any_args
      \ any_number_of_times
      \ anything
      \ at_least
      \ at_most
      \ exactly
      \ expected_messages_received
      \ generate_error
      \ hash_including
      \ hash_not_including
      \ ignoring_args
      \ instance_of
      \ matches_at_least_count
      \ matches_at_most_count
      \ matches_exact_count
      \ matches_name_but_not_args
      \ negative_expectation_for
      \ never
      \ no_args
      \ once
      \ ordered
      \ similar_messages
      \ times
      \ twice
      \ verify_messages_received
      \ with

syntax match rspecMatchers /\<\(be\|have\)_\w\+\>/
syntax match rspecGroupMethods /\.describe/

highlight link rspecGroupMethods Statement
highlight link rspecBeforeAndAfter Identifier
highlight link rspecMocks Constant
highlight link rspecMockMethods Function
highlight link rspecKeywords Constant
highlight link rspecMatchers Function
highlight link rspecMessageExpectation Function

let b:current_syntax = 'rspec'
