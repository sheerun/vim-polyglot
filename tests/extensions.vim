filetype on

function! TestExtension(filetype, filename, content)
  call Log('Detecting ' . a:filetype . ' filetype (' . a:filename . ')...')

  try
    set shortmess+=F
    let g:message = ""
    exec "noautocmd n " . a:filename
    silent put =a:content
    1delete _
    filetype detect
    exec "if &filetype != '" . a:filetype . "' \nthrow &filetype\nendif"
    exec ":bw!"
  catch
    echo g:message
    echo "Filename '" . a:filename  . "' does not resolve to extension '" . a:filetype . "'"
    echo "  instead received: '" . v:exception . "'"
    exec ":cq!"
  endtry
endfunction

" make sure native vim scripts.vim is respected
call TestExtension("rib", "renderman", "##RenderMan")

" make sure case of file does matter when recognizing file
call TestExtension("ruby", "scripts/build", "#!/usr/bin/env ruby")

call TestExtension("sh", "bash1", "#!/bin/bash")
call TestExtension("sh", "bash2", "#! /bin/bash")
call TestExtension("sh", "bash3", "#! /bin/bash2.3")
call TestExtension("sh", "bash4", "#!/usr/bin/env bash")
call TestExtension("sh", "bash6", "#!/usr/bin/env -i -=split-string foo=bar bash -l foo")
call TestExtension("sh", "bash1", "#!/bin/bash")
" This is defined only by vim-native scripts.vim for now
call TestExtension("sh", "bash7", ":")

" Vim help file
call TestExtension("help", $VIMRUNTIME . "/doc/foobar.txt", "")

" Abaqus or Trasys
call TestExtension("abaqus", "foobar.inp", "*HEADING\nFoobar")
call TestExtension("trasys", "foobar.inp", "MSC PATRAN\n* foobar\nHEADER SURFACE DATA\nBSC ENCLO1")

" 8th (Firth-derivative)
call TestExtension("8th", "foobar.8th", "")
call TestExtension("8th", "foobar.8th", "")

" A-A-P recipe
call TestExtension("aap", "foobar.aap", "")


" A2ps printing utility
call TestExtension("a2ps", "/etc/a2ps.cfg", "")
call TestExtension("a2ps", "/usr/local/etc/a2ps.cfg", "")
call TestExtension("a2ps", "/etc/a2ps/foobar.cfg", "")
call TestExtension("a2ps", "/usr/local/etc/a2ps/foobar.cfg", "")
call TestExtension("a2ps", "/tmp/a2psrc", "")
call TestExtension("a2ps", "/tmp/.a2psrc", "")

" ABAB/4
call TestExtension("abap", "foobar.abap", "")

" ABC music notation
call TestExtension("abc", "foobar.abc", "")

" ABEL
call TestExtension("abel", "foobar.abl", "")

" AceDB
call TestExtension("acedb", "foobar.wrm", "")

" Ada (83, 9X, 95)
call TestExtension("ada", "foobar.adb", "")
call TestExtension("ada", "foobar.ads", "")
call TestExtension("ada", "foobar.ada", "")
call TestExtension("ada", "foobar.gpr", "")

" AHDL
call TestExtension("ahdl", "foobar.tdf", "")

" AIDL
call TestExtension("aidl", "foobar.aidl", "")

" AMPL
call TestExtension("ampl", "foobar.run", "")

" Ant
call TestExtension("ant", "build.xml", "")

" Arduino
call TestExtension("arduino", "foobar.ino", "")
call TestExtension("arduino", "foobar.pde", "")

" Apache config file
call TestExtension("apache", ".htaccess", "")
call TestExtension("apache", "/etc/httpd/foobar.conf", "")
call TestExtension("apache", "/etc/apache2/sites-foobar/foobar.com", "")
call TestExtension("apache", "/usr/local/etc/httpd/foobar.conf", "")
call TestExtension("apache", "/usr/local/etc/apache2/sites-foobar/foobar.com", "")

" XA65 MOS6510 cross assembler
call TestExtension("a65", "foobar.a65", "")

" Applescript
call TestExtension("applescript", "foobar.scpt", "")

" Applix ELF
call TestExtension("elf", "foobar.am", "")
call TestExtension("automake", "Makefile.am", "")
call TestExtension("automake", "makefile.am", "")

" ALSA configuration
call TestExtension("alsaconf", ".asoundrc", "")
call TestExtension("alsaconf", "/usr/share/alsa/alsa.conf", "")
call TestExtension("alsaconf", "/media/foo/usr/share/alsa/alsa.conf", "")
call TestExtension("alsaconf", "/etc/asound.conf", "")
call TestExtension("alsaconf", "/media/foo/etc/asound.conf", "")

