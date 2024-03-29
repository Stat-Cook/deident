% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/grouped_shuffler.R
\name{GroupedShuffler}
\alias{GroupedShuffler}
\title{GroupedShuffler class for applying 'shuffling' transform with data
  aggregated}
\description{
GroupedShuffler class for applying 'shuffling' transform with data
  aggregated

GroupedShuffler class for applying 'shuffling' transform with data
  aggregated
}
\section{Super classes}{
\code{\link[deident:BaseDeident]{deident::BaseDeident}} -> \code{\link[deident:Shuffler]{deident::Shuffler}} -> \code{GroupedShuffler}
}
\section{Public fields}{
\if{html}{\out{<div class="r6-fields">}}
\describe{
\item{\code{group_on}}{Symbolic representation of grouping varaibles}

\item{\code{limit}}{Minimum number of rows required to shuffle data
Create new GroupedShuffler object}
}
\if{html}{\out{</div>}}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-GroupedShuffler-new}{\code{GroupedShuffler$new()}}
\item \href{#method-GroupedShuffler-mutate}{\code{GroupedShuffler$mutate()}}
\item \href{#method-GroupedShuffler-serialize}{\code{GroupedShuffler$serialize()}}
\item \href{#method-GroupedShuffler-str}{\code{GroupedShuffler$str()}}
\item \href{#method-GroupedShuffler-clone}{\code{GroupedShuffler$clone()}}
}
}
\if{html}{\out{
<details><summary>Inherited methods</summary>
<ul>
<li><span class="pkg-link" data-pkg="deident" data-topic="BaseDeident" data-id="group_and_mutate"><a href='../../deident/html/BaseDeident.html#method-BaseDeident-group_and_mutate'><code>deident::BaseDeident$group_and_mutate()</code></a></span></li>
<li><span class="pkg-link" data-pkg="deident" data-topic="BaseDeident" data-id="group_mutate"><a href='../../deident/html/BaseDeident.html#method-BaseDeident-group_mutate'><code>deident::BaseDeident$group_mutate()</code></a></span></li>
<li><span class="pkg-link" data-pkg="deident" data-topic="BaseDeident" data-id="persist"><a href='../../deident/html/BaseDeident.html#method-BaseDeident-persist'><code>deident::BaseDeident$persist()</code></a></span></li>
<li><span class="pkg-link" data-pkg="deident" data-topic="BaseDeident" data-id="set_method"><a href='../../deident/html/BaseDeident.html#method-BaseDeident-set_method'><code>deident::BaseDeident$set_method()</code></a></span></li>
<li><span class="pkg-link" data-pkg="deident" data-topic="Shuffler" data-id="set_limit"><a href='../../deident/html/Shuffler.html#method-Shuffler-set_limit'><code>deident::Shuffler$set_limit()</code></a></span></li>
<li><span class="pkg-link" data-pkg="deident" data-topic="Shuffler" data-id="transform"><a href='../../deident/html/Shuffler.html#method-Shuffler-transform'><code>deident::Shuffler$transform()</code></a></span></li>
</ul>
</details>
}}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-GroupedShuffler-new"></a>}}
\if{latex}{\out{\hypertarget{method-GroupedShuffler-new}{}}}
\subsection{Method \code{new()}}{
'Shuffling' refers to the a random sampling of a variable without
replacement e.g. [A, B, C] becoming [B, A, C] but not [A, A, B].  "Grouped
shuffling" refers to aggregating the data by another feature before appling
the shuffling process.  Grouped shuffling will preserve aggregate level
metrics (e.g. mean, median, mode) but removes ordinal properties
i.e. correlations and auto-correlations
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{GroupedShuffler$new(..., limit = 0)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{...}}{[optional] The columns of the to-be supplied data set to
aggregate on.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
`Blurer`
Aggregate a data frame and apply 'mutate' to each.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-GroupedShuffler-mutate"></a>}}
\if{latex}{\out{\hypertarget{method-GroupedShuffler-mutate}{}}}
\subsection{Method \code{mutate()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{GroupedShuffler$mutate(data, ...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{data}}{A data frame to be manipulated}

\item{\code{...}}{Vector of variables in 'data' to transform.}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-GroupedShuffler-serialize"></a>}}
\if{latex}{\out{\hypertarget{method-GroupedShuffler-serialize}{}}}
\subsection{Method \code{serialize()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{GroupedShuffler$serialize()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-GroupedShuffler-str"></a>}}
\if{latex}{\out{\hypertarget{method-GroupedShuffler-str}{}}}
\subsection{Method \code{str()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{GroupedShuffler$str(...)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-GroupedShuffler-clone"></a>}}
\if{latex}{\out{\hypertarget{method-GroupedShuffler-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{GroupedShuffler$clone(deep = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{deep}}{Whether to make a deep clone.}
}
\if{html}{\out{</div>}}
}
}
}
