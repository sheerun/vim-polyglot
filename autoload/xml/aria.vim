" Vim completion for WAI-ARIA data file
" Language:       HTML + WAI-ARIA
" Maintainer:     othree <othree@gmail.com>
" Last Change:    2010 Sep 09

" WAI_ARIA: {{{
" Ref: http://www.w3.org/TR/wai-aria/
" Version: Draft 15 December 2009

let abstract_role = {}
let role_attributes = {}
let default_role = {}

" Ref: http://www.w3.org/TR/wai-aria/roles
" Version: Draft 15 December 2009
let widget_role = ['alert', 'alertdialog', 'button', 'checkbox', 'combobox', 'dialog', 'gridcell', 'link', 'log', 'marquee', 'menuitem', 'menuitemcheckbox', 'menuitemradio', 'option', 'progressbar', 'radio', 'radiogroup', 'scrollbar', 'slider', 'spinbutton', 'status', 'tab', 'tabpanel', 'textbox', 'timer', 'tooltip', 'treeitem', 'combobox', 'grid', 'listbox', 'menu', 'menubar', 'radiogroup', 'tablist', 'tree', 'treegrid']
let document_structure = ['article', 'columnheader', 'definition', 'directory', 'document', 'group', 'heading', 'img', 'list', 'listitem', 'math', 'note', 'presentation', 'region', 'row', 'rowheader', 'separator']
let landmark_role = ['application', 'banner', 'complementary', 'contentinfo', 'form', 'main', 'navigation', 'search']
let role = extend(widget_role, document_structure)
let role = extend(role, landmark_role)

" http://www.w3.org/TR/wai-aria/states_and_properties#state_prop_taxonomy
"let global_states_and_properties = {'aria-atomic': ['true', 'false'], 'aria-busy': ['true', 'false'], 'aria-controls': [], 'aria-describedby': [], 'aria-disabled': ['true', 'false'], 'aria-dropeffect': ['copy', 'move', 'link', 'execute', 'popup', 'none'], 'aria-flowto': [], 'aria-grabbed': ['true', 'false', 'undefined'], 'aria-haspopup': ['true', 'false'], 'aria-hidden': ['true', 'false'], 'aria-invalid': ['grammar', 'spelling', 'true', 'false'], 'aria-label': [], 'aria-labelledby': [], 'aria-live': ['off', 'polite', 'assertive'], 'aria-owns': [], 'aria-relevant': ['additions', 'removals', 'text', 'all']}
let widget_attributes = {'aria-autocomplete': ['inline', 'list', 'both', 'none'], 'aria-checked': ['true', 'false', 'mixed', 'undefined'], 'aria-disabled': ['true', 'false'], 'aria-expanded': ['true', 'false', 'undefined'], 'aria-haspopup': ['true', 'false'], 'aria-hidden': ['true', 'false'], 'aria-invalid': ['grammar', 'spelling', 'true', 'false'], 'aria-label': [], 'aria-level': [], 'aria-multiline': ['true', 'false'], 'aria-multiselectable': ['true', 'false'], 'aria-orientation': ['horizontal', 'vertical'], 'aria-pressed': ['true', 'false', 'mixed', 'undefined'], 'aria-readonly': ['true', 'false'], 'aria-required': ['true', 'false'], 'aria-selected': ['true', 'false', 'undefined'], 'aria-sort': ['ascending', 'descending', 'none', 'other'], 'aria-valuemax': [], 'aria-valuemin': [], 'aria-valuenow': [], 'aria-valuetext': []}
let live_region_attributes = {'aria-atomic': ['true', 'false'], 'aria-busy': ['true', 'false'], 'aria-live': ['off', 'polite', 'assertive'], 'aria-relevant': ['additions', 'removals', 'text', 'all', 'additions text']}
let drag_and_drop_attributes = {'aria-dropeffect': ['copy', 'move', 'link', 'execute', 'popup', 'none'], 'aria-grabbed': ['true', 'false', 'undefined']}
let relationship_attributes = {'aria-activedescendant': [], 'aria-controls': [], 'aria-describedby': [], 'aria-flowto': [], 'aria-labelledby': [], 'aria-owns': [], 'aria-posinset': [], 'aria-setsize': []}
let aria_attributes = widget_attributes
let aria_attributes = extend(aria_attributes, live_region_attributes)
let aria_attributes = extend(aria_attributes, drag_and_drop_attributes)
let aria_attributes = extend(aria_attributes, relationship_attributes)

