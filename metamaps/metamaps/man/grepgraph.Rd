\name{grepgraph}
\alias{grepgraph}
\title{Generates metabolic graph as a IGRAPH object from input set of KOs}
\description{Takes in a vector list of KO ids and generates a metabolic graph as a igraph object}
\usage{grepgraph(kos, graphserver)}
\arguments{
  \item{kos}{this will take the input KOs}
  \item{graphserver}{The address of the graph database}
}



\author{Wesley Goi
Wesley Chin Lui GOI}




\examples{
data(top500kos)
mb_graph<-grepgraph(top500kos, 'http://metamaps.scelse.nus.edu.sg:7474')
}