" Arc Macro Language
call TestExtension("aml", "foobar.aml", "")

" APT config file
call TestExtension("aptconf", "apt.conf", "")
call TestExtension("aptconf", "/root/.aptitude/config", "")
call TestExtension("aptconf", "/etc/apt/apt.conf.d/foo_bar-12", "")
call TestExtension("aptconf", "/etc/apt/apt.conf.d/foo_bar-12.conf", "")
call TestExtension("", "/etc/apt/apt.conf.d/.gsdf", "")

" Arch Inventory file
call TestExtension("arch", ".arch-inventory", "")
call TestExtension("arch", "=tagging-method", "")

" ART*Enterprise (formerly ART-IM)
call TestExtension("art", "foobar.art", "")

" AsciiDoc
call TestExtension("asciidoc", "foobar.asciidoc", "")
call TestExtension("asciidoc", "foobar.adoc", "")

" ASN.1
call TestExtension("asn", "foobar.asn", "")
call TestExtension("asn", "foobar.asn1", "")

" Active Server Pages (with Visual Basic Script)
call TestExtension("aspvbs", "foobar.asa", "")
let g:filetype_asa = "fizfuz"
call TestExtension("fizfuz", "foobar.asa", "")

" Active Server Pages (with Perl or Visual Basic Script)
call TestExtension("aspvbs", "vbs.asp", "")
call TestExtension("aspperl", "perl.asp", "<Job ID=\"DropFiles\">\n<script language=\"PerlScript\">\n</script>\n</Job>")
let g:filetype_asp = "fizfuz"
call TestExtension("fizfuz", "fizfuz.asp", "")


" Grub (must be before catch *.lst)
call TestExtension("grub", "/boot/grub/menu.lst", "")
call TestExtension("grub", "/media/foobar/boot/grub/menu.lst", "")
call TestExtension("grub", "/boot/grub/grub.conf", "")
call TestExtension("grub", "/media/foobar/boot/grub/grub.conf", "")
call TestExtension("grub", "/etc/grub.conf", "")
call TestExtension("grub", "/media/foobar/etc/grub.conf", "")

" Assembly (all kinds)
" *.lst is not pure assembly, it has two extra columns (address, byte codes)

au BufNewFile,BufRead *.asm,*.[sS],*.[aA],*.mac,*.lst	call dist#ft#FTasm()

" Macro (VAX)
call TestExtension("vmasm", "foobar.mar", "")

" Atlas
call TestExtension("atlas", "foobar.atl", "")
call TestExtension("atlas", "foobar.as", "")

" Autoit v3
call TestExtension("autoit", "foobar.au3", "")

" Autohotkey
call TestExtension("autohotkey", "foobar.ahk", "")

" Automake
call TestExtension("automake", "Makefile.am", "")
call TestExtension("automake", "makefile.am", "")
call TestExtension("automake", "GNUmakefile.am", "")

" Autotest .at files are actually m4
call TestExtension("m4", "foobar.at", "")

" Avenue
call TestExtension("ave", "foobar.ave", "")

" Awk
call TestExtension("awk", "foobar.awk", "")

" C++
call TestExtension("c", "foobar.c", "")
call TestExtension("cpp", "foobar.cxx", "")
call TestExtension("cpp", "foobar.c++", "")
call TestExtension("cpp", "foobar.hh", "")
call TestExtension("cpp", "foobar.hxx", "")
call TestExtension("cpp", "foobar.hpp", "")
call TestExtension("cpp", "foobar.ipp", "")
call TestExtension("cpp", "foobar.moc", "")
call TestExtension("cpp", "foobar.tcc", "")
call TestExtension("cpp", "foobar.inl", "")

" Django

call TestExtension("htmldjango", "foobar.j2", "")
call TestExtension("htmldjango", "foobar.jinja", "")
call TestExtension("htmldjango", "foobar.jinja2", "")

" vim-polyglot only
call TestExtension("blade", "test.blade.php", "")
call TestExtension("yaml.ansible", "playbook.yml", "")
call TestExtension("yaml.ansible", "host_vars/foobar", "")
call TestExtension("yaml.ansible", "handlers.foobar.yaml", "")
call TestExtension("yaml.ansible", "requirements.yaml", "")
call TestExtension("ps1xml", "foobar.ps1xml", "")
call TestExtension("terraform", "terraform.tf", "")

call TestExtension("idris2", "foobar.idr", "")
call TestExtension("idris", "foobar.idr", "pkgs : List String\npkgs = [\"NCurses\", \"Readline\"]")
let g:filetype_idr = "fizfuz"
call TestExtension("fizfuz", "fizfuz.idr", "")

