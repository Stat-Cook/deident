% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/encrypter.R
\name{Encrypter}
\alias{Encrypter}
\title{Deidentifier class for applying 'encryption' transform}
\arguments{
\item{hash_key}{An alpha numeric key for use in encryption}

\item{seed}{An alpha numeric key which is concatenated to
minimize brute force attacks}

\item{keys}{Vector of values to be processed}

\item{...}{Values to be concatenated to keys}
}
\value{
\code{Encrypter}
Apply blur to a vector of values
}
\description{
Create new Encrypter object

Convert \code{self} to a list.
}
\details{
'Encrypting' refers to the cryptographic hashing  of data e.g. md5
checksum.  Encryption is more powerful if a random hash and seed are
supplied and kept secret.
}
\section{Fields}{

\describe{
\item{\code{hash_key}}{Alpha-numeric secret key for encryption}

\item{\code{seed}}{String for concatenation to raw value}
}}

