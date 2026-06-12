class-pool .
*"* class pool for class ZCL_ETR_EXPORT_PROCESS

*"* local type definitions
include ZCL_ETR_EXPORT_PROCESS========ccdef.

*"* class ZCL_ETR_EXPORT_PROCESS definition
*"* public declarations
  include ZCL_ETR_EXPORT_PROCESS========cu.
*"* protected declarations
  include ZCL_ETR_EXPORT_PROCESS========co.
*"* private declarations
  include ZCL_ETR_EXPORT_PROCESS========ci.
endclass. "ZCL_ETR_EXPORT_PROCESS definition

*"* macro definitions
include ZCL_ETR_EXPORT_PROCESS========ccmac.
*"* local class implementation
include ZCL_ETR_EXPORT_PROCESS========ccimp.

*"* test class
include ZCL_ETR_EXPORT_PROCESS========ccau.

class ZCL_ETR_EXPORT_PROCESS implementation.
*"* method's implementations
  include methods.
endclass. "ZCL_ETR_EXPORT_PROCESS implementation