" .m extension
call TestExtension("octave", "matlab.m", "")
call TestExtension("objc", "objc.m", "\n\n  #import <Foundation/Foundation.h>")
call TestExtension("octave", "objc.m", "results_ub_times=zeros(2,2,M);\n%results pour la lower bound")
call TestExtension("mma", "mathematica.m", "newcase[ \"00003\" ];\n  (* Hello world *)")
call TestExtension("murphi", "murphi.m", "type\n  square: 1 .. 9")
call TestExtension("murphi", "murphi.m", "something\n--foobar")
call TestExtension("octave", "percentcomment.m", "hello world\n%foobar")
call TestExtension("objc", "comment.m", "\n/* Hello world */")
let g:filetype_m = "fizfuz"
call TestExtension("fizfuz", "fizfuz.m", "")

" .fs extension
call TestExtension("forth", "empty.fs", "")
call TestExtension("fsharp", "fsharp.fs", "let myInt = 5")
call TestExtension("glsl", "glsl.fs", "//#version 120\nvoid main() {}")
let g:filetype_fs = "fizfuz"
call TestExtension("fizfuz", "fizfuz.fs", "")

" .re extension
call TestExtension("reason", "empty.re", "")
call TestExtension("cpp", "cpp.re", "#include \"config.h\"")
call TestExtension("cpp", "cpp2.re", "#ifdef HAVE_CONFIG_H")
call TestExtension("cpp", "cpp3.re", "#define YYCTYPE unsigned char")
call TestExtension("reason", "react.re", "ReasonReact.Router.push('');")

" .bas extension
call TestExtension("vbnet", "vb.vb", "")
call TestExtension("basic", "empty.bas", "")
call TestExtension("vb", "vb1.bas", "Attribute VB_Name = \"Class1\"")
call TestExtension("vb", "vb2.bas", "VERSION 5.00\nBegin VB.Form Form1")
call TestExtension("vb", "vb2.bas", "VERSION 5.00\nBegin VB.Form Form1")
call TestExtension("vb", "vb.sba", "")
call TestExtension("vb", "vb.vbs", "")
call TestExtension("vb", "vb.dsm", "")
call TestExtension("vb", "vb.dsm", "")
call TestExtension("vb", "vb.ctl", "")

" .idr extension
call TestExtension("idris", "lowercase.idr", "--idris1")
call TestExtension("idris", "uppercase.idr", "--Idris1")
call TestExtension("idris", "start-space-l.idr", "-- idris1")
call TestExtension("idris", "start-space-u.idr", "-- Idris1")
call TestExtension("idris", "two-spaces-l.idr", "-- idris 1")
call TestExtension("idris", "two-spaces-u.idr", "-- Idris 1")
"call TestExtension("idris", "mypkg.ipkg", "package mypkg\n\npkgs = pruviloj, lightyear")
call TestExtension("idris", "use-type-prov.idr", "%language TypeProviders")
call TestExtension("idris", "use-elab-refl.idr", "%language ElabReflection")
call TestExtension("idris", "access-modifier.idr", "%access export\n\npublic export\nMyTest : Type-> Type\n\nfact : Nat -> Nat")
call TestExtension("idris2", "lowercase.idr", "--idris2")
call TestExtension("idris2", "uppercase.idr", "--Idris2")
call TestExtension("idris2", "start-space-l.idr", "-- idris2")
call TestExtension("idris2", "start-space-u.idr", "-- Idris2")
call TestExtension("idris2", "two-spaces-l.idr", "-- idris 2")
call TestExtension("idris2", "two-spaces-u.idr", "-- Idris 2")
call TestExtension("idris2", "mypkg.ipkg", "package mypkg\n\ndepends = effects")
call TestExtension("idris2", "use-post-proj.idr", "%language PostfixProjections")

" .lidr extension
call TestExtension("lidris", "lidris-1.lidr", "Some test plaintext\n\n> --idris1\n> myfact : Nat -> Nat\n> myfact Z = 1\n> myfact (S k) = (S k) * myfact k\n\nMore plaintext")
call TestExtension("lidris2", "lidris-2.lidr", "Some test plaintext\n\n> --idris2\n> myfact : Nat -> Nat\n> myfact Z = 1\n> myfact (S k) = (S k) * myfact k\n\nMore plaintext")


" .h extension
call TestExtension("objcpp", "foo.h", "@interface MTNavigationController : UINavigationController")
call TestExtension("cpp", "foo.h", "")
let g:c_syntax_for_h = 1
call TestExtension("objc", "foo.h", "@interface MTNavigationController : UINavigationController")
call TestExtension("c", "foo.h", "")
unlet g:c_syntax_for_h
let g:ch_syntax_for_h = 1
call TestExtension("ch", "foo.h", "")

