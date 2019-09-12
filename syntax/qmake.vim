if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'qmake') == -1

" qmake project syntax file
" Language:     qmake project
" Maintainer:   Arto Jonsson <ajonsson@kapsi.fi>
" http://gitorious.org/qmake-project-syntax-vim

if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

syntax case match

" Comment
syn match qmakeComment "#.*"

" Variables
syn match qmakeVariable /[A-Z_]\+\s*=/he=e-1
syn match qmakeVariable /[A-Z_]\+\s*\(+\|-\||\|*\|\~\)=/he=e-2
syn keyword qmakeVariable
			\ CONFIG
			\ DEFINES
			\ DEF_FILE
			\ DEPENDPATH
			\ DESTDIR
			\ DISTFILES
			\ DLLDESTDIR
			\ FORMS
			\ GUID
			\ HEADERS
			\ ICON
			\ IDLSOURCES
			\ INCLUDEPATH
			\ INSTALLS
			\ LEXIMPLS
			\ LEXOBJECTS
			\ LEXSOURCES
			\ LIBS
			\ LITERAL_HASH
			\ MAKEFILE
			\ MAKEFILE_GENERATOR
			\ MOC_DIR
			\ MSVCPROJ_*
			\ OBJECTIVE_HEADERS
			\ OBJECTIVE_SOURCES
			\ OBJECTS
			\ OBJECTS_DIR
			\ OUT_PWD
			\ POST_TARGETDEPS
			\ PRECOMPILED_HEADER
			\ PRE_TARGETDEPS
			\ PWD
			\ QMAKE
			\ QMAKESPEC
			\ QMAKE_AR_CMD
			\ QMAKE_BUNDLE_DATA
			\ QMAKE_BUNDLE_EXTENSION
			\ QMAKE_CC
			\ QMAKE_CFLAGS
			\ QMAKE_CFLAGS_DEBUG
			\ QMAKE_CFLAGS_RELEASE
			\ QMAKE_CFLAGS_SHLIB
			\ QMAKE_CFLAGS_THREAD
			\ QMAKE_CFLAGS_WARN_OFF
			\ QMAKE_CFLAGS_WARN_ON
			\ QMAKE_CLEAN
			\ QMAKE_CXX
			\ QMAKE_CXXFLAGS
			\ QMAKE_CXXFLAGS_DEBUG
			\ QMAKE_CXXFLAGS_RELEASE
			\ QMAKE_CXXFLAGS_SHLIB
			\ QMAKE_CXXFLAGS_THREAD
			\ QMAKE_CXXFLAGS_WARN_OFF
			\ QMAKE_CXXFLAGS_WARN_ON
			\ QMAKE_DEVELOPMENT_TEAM
			\ QMAKE_DISTCLEAN
			\ QMAKE_EXTENSION_SHLIB
			\ QMAKE_EXTENSION_STATICLIB
			\ QMAKE_EXTRA_COMPILERS
			\ QMAKE_EXTRA_TARGETS
			\ QMAKE_EXT_CPP
			\ QMAKE_EXT_H
			\ QMAKE_EXT_LEX
			\ QMAKE_EXT_MOC
			\ QMAKE_EXT_OBJ
			\ QMAKE_EXT_PRL
			\ QMAKE_EXT_UI
			\ QMAKE_EXT_YACC
			\ QMAKE_FAILED_REQUIREMENTS
			\ QMAKE_FRAMEWORK_BUNDLE_NAME
			\ QMAKE_FRAMEWORK_VERSION
			\ QMAKE_HOST
			\ QMAKE_INCDIR
			\ QMAKE_INCDIR_EGL
			\ QMAKE_INCDIR_OPENGL
			\ QMAKE_INCDIR_OPENGL_ES2
			\ QMAKE_INCDIR_OPENVG
			\ QMAKE_INCDIR_X11
			\ QMAKE_INFO_PLIST
			\ QMAKE_IOS_DEPLOYMENT_TARGET
			\ QMAKE_LFLAGS
			\ QMAKE_LFLAGS_APP
			\ QMAKE_LFLAGS_CONSOLE
			\ QMAKE_LFLAGS_DEBUG
			\ QMAKE_LFLAGS_PLUGIN
			\ QMAKE_LFLAGS_RELEASE
			\ QMAKE_LFLAGS_REL_RPATH
			\ QMAKE_LFLAGS_RPATH
			\ QMAKE_LFLAGS_RPATHLINK
			\ QMAKE_LFLAGS_SHLIB
			\ QMAKE_LFLAGS_SONAME
			\ QMAKE_LFLAGS_THREAD
			\ QMAKE_LFLAGS_WINDOWS
			\ QMAKE_LIBDIR
			\ QMAKE_LIBDIR_EGL
			\ QMAKE_LIBDIR_FLAGS
			\ QMAKE_LIBDIR_OPENGL
			\ QMAKE_LIBDIR_OPENVG
			\ QMAKE_LIBDIR_X11
			\ QMAKE_LIBS
			\ QMAKE_LIBS_EGL
			\ QMAKE_LIBS_OPENGL
			\ QMAKE_LIBS_OPENGL_ES1, QMAKE_LIBS_OPENGL_ES2
			\ QMAKE_LIBS_OPENVG
			\ QMAKE_LIBS_THREAD
			\ QMAKE_LIBS_X11
			\ QMAKE_LIB_FLAG
			\ QMAKE_LINK
			\ QMAKE_LINK_SHLIB_CMD
			\ QMAKE_LN_SHLIB
			\ QMAKE_MACOSX_DEPLOYMENT_TARGET
			\ QMAKE_MAC_SDK
			\ QMAKE_MAKEFILE
			\ QMAKE_OBJECTIVE_CFLAGS
			\ QMAKE_POST_LINK
			\ QMAKE_PRE_LINK
			\ QMAKE_PROJECT_NAME
			\ QMAKE_PROVISIONING_PROFILE
			\ QMAKE_QMAKE
			\ QMAKE_REL_RPATH_BASE
			\ QMAKE_RESOURCE_FLAGS
			\ QMAKE_RPATHDIR
			\ QMAKE_RPATHLINKDIR
			\ QMAKE_RUN_CC
			\ QMAKE_RUN_CC_IMP
			\ QMAKE_RUN_CXX
			\ QMAKE_RUN_CXX_IMP
			\ QMAKE_SONAME_PREFIX
			\ QMAKE_TARGET
			\ QMAKE_TARGET_COMPANY
			\ QMAKE_TARGET_COPYRIGHT
			\ QMAKE_TARGET_DESCRIPTION
			\ QMAKE_TARGET_PRODUCT
			\ QMAKE_TVOS_DEPLOYMENT_TARGET
			\ QMAKE_UIC_FLAGS
			\ QMAKE_WATCHOS_DEPLOYMENT_TARGET
			\ QT
			\ QTPLUGIN
			\ QT_MAJOR_VERSION
			\ QT_MINOR_VERSION
			\ QT_PATCH_VERSION
			\ QT_VERSION
			\ RCC_DIR
			\ RC_CODEPAGE
			\ RC_DEFINES
			\ RC_FILE
			\ RC_ICONS
			\ RC_INCLUDEPATH
			\ RC_LANG
			\ REQUIRES
			\ RESOURCES
			\ RES_FILE
			\ SOURCES
			\ SUBDIRS
			\ TARGET
			\ TARGET_EXT
			\ TARGET_x
			\ TARGET_x.y.z
			\ TEMPLATE
			\ TRANSLATIONS
			\ UI_DIR
			\ VERSION
			\ VERSION_PE_HEADER
			\ VER_MAJ
			\ VER_MIN
			\ VER_PAT
			\ VPATH
			\ WINRT_MANIFEST
			\ YACCSOURCES
			\ _PRO_FILE_
			\ _PRO_FILE_PWD_

