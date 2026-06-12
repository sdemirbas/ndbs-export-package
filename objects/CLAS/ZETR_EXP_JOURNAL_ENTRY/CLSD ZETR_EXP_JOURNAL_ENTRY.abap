class-pool .
*"* class pool for class ZETR_EXP_JOURNAL_ENTRY

*"* local type definitions
include ZETR_EXP_JOURNAL_ENTRY========ccdef.

*"* class ZETR_EXP_JOURNAL_ENTRY definition
*"* public declarations
  include ZETR_EXP_JOURNAL_ENTRY========cu.
*"* protected declarations
  include ZETR_EXP_JOURNAL_ENTRY========co.
*"* private declarations
  include ZETR_EXP_JOURNAL_ENTRY========ci.
endclass. "ZETR_EXP_JOURNAL_ENTRY definition

*"* macro definitions
include ZETR_EXP_JOURNAL_ENTRY========ccmac.
*"* local class implementation
include ZETR_EXP_JOURNAL_ENTRY========ccimp.

*"* test class
include ZETR_EXP_JOURNAL_ENTRY========ccau.

class ZETR_EXP_JOURNAL_ENTRY implementation.
*"* method's implementations
  include methods.
endclass. "ZETR_EXP_JOURNAL_ENTRY implementation
