
# Constant values ---------------------------------------------------------

# Available types of designs
design_type <- c(
  "Full factorial" = "full_f", 
  "Fractional factorial 2-level" = "frac", 
  "Box-Behnken" = "bbd",
  "Central-Composite" = "ccd"
)

# Functions ---------------------------------------------------------------

# Full factorial designs
full_design <- function(nfactors = NULL, nlevels = NULL, replications = 1,
                        randomize = TRUE, blocks = 1) {
  if (blocks == 1) {
   DoE.base::fac.design(
      nfactors = nfactors,
      nlevels = nlevels,
      replications = replications,
      randomize = randomize,
    )
  } else {
    DoE.base::fac.design(
      nfactors = nfactors,
      nlevels = nlevels,
      replications = replications,
      randomize = randomize,
      blocks = blocks
    )
  }
}

# Fractional designs
frac_design <- function(nfactors = NULL, replications = 1,
                        resolution = NULL, ncenter = 0, randomize = TRUE) {
  FrF2::FrF2(
    nfactors = nfactors, 
    replications = replications,
    resolution = resolution,
    ncenter = ncenter, 
    randomize = randomize
  )
}

# Box-Behnken design
bb_design <- function(nfactors = NULL, ncenter = 4, randomize =TRUE) {
  rsm::bbd(
    k = nfactors,
    n0 = ncenter,
    randomize = randomize
  )
}

# Central-composite desing
cc_design <- function(nfactors = NULL, ncenter = 4, 
                      alpha = "orthogonal", randomize = TRUE) {
  rsm::ccd(
    basis = nfactors,
    n0 = ncenter,
    alpha = alpha,
    randomize = randomize,
    oneblock = TRUE
  )
}
