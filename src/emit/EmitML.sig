signature EmitML = 
sig
  include Abbrev
  type tyvar = Type.tyvar

  val pseudo_constructors      : thm list ref
  val reshape_thm_hook         : (thm -> thm) ref
  val curried_const_equiv_tupled_var 
    : term * int -> thm (* side effects pseudo_constructors *)

  datatype side = LEFT | RIGHT

  val pp_type_as_ML     : ppstream -> hol_type -> unit
  val pp_term_as_ML     : string list -> side -> ppstream -> term -> unit
  val pp_defn_as_ML     : string list -> ppstream -> term -> unit
  val pp_datatype_as_ML : ppstream -> tyvar list * ParseDatatype.AST list -> unit

  datatype elem = DEFN of thm
                | DEFN_NOSIG of thm
                | DATATYPE of hol_type quotation
                | EQDATATYPE of tyvar list * hol_type quotation
                | ABSDATATYPE of tyvar list * hol_type quotation
                | OPEN of string list
                | MLSIG of string
                | MLSTRUCT of string

  val MLSIGSTRUCT      : string list -> elem list

  val sigSuffix        : string ref 
  val structSuffix     : string ref 
  val sigCamlSuffix    : string ref 
  val structCamlSuffix : string ref 

  val emitML   : string -> string * elem list -> unit
  val emitCAML : string -> string * elem list -> unit

  val eSML     : string -> elem list -> unit
  val eCAML    : string -> elem list -> unit
end
