\name{dbquery}
\alias{dbquery}
\title{Function for querying NEO4J DB}
\description{Takes query which gives table type output}
\usage{dbquery(query, params = FALSE, cypherurl)}
\arguments{
  \item{query}{Cypher Query, rmbr to escape double quotes if any}
  \item{params}{a list object. If no parameters, let params = False.}
  \item{cypherurl}{
}
}



\author{Wesley Chin Lui GOI}




\examples{

output.df <- dbquery(
    query = "START ko=node:koid('ko:\"ko:K00020\"') return ko.ko,ko.definition",
    params = FALSE, 
    cypherurl = "metamaps.scelse.nus.edu.sg:7474/db/data/cypher")
}
