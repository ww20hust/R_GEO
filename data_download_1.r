###########################################
# GEO accession : GSE42872
# Platforms     : GPL6244
# BioProject    : PRJNA183688
##########################################

#####数据下载#####
if(!require(GEOquery)) BiocManager::install("GEOquery") # 安装包
# package.version("GEOquery") # 查看版本
packageVersion()# 查看版本
help(package = "GEOquery") # 查看GEOquery中的函数
library(GEOquery) # 加载包
library(tidyverse)
search() # 查看已加载R包
gset <- getGEO('GSE42872',destdir = ".",
               AnnotGPL = F,getGPL = F)#下载GSE数据
save(gset,file = 'GSE42872.gset.Rdata')
# 读入表达矩阵，这里提供两种方法
exprset <- data.frame(exprs(gset[[1]])) # 推荐
exprset <- read.table(file = 'GSE42872_series_matrix.txt.gz',
                      sep = '\t',
                      header = T,
                      quote = '',
                      fill = T, 
                      comment.char = "!",
                      check.names = T) #读取表达数据
rownames(exprset) = exprset[,1] #将第一列作为行名
exprset <- exprset[,-1] #去掉第一列
names(exprset) <- names(exprset) %>% substr(3,nchar(names(exprset))-1) # 更改列名
