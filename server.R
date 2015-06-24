library(ggplot2)
library(png)
library(gridExtra)
library(gridBase)
library(shiny)
library(png)
library(gridBase)

load('NEWSTIM_WORKSPACE_FINAL.RData')
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  
   output$distPlot <- renderPlot({
     path.img='./KDEF34/'
     
     target_means=seq(-2,2,by=.5)
     target_sds=seq(.2,.8,by=.2)
     
#      input=data.frame(PLOT="stimuli",trialnum=1,bin=5,SD=0.6)
     thetrial=input$trialnum
     targsd=as.character(input$SD)

     #      print(paste0('thetrial',thetrial))
     #      print(paste0('binmean',binmean))
     #      print(paste0('targsd',targsd))     
          
if (input$bin!="all")
{
  binmean=target_means[as.numeric(input$bin)]
  
  tmp=subset(newstim,targsig==targsd & trial==thetrial & targmu==binmean)

  gg1=ggplot(tmp,aes(x=factor(stimnum),y=factor(targmu),col=faceID.true,fill=Srating.real.mean))+
    geom_tile()+
    scale_fill_gradient(low="blue",high="red")+
    guides(col=FALSE)+
    geom_text(aes(label=paste0(faceID.true,"\n",round(Srating.real.mean,2))))
  
  faces=tmp$face
  par(mfrow=c(1,10),mar=c(0,0,0,0))  
  for (j in 1:10)
  {      
    plot.new()
    img.name=paste0(faces[j],'.png')
    img=readPNG(paste0(path.img,img.name))    
    rasterImage(img,0,0,1,1)
  }
}

if (input$bin=="all")
{
  tmp=subset(newstim,targsig==targsd & trial==thetrial)
  gg1=ggplot(tmp,aes(x=factor(stimnum),y=factor(targmu),col=faceID.true,fill=Srating.real.mean))+
    geom_tile()+
    scale_fill_gradient(low="blue",high="red")+
    guides(col=FALSE)+
    geom_text(aes(label=paste0(faceID.true,"\n",round(Srating.real.mean,2))))

  gg2=ggplot(tmp,aes(x=Srating.real.mean,col=factor(targmu),fill=factor(targmu)))+
    geom_density(alpha=.6,size=2)+
    scale_colour_brewer(type = "qual",palette=3)

  gg3=ggplot(tmp,aes(x=factor(targmu),y=Srating.real.mean,fill=factor(targmu),col=factor(targmu)))+
    geom_boxplot(alpha=.6)+
    geom_point(position="jitter")
#     stat_summary(fun.dat='mean_sdl',geom="bar")+
#     stat_summary(fun.dat='mean_sdl',geom="errorbar")
     
  
  par(mfrow=c(9,10),mar=c(0,0,0,0))     
     for (i in 1:9)
        {
          binmean=target_means[i]
          faces=subset(tmp,targmu==binmean)$face
      
          for (j in 1:10)
           {      
             plot.new()
             img.name=paste0(faces[j],'.png')
             img=readPNG(paste0(path.img,img.name))    
             rasterImage(img,0,0,1,1)
           }

        }
}

if (input$PLOT=="figure")
{
  if (input$bin=="all")
  {
    grid.arrange(gg1,gg3,ncol=1)    
  }
  else
  {
    gg1
  }
}  
  


   })
})
