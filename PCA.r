#####PCA#####
library(ggpubr)
pca.info <- prcomp(exprset.symbol)
summary(pca.info)
pca.data <- data.frame(sample = rownames(pca.info$rotation),
                       Type = colnames(exprset.symbol),
                       pca.info$rotation)
## 绘制PCA散点图
ggscatter(pca.data,x = "PC1",y = "PC2",
          color = "Type",
          size = 2
)+
  theme_bw()+
  ggtitle("PAC分析")+
  theme(plot.title = element_text(hjust = 0.5))

#####hclust聚类#####
exprset.symbol %>% t() %>% 
  dist() %>% hclust() %>% 
  plclust()/plot()