" Abstract Roles
let abstract_role['roletype'] = ['aria-atomic', 'aria-busy', 'aria-controls', 'aria-describedby', 'aria-disabled', 'aria-dropeffect', 'aria-flowto', 'aria-grabbed', 'aria-haspopup', 'aria-hidden', 'aria-invalid', 'aria-label', 'aria-labelledby', 'aria-live', 'aria-owns', 'aria-relevant']
let role_attributes['default'] = abstract_role['roletype']
let abstract_role['structure'] = abstract_role['roletype']
let abstract_role['widget'] = abstract_role['roletype']
let abstract_role['window'] = abstract_role['roletype'] + ['aria-expanded']
let abstract_role['composite'] = abstract_role['widget'] + ['aria-activedescendant']
let abstract_role['input'] = abstract_role['widget']
let abstract_role['section'] = abstract_role['structure'] + ['aria-expanded']
let abstract_role['sectionhead'] = abstract_role['structure'] + ['aria-expanded']

let role_attributes['group'] = abstract_role['section']
let abstract_role['select'] = abstract_role['composite'] + role_attributes['group'] + abstract_role['input']

let abstract_role['range'] = abstract_role['input'] + ['aria-valuemax', 'aria-valuemin', 'aria-valuenow', 'aria-valuetext']

let role_attributes['region'] = abstract_role['section']
let abstract_role['landmark'] = role_attributes['region']

" Widget Roles
let role_attributes['list'] = role_attributes['region'] 
let role_attributes['listitem'] = abstract_role['section']

let role_attributes['dialog'] = abstract_role['window']
let role_attributes['menuitem'] = abstract_role['input'] 
let role_attributes['checkbox'] = abstract_role['input'] + ['aria-checked'] 
let role_attributes['menuitemcheckbox'] = role_attributes['menuitem'] + role_attributes['checkbox']
let role_attributes['option'] = abstract_role['input'] + ['aria-checked', 'aria-posinset', 'aria-selected', 'aria-setsize']
let role_attributes['radio'] = role_attributes['checkbox'] + role_attributes['option']

let role_attributes['directory'] = role_attributes['list'] 

let role_attributes['alert'] = role_attributes['region']
let role_attributes['alertdialog'] = role_attributes['alert'] + role_attributes['dialog']
let role_attributes['button'] = role_attributes['region'] + role_attributes['menuitemcheckbox']
let role_attributes['combobox'] = abstract_role['select'] + ['aria-expanded', 'aria-required'] 
let role_attributes['gridcell'] = abstract_role['section'] + abstract_role['widget']
let role_attributes['link'] = abstract_role['widget'] 
let role_attributes['log'] = role_attributes['region'] 
let role_attributes['marquee'] = role_attributes['region'] 
let role_attributes['menuitemradio'] = role_attributes['menuitemcheckbox'] + role_attributes['radio']
let role_attributes['progressbar'] = abstract_role['widget'] + ['aria-valuemax', 'aria-valuemin', 'aria-valuenow', 'aria-valuetext']
let role_attributes['radiogroup'] = abstract_role['select'] + ['aria-required']
let role_attributes['scrollbar'] = abstract_role['range'] + ['aria-controls', 'aria-orientation', 'aria-valuemax', 'aria-valuemin', 'aria-valuenow']
let role_attributes['slider'] = abstract_role['range'] + ['aria-valuemax', 'aria-valuemin', 'aria-valuenow']
let role_attributes['spinbutton'] = abstract_role['composite'] + abstract_role['range'] + ['aria-required'] 
let role_attributes['status'] = abstract_role['composite'] + role_attributes['region']
let role_attributes['tab'] = abstract_role['sectionhead'] + abstract_role['widget'] + ['aria-selected']
let role_attributes['tabpanel'] = role_attributes['region']
let role_attributes['textbox'] = abstract_role['input'] + ['aria-autocomplete', 'aria-multiline', 'aria-readonly', 'aria-required']
let role_attributes['timer'] = role_attributes['status'] 
let role_attributes['tooltip'] = abstract_role['section'] 
let role_attributes['treeitem'] = role_attributes['listitem'] + role_attributes['option']

