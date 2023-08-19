#####ID转换#####
ex # 查看芯片平台，”GPL6244“
BiocManager::install("hugene10sttranscriptcluster.db")
library(hugene10sttranscriptcluster.db)
ls("package:hugene10sttranscriptcluster.db") # 查看包中的数据
symbol <- toTable(hugene10sttranscriptclusterSYMBOL) # 加载探针id和symbol的对应关系
symbol$symbol %>% table() %>% table() %>% barplot(main = "筛选之前") # 查看探针和基因ID之间的对应关系

exprset.probe <- transform(exprset,probe_id = rownames(exprset)) 
exprset.symbol <- merge(exprset.probe,symbol,by = 'probe_id') # merge函数合并，初次筛选
exprset.symbol <- exprset.symbol[,c(8,2:7)]
exprset.symbol <- mutate(exprset.symbol,mean = rowMeans(exprset.symbol[2:7])) 
exprset.symbol <- exprset.symbol %>% arrange(mean) %>% 
  distinct(symbol,.keep_all = T) %>% select(symbol:GSM1052620) # 依据symbol分组，依据mean排序，，之后再删除重复symbol
dim(exprset.symbol) # 查看数据维度
exprset.symbol$symbol %>% table() %>% table() %>% plot(main = "筛选之后") # 查看是否还有重复的symbol
