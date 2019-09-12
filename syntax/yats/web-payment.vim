if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptGlobal containedin=typescriptIdentifierName PaymentRequest
syntax keyword typescriptPaymentMethod contained show abort canMakePayment nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptPaymentMethod
if exists("did_typescript_hilink") | HiLink typescriptPaymentMethod Keyword
endif
syntax keyword typescriptPaymentProp contained shippingAddress shippingOption result
syntax cluster props add=typescriptPaymentProp
if exists("did_typescript_hilink") | HiLink typescriptPaymentProp Keyword
endif
syntax keyword typescriptPaymentEvent contained onshippingaddresschange onshippingoptionchange
if exists("did_typescript_hilink") | HiLink typescriptPaymentEvent Keyword
endif
syntax keyword typescriptPaymentResponseMethod contained complete nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptPaymentResponseMethod
if exists("did_typescript_hilink") | HiLink typescriptPaymentResponseMethod Keyword
endif
syntax keyword typescriptPaymentResponseProp contained details methodName payerEmail
syntax keyword typescriptPaymentResponseProp contained payerPhone shippingAddress
syntax keyword typescriptPaymentResponseProp contained shippingOption
syntax cluster props add=typescriptPaymentResponseProp
if exists("did_typescript_hilink") | HiLink typescriptPaymentResponseProp Keyword
endif
syntax keyword typescriptPaymentAddressProp contained addressLine careOf city country
syntax keyword typescriptPaymentAddressProp contained country dependentLocality languageCode
syntax keyword typescriptPaymentAddressProp contained organization phone postalCode
syntax keyword typescriptPaymentAddressProp contained recipient region sortingCode
syntax cluster props add=typescriptPaymentAddressProp
if exists("did_typescript_hilink") | HiLink typescriptPaymentAddressProp Keyword
endif
syntax keyword typescriptPaymentShippingOptionProp contained id label amount selected
syntax cluster props add=typescriptPaymentShippingOptionProp
if exists("did_typescript_hilink") | HiLink typescriptPaymentShippingOptionProp Keyword
endif

endif