" perl
call TestExtension("perl", "empty.plx", "")
call TestExtension("perl", "empty.al", "")
call TestExtension("perl", "empty.psgi", "")
call TestExtension("pod", "empty.pod", "")

" raku
call TestExtension("raku", "empty.p6", "")
call TestExtension("raku", "empty.pm6", "")
call TestExtension("raku", "empty.pl6", "")
call TestExtension("raku", "empty.raku", "")
call TestExtension("raku", "empty.rakumod", "")
call TestExtension("raku", "empty.pod6", "")
call TestExtension("raku", "empty.rakudoc", "")
call TestExtension("raku", "empty.rakutest", "")
call TestExtension("raku", "empty.t6", "")


" .pm extension
call TestExtension("perl", "empty.pm", "")
call TestExtension("perl", "strict.pm", " use strict hello;")
call TestExtension("perl", "use5.pm", " use 5;")
call TestExtension("perl", "usev5.pm", " use v5;")
call TestExtension("raku", "script.pm", "#!/usr/bin/env perl6\nprint('Hello world')")
call TestExtension("raku", "class.pm", " class Class {}")
call TestExtension("raku", "module.pm", " module foobar")
call TestExtension("xpm", "xpm.pm", "/* XPM */")
call TestExtension("xpm2", "xpm2.pm", "/* XPM2 */")
let g:filetype_pm = "fizfuz"
call TestExtension("fizfuz", "fizfuz.pm", "")

" .pl extension
call TestExtension("perl", "empty.pl", "")
call TestExtension("prolog", "comment.pl", "% hello world")
call TestExtension("prolog", "comment2.pl", "/* hello world */")
call TestExtension("prolog", "statement.pl", "happy(vincent). ")
call TestExtension("prolog", "statement2.pl", "nearbychk(X,Y) :- Y is X-1.")
call TestExtension("perl", "strict.pl", " use strict hello;")
call TestExtension("perl", "use5.pl", " use 5;")
call TestExtension("perl", "usev5.pl", " use v5;")
call TestExtension("raku", "script.pl", "#!/usr/bin/env perl6\nprint('Hello world')")
call TestExtension("raku", "class.pl", " class Class {}")
call TestExtension("raku", "module.pl", " module foobar")
let g:filetype_pl = "fizfuz"
call TestExtension("fizfuz", "fizfuz.pl", "")

" .t extension
call TestExtension("perl", "empty.t", "")
call TestExtension("perl", "strict.t", " use strict hello;")
call TestExtension("perl", "use5.t", " use 5;")
call TestExtension("perl", "usev5.t", " use v5;")
call TestExtension("raku", "script.t", "#!/usr/bin/env perl6\nprint('Hello world')")
call TestExtension("raku", "class.t", " class Class {}")
call TestExtension("raku", "module.t", " module foobar")
call TestExtension("nroff", "module.t", ".nf\n101 Main Street")
let g:filetype_t = "fizfuz"
call TestExtension("fizfuz", "fizfuz.t", "")

" .tt2 extension
call TestExtension("tt2", "empty.tt2", "")
call TestExtension("tt2html", "doctype.tt2", "<!DOCTYPE HTML>")
call TestExtension("tt2html", "percent.tt2", "<%filter>")
call TestExtension("tt2html", "html.tt2", "<html>")

" .html extension
call TestExtension("html", "empty.html", "")
call TestExtension("mason", "mason1.html", "% my $planet = 42;")
call TestExtension("mason", "mason2.html", "<%filter></%filter>")
call TestExtension("htmldjango", "jinja2.html", "{% for item in navigation %}{% endfor %}")
call TestExtension("htmldjango", "jinja3.html", "{% block head %}")
call TestExtension("htmldjango", "jinja4.html", "{# some comment #}")
call TestExtension("htmldjango", "jinja3.html", "{% load static %}")
call TestExtension("xhtml", "xhtml.html", "<DTD   XHTML ")

" many html templates use {{ }}, e.g. Angular, we should not assume django
call TestExtension("html", "template.html", "{{ item.href }}")

" .gitignore
call TestExtension("gitignore", ".gitignore", "")

" .xml
call TestExtension("xml", ".fglrxrc", "")
call TestExtension("xml", "fglrxrc", "")

" .conf
call TestExtension("conf", "foo.conf", "")
call TestExtension("conf", "config", "")
call TestExtension("conf", "auto.master", "")

" https://github.com/sheerun/vim-polyglot/issues/579
call TestExtension("dart", "reminders.dart", "")

call TestExtension("racket", "empty.rkt", "")

filetype off