let role_attributes['grid'] = abstract_role['composite'] + role_attributes['region'] + ['aria-level', 'aria-multiselectable', 'aria-readonly']
let role_attributes['listbox'] = role_attributes['list'] + abstract_role['select'] + ['aria-multiselectable', 'aria-required']
let role_attributes['menu'] =  role_attributes['list'] + abstract_role['select'] 
let role_attributes['menubar'] = role_attributes['menu'] 
let role_attributes['tablist'] = abstract_role['composite'] + role_attributes['directory']
let role_attributes['toolbar'] = role_attributes['group'] 
let role_attributes['tree'] = abstract_role['select'] + ['aria-multiselectable', 'aria-required']
let role_attributes['treegrid'] = role_attributes['grid'] + role_attributes['tree']

" Document Structure
let role_attributes['document'] = abstract_role['structure'] + ['aria-expanded'] 

let role_attributes['article'] = role_attributes['document'] + role_attributes['region'] 
let role_attributes['columnheader'] = role_attributes['gridcell'] + abstract_role['sectionhead'] + ['aria-sort']
let role_attributes['definition'] = abstract_role['section'] 
let role_attributes['heading'] = abstract_role['sectionhead'] + ['aria-level'] 
let role_attributes['img'] = abstract_role['section'] 
let role_attributes['math'] = abstract_role['section'] 
let role_attributes['note'] = abstract_role['section'] 
let role_attributes['presentation'] = abstract_role['structure']
let role_attributes['row'] = role_attributes['group'] + ['aria-level', 'aria-selected']
let role_attributes['rowheader'] = role_attributes['gridcell'] + abstract_role['sectionhead']
let role_attributes['separator'] = abstract_role['structure'] + ['aria-expanded'] 

" Landmark Roles
let role_attributes['application'] = abstract_role['landmark'] 
let role_attributes['banner'] = abstract_role['landmark'] 
let role_attributes['complementary'] = abstract_role['landmark'] 
let role_attributes['contentinfo'] = abstract_role['landmark'] 
let role_attributes['form'] = abstract_role['landmark'] 
let role_attributes['main'] = abstract_role['landmark'] 
let role_attributes['navigation'] = abstract_role['landmark'] 
let role_attributes['search'] = abstract_role['landmark']