" Value of a variable
syn match qmakeValue /$$[A-Z_]\+/
syn match qmakeValue /$${[A-Z_]\+}/

" Environment variable
syn match qmakeEnvVariable /$([A-Z_]\+)/
syn match qmakeEnvVariable /$$([A-Z_]\+)/

" Qt build configuration
syn match qmakeQtConfiguration /$$\[[A-Z_]\+\]/

" Builtins
" + CONFIG
syn keyword qmakeBuiltin
			\ absolute_path
			\ basename
			\ cache
			\ cat
			\ clean_path
			\ count
			\ debug
			\ defined
			\ dirname
			\ enumerate_vars
			\ equals
			\ error
			\ escape_expand
			\ eval
			\ exists
			\ export
			\ files
			\ find
			\ first
			\ for
			\ format_number
			\ fromfile
			\ getenv
			\ greaterThan
			\ if
			\ include
			\ infile
			\ isActiveConfig
			\ isEmpty
			\ isEqual
			\ join
			\ last
			\ lessThan
			\ list
			\ load
			\ log
			\ lower
			\ member
			\ message
			\ mkpath
			\ num_add
			\ packagesExist
			\ prepareRecursiveTarget
			\ prompt
			\ qtCompileTest
			\ qtHaveModule
			\ quote
			\ re_escape
			\ relative_path
			\ replace
			\ requires
			\ resolve_depends
			\ reverse
			\ section
			\ shadowed
			\ shell_path
			\ shell_quote
			\ size
			\ sort_depends
			\ sorted
			\ split
			\ sprintf
			\ str_member
			\ str_size
			\ system
			\ system_path
			\ system_quote
			\ take_first
			\ take_last
			\ touch
			\ unique
			\ unset
			\ upper
			\ val_escape
			\ versionAtLeast
			\ versionAtMost
			\ warning
			\ write_file
syn match qmakeBuiltin "contains"

" Scopes
syn match qmakeScope /[0-9A-Za-z_-]\+\(|\|:\)/he=e-1
syn match qmakeScope /[0-9A-Za-z_-]\+\s*{/he=e-1

hi def link qmakeComment Comment
hi def link qmakeVariable Identifier
hi def link qmakeBuiltin Function
hi def link qmakeValue PreProc
hi def link qmakeEnvVariable PreProc
hi def link qmakeQtConfiguration PreProc
hi def link qmakeScope Conditional

let b:current_syntax = "qmake"

endif
