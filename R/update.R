
#' Update a model to a new model by changing one formula
#' 
#' @param mod a HMM model object 
#' @param type character string for the part of the model that is updated
#' (either "hid" or "obs") 
#' @param i if type="hid" then i is the row of the formula containing the change
#'          if type="obs" then i is the observation variable name
#' @param j if type="hid" then j is the column of the formula containing the change
#'          if type="obs" then j is the parameter whose formula is to be changed 
#' @param change the change to make to the formula, see ?update.formula for details
#' @param fit if FALSE then change is made but model is not re-fit
#' @param silent if TRUE then no model fitting output is given 
#' 
#' @export
update.HMM <- function(mod, type, i, j, change, fit = TRUE, silent = FALSE) {
  
  # make sure data has state column added back in 
  dat <- mod$obs()$data() 
  if (!all(is.na(mod$obs()$known_states(mat = FALSE)))) {
    dat$state <- mod$obs()$known_states(mat = FALSE)
  }
  
  if (type == "hid") {
    # copy model components 
    new_obs <- mod$obs()$clone()
    copy_hid <- mod$hid()$clone()
    # extract current formula 
    new_formula <- copy_hid$formula()
    # update relevant formula 
    new_formula[i, j] <- as_character_formula(update(as.formula(new_formula[i, j]), change))
    # create new hidden sub-model component 
    new_hid <- MarkovChain$new(n_states = mod$hid()$nstates(), 
                               formula = new_formula, 
                               data = dat, 
                               stationary = mod$hid()$stationary()) 
  } else if (type == "obs") {
    # copy model components 
    copy_obs <- mod$obs()$clone()
    new_hid <- mod$hid()$clone()
    # get formulas 
    forms <- copy_obs$formulas(raw = TRUE)
    # make change 
    forms[[i]][[j]] <- update(forms[[i]][[j]], change)
    # create new obs 
    new_obs <- Observation$new(data = dat, 
                               dists = copy_obs$dists(), 
                               n_states = copy_obs$nstates(), 
                               par = copy_obs$inipar(), 
                               formulas = forms)
  }
  # create new HMM object 
  new_mod <- HMM$new(obs = new_obs, hid = new_hid, init = mod, 
                     fixpar = mod$fixpar())
  # fit new model 
  if(fit) new_mod$fit(silent = silent) 
  # return fitted model 
  return(new_mod)
}
