% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/base_deident.R
\name{BaseDeident}
\alias{BaseDeident}
\title{Base class for all De-identifier classes}
\arguments{
\item{method}{New function to be used as the method.}

\item{location}{File path to save to.}

\item{keys}{Vector of values to be processed}

\item{force}{Perform transformation on all variables even if some given
are not in the data.}

\item{grouped_data}{a 'grouped_df' object}

\item{data}{A data frame to be manipulated}

\item{grp_cols}{Vector of variables in 'data' to group on.}

\item{mutate_cols}{Vector of variables in 'data' to transform.}

\item{type}{character vector describing the object.  Defaults to class.}

\item{...}{Options to check exist}
}
\description{
Create new Deidentifier object

Setter for 'method' field

Save 'Deidentifier' to serialized object.

Apply 'method' to a vector of values

Apply 'method' to variables in a data frame

Apply 'mutate' method to an aggregated data frame.

Aggregate a data frame and apply 'mutate' to each.

Convert \code{self} to a list

String representation of \code{self}

Check if parameters are in allowed fields
}
\section{Fields}{

\describe{
\item{\code{method}}{Function to call for data transform.}
}}

