#####数据质量检查#####
head(exprset)
library(ggplot2)
library(dplyr)
library(reshape2)
ex = gset[[1]] # 实验相关信息
ph = pData(ex) # 每个样本的详细信息，包括了实验分组，芯片平台等
exprset_long <- melt(exprset) # 宽数据转长数据
# 从ph中可以看到实验分组信息
exprset_long$group <- rep(c("treat","control"),each = 3*nrow(exprset))
# {}代表创建了一个新环境，可以减少中间变量的产生
# 下面的代码依次产生了三幅图形
exprset_long %>% {
  p <- ggplot(.,aes(variable,value,fill = group))
  p1 <- p+ geom_boxplot()+ 
        theme(axis.text.x = element_text(angle = 30,vjust = 0.6),
          axis.title = element_blank())
  p2 <- p+ geom_violin()+
        theme_bw()+
        theme(axis.text.x = element_text(angle = 30,vjust = 0.6),
          axis.title = element_blank())
  p3 <- ggplot(.,aes(value,col=variable)) +geom_density(lwd = 1)+
        facet_wrap(~group,nrow = 2)+ 
        theme_test()+
        theme(axis.title = element_blank())
  print(p1) # 这里如果只输入p1，则图形不会显示
  print(p2)
  print(p3)
  # 依次产生箱线图，小提琴图和密度图
}
