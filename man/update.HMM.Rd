% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/update.R
\name{update.HMM}
\alias{update.HMM}
\title{Update a model to a new model by changing one formula}
\usage{
\method{update}{HMM}(mod, type, i, j, change, fit = TRUE, silent = FALSE)
}
\arguments{
\item{mod}{a HMM model object}

\item{type}{character string for the part of the model that is updated
(either "hid" or "obs")}

\item{i}{if type="hid" then i is the row of the formula containing the change
if type="obs" then i is the observation variable name}

\item{j}{if type="hid" then j is the column of the formula containing the change
if type="obs" then j is the parameter whose formula is to be changed}

\item{change}{the change to make to the formula, see ?update.formula for details}

\item{fit}{if FALSE then change is made but model is not re-fit}

\item{silent}{if TRUE then no model fitting output is given}
}
\description{
Update a model to a new model by changing one formula
}