" http://www.w3.org/TR/wai-aria/states_and_properties#state_prop_def
let aria_attributes_value = {
    \ 'aria-autocomplete': ['ID', ''],
    \ 'aria-checked': ['Token', ''],
    \ 'aria-disabled': ['true/false', ''],
    \ 'aria-expanded': ['Token', ''],
    \ 'aria-haspopup': ['true/false', ''],
    \ 'aria-hidden': ['true/false', ''],
    \ 'aria-invalid': ['Token', ''],
    \ 'aria-label': ['String', ''],
    \ 'aria-level': ['Int', ''],
    \ 'aria-multiline': ['true/false', ''],
    \ 'aria-multiselectable': ['true/false', ''],
    \ 'aria-orientation': ['Token', ''],
    \ 'aria-pressed': ['Token', ''],
    \ 'aria-readonly': ['true/false', ''],
    \ 'aria-required': ['true/false', ''],
    \ 'aria-selected': ['Token', ''],
    \ 'aria-sort': ['Token', ''],
    \ 'aria-valuemax': ['Number', ''],
    \ 'aria-valuemin': ['Number', ''],
    \ 'aria-valuenow': ['Number', ''],
    \ 'aria-valuetext': ['String', ''],
    \ 'aria-atomic': ['true/false', ''],
    \ 'aria-busy': ['true/false', ''],
    \ 'aria-live': ['Token', ''],
    \ 'aria-relevant': ['*Token', ''],
    \ 'aria-dropeffect': ['*Token', ''],
    \ 'aria-grabbed': ['Token', ''],
    \ 'aria-activedescendant': ['ID', ''],
    \ 'aria-controls': ['*ID', ''],
    \ 'aria-describedby': ['*ID', ''],
    \ 'aria-flowto': ['*ID', ''],
    \ 'aria-labelledby': ['*ID', ''],
    \ 'aria-owns': ['*ID', ''],
    \ 'aria-posinset': ['Int', ''],
    \ 'aria-setsize': ['Int', '']
\ }

" http://dev.w3.org/html5/spec/content-models.html#annotations-for-assistive-technology-products-aria
let default_role = {
    \ 'a': 'link',
    \ 'area': 'link',
    \ 'body': 'document',
    \ 'button': 'button',
    \ 'datalist': 'listbox',
    \ 'h1': 'heading',
    \ 'h2': 'heading',
    \ 'h3': 'heading',
    \ 'h4': 'heading',
    \ 'h5': 'heading',
    \ 'h6': 'heading',
    \ 'hgroup': 'heading',
    \ 'hr': 'separator',
    \ 'img[alt=]': 'presentation',
    \ 'input[type=button]': 'button',
    \ 'input[type=email]': 'textbox',
    \ 'input[type=image]': 'button',
    \ 'input[type=number]': 'spinbutton',
    \ 'input[type=password]': 'textbox',
    \ 'input[type=range]': 'slider',
    \ 'input[type=reset]': 'button',
    \ 'input[type=search]': 'textbox',
    \ 'input[type=submit]': 'button',
    \ 'input[type=tel]': 'textbox',
    \ 'input[type=text]': 'textbox',
    \ 'input[list]': 'combobox',
    \ 'input[type=url]': 'textbox',
    \ 'input': 'textbox',
    \ 'keygen': 'default',
    \ 'label': 'default',
    \ 'menu[type=list]': 'menu',
    \ 'menu[type=toolbar]': 'toolbar',
    \ 'menu': 'default',
    \ 'link': 'link',
    \ 'nav': 'navigation',
    \ 'optgroup': 'default',
    \ 'option': 'option',
    \ 'progress': 'progressbar',
    \ 'select': 'listbox',
    \ 'summary': 'heading',
    \ 'tbody': 'rowgroup',
    \ 'td': 'gridcell',
    \ 'textarea': 'textbox',
    \ 'tfoot': 'rowgroup',
    \ 'th[scope=col]': 'columnheader',
    \ 'th[scope=row]': 'rowheader',
    \ 'tr': 'row',
    \ 'address': 'default',
    \ 'article': 'article',
    \ 'aside': 'note',
    \ 'footer': 'default',
    \ 'header': 'default',
    \ 'details': 'group',
    \ 'img': 'img',
    \ 'input[type=checkbox]': 'checkbox',
    \ 'input[type=radio]': 'radio',
    \ 'li': 'listitem',
    \ 'ol': 'list',
    \ 'output': 'status',
    \ 'section': 'region',
    \ 'table': 'grid',
    \ 'ul': 'list',
\ }
" }}}

let g:xmldata_aria = {
    \ 'aria_attributes': aria_attributes,
    \ 'role_attributes': role_attributes,
    \ 'default_role': default_role,
    \ 'vimariaattrinfo': aria_attributes_value
\ }
