if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'mathematica') == -1
  
"Vim conceal file
" Language: Mathematica
" Maintainer: R. Menon <rsmenon@icloud.com>
" Last Change: Feb 25, 2013

if (exists('g:mma_candy') && g:mma_candy == 0) || !has('conceal') || &enc != 'utf-8'
    finish
endif

"These are fairly safe and straightforward conceals
if exists('g:mma_candy') && g:mma_candy > 0
	"Rules
	syntax match mmaOperator "->" conceal cchar=→ "Rule
	syntax match mmaOperator ":>" conceal cchar=⧴ "RuleDelayed

	"Logicals
	syntax match mmaOperator "===" conceal cchar=≡ "SameQ
	syntax match mmaOperator "=!=" conceal cchar=≢ "UnsameQ
	syntax match mmaOperator "!=" conceal cchar=≠ "NotEqual
	syntax match mmaOperator "<=" conceal cchar=≤ "LessEqual
	syntax match mmaOperator ">=" conceal cchar=≥ "GreaterEqual

	"Constants
	syntax keyword mmaSystemSymbol Pi conceal cchar=π
	syntax keyword mmaSystemSymbol Infinity conceal cchar=∞
	syntax keyword mmaSystemSymbol Degree conceal cchar=°

	"Domains
	syntax keyword mmaSystemSymbol Reals conceal cchar=ℝ
	syntax keyword mmaSystemSymbol Integers conceal cchar=ℤ
	syntax keyword mmaSystemSymbol Complexes conceal cchar=ℂ
	syntax keyword mmaSystemSymbol Rationals conceal cchar=ℚ

	"Greek
	syntax match mmaSymbol "\\\[CapitalAlpha\]" conceal cchar=Α
	syntax match mmaSymbol "\\\[CapitalBeta\]" conceal cchar=Β
	syntax match mmaSymbol "\\\[CapitalGamma\]" conceal cchar=Γ
	syntax match mmaSymbol "\\\[CapitalDelta\]" conceal cchar=Δ
	syntax match mmaSymbol "\\\[CapitalEpsilon\]" conceal cchar=Ε
	syntax match mmaSymbol "\\\[CapitalZeta\]" conceal cchar=Ζ
	syntax match mmaSymbol "\\\[CapitalEta\]" conceal cchar=Η
	syntax match mmaSymbol "\\\[CapitalTheta\]" conceal cchar=Θ
	syntax match mmaSymbol "\\\[CapitalIota\]" conceal cchar=Ι
	syntax match mmaSymbol "\\\[CapitalKappa\]" conceal cchar=Κ
	syntax match mmaSymbol "\\\[CapitalLambda\]" conceal cchar=Λ
	syntax match mmaSymbol "\\\[CapitalMu\]" conceal cchar=Μ
	syntax match mmaSymbol "\\\[CapitalNu\]" conceal cchar=Ν
	syntax match mmaSymbol "\\\[CapitalXi\]" conceal cchar=Ξ
	syntax match mmaSymbol "\\\[CapitalOmicron\]" conceal cchar=Ο
	syntax match mmaSymbol "\\\[CapitalPi\]" conceal cchar=Π
	syntax match mmaSymbol "\\\[CapitalRho\]" conceal cchar=Ρ
	syntax match mmaSymbol "\\\[CapitalSigma\]" conceal cchar=Σ
	syntax match mmaSymbol "\\\[CapitalTau\]" conceal cchar=Τ
	syntax match mmaSymbol "\\\[CapitalUpsilon\]" conceal cchar=Υ
	syntax match mmaSymbol "\\\[CapitalPhi\]" conceal cchar=Φ
	syntax match mmaSymbol "\\\[CapitalChi\]" conceal cchar=Χ
	syntax match mmaSymbol "\\\[CapitalPsi\]" conceal cchar=Ψ
	syntax match mmaSymbol "\\\[CapitalOmega\]" conceal cchar=Ω
	syntax match mmaSymbol "\\\[Alpha\]" conceal cchar=α
	syntax match mmaSymbol "\\\[Beta\]" conceal cchar=β
	syntax match mmaSymbol "\\\[Gamma\]" conceal cchar=γ
	syntax match mmaSymbol "\\\[Delta\]" conceal cchar=δ
	syntax match mmaSymbol "\\\[Epsilon\]" conceal cchar=ε
	syntax match mmaSymbol "\\\[Zeta\]" conceal cchar=ζ
	syntax match mmaSymbol "\\\[Eta\]" conceal cchar=η
	syntax match mmaSymbol "\\\[Theta\]" conceal cchar=θ
	syntax match mmaSymbol "\\\[Iota\]" conceal cchar=ι
	syntax match mmaSymbol "\\\[Kappa\]" conceal cchar=κ
	syntax match mmaSymbol "\\\[Lambda\]" conceal cchar=λ
	syntax match mmaSymbol "\\\[Mu\]" conceal cchar=μ
	syntax match mmaSymbol "\\\[Nu\]" conceal cchar=ν
	syntax match mmaSymbol "\\\[Xi\]" conceal cchar=ξ
	syntax match mmaSymbol "\\\[Omicron\]" conceal cchar=ο
	syntax match mmaSymbol "\\\[Pi\]" conceal cchar=π
	syntax match mmaSymbol "\\\[Rho\]" conceal cchar=ρ
	syntax match mmaSymbol "\\\[Sigma\]" conceal cchar=σ
	syntax match mmaSymbol "\\\[Tau\]" conceal cchar=τ
	syntax match mmaSymbol "\\\[Upsilon\]" conceal cchar=υ
	syntax match mmaSymbol "\\\[Phi\]" conceal cchar=φ
	syntax match mmaSymbol "\\\[Chi\]" conceal cchar=χ
	syntax match mmaSymbol "\\\[Psi\]" conceal cchar=ψ
	syntax match mmaSymbol "\\\[Omega\]" conceal cchar=ω
endif

"These might be troublesome if the appropriate fonts are missing. Also, they don't
"look quite as good as the earlier ones, so enable only if the user chooses to
if exists('g:mma_candy') && g:mma_candy == 2
	"Constants
	syntax keyword mmaSystemSymbol I conceal cchar=ⅈ
	syntax keyword mmaSystemSymbol E conceal cchar=ⅇ

	"Functions
	syntax keyword mmaSystemSymbol Sum conceal cchar=∑
	syntax keyword mmaSystemSymbol Product conceal cchar=∏
	syntax keyword mmaSystemSymbol Sqrt conceal cchar=√

	"Misc
	syntax match mmaOperator ">>" conceal cchar=» "Put
	syntax match mmaOperator "<<" conceal cchar=« "Get
endif

hi! link Conceal Normal
setlocal conceallevel=2

endif
