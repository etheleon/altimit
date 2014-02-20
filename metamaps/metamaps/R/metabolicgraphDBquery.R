grepgraph<-structure(function(#Generates metabolic graph as a IGRAPH object from input set of KOs
###Takes in a vector list of KO ids and generates a metabolic graph as a igraph object
kos, ##<< this will take the input KOs 
graphserver ##<< The address of the graph database
){
##author<< Wesley Goi
#Processing
#1. Cypher Queries 
query_cpd2ko="START ko=node:koid(ko={koid}) OPTIONAL MATCH ko<--(cpd:`cpd`) RETURN cpd.cpd,ko.ko, cpd.name, ko.definition"
query_ko2cpd="START ko=node:koid(ko={koid}) OPTIONAL MATCH ko-->(cpd:`cpd`) RETURN ko.ko,cpd.cpd, ko.definition,cpd.name"

#2. The server address
cypherurl=sprintf("http://%s/db/data/cypher", graphserver)

#3.Edgelist And Vertices
fulldata=do.call(rbind,lapply(c(query_cpd2ko, query_ko2cpd), function(query) { 
do.call(rbind,lapply(paste("ko:", gsub("ko:","",kos), sep=""), function(ko){		#Edits strings
post=toJSON(
	    list(
		query=query,
		params=list(koid=ko)
		)
	    )
result=fromJSON(
	getURL(cypherurl, 
	customrequest='POST', 
	httpheader=c('Content-Type'='application/json'), 
	postfields=post
	))
if(length(result$data) > 0){
do.call(rbind,lapply(result$data, function(x) matrix(x,ncol=4) ))
}
}))
}))

vertex.data=setNames(as.data.frame(unique(rbind(fulldata[,c(1,3)],fulldata[,c(2,4)]))), c("Vertex","Definition"))
g=simplify(graph.data.frame(d=unique(fulldata[,1:2]),vertices=vertex.data))
##<< Description 
##Takes in KO and outputs the metabolic graph with 
}, ex=function(x) { 
    data(top500kos)
    mb_graph<-grepgraph(top500kos, 'http://metamaps.scelse.nus.edu.sg:7474')
})
