library(tidyverse)
library(tidytext)
library(ggraph)
library(ggridges)
library(pdftools)
library(forcats)
library(reshape2)
library(tidyr)
library(igraph)
library(widyr)
library(viridis)
library(wordcloud)
library(topicmodels)
library(forecast)
library(qdap)
library(lubridate)
library(chron)

## Ata do Copom

copom_links<- c("C:/Users/marcu/Desktop/Arquivos/P?s-Gradua??o/Doutorado/Tese/Artigo1/cp_2000_03.pdf",
                "C:/Users/marcu/Desktop/Arquivos/P?s-Gradua??o/Doutorado/Tese/Artigo1/cp_2000_06.pdf",
                "C:/Users/marcu/Desktop/Arquivos/P?s-Gradua??o/Doutorado/Tese/Artigo1/cp_2000_09.pdf",
                "C:/Users/marcu/Desktop/Arquivos/P?s-Gradua??o/Doutorado/Tese/Artigo1/cp_2000_12.pdf",
                "C:/Users/marcu/Desktop/Arquivos/P?s-Gradua??o/Doutorado/Tese/Artigo1/cp_2001_03.pdf",
                "C:/Users/marcu/Desktop/Arquivos/P?s-Gradua??o/Doutorado/Tese/Artigo1/cp_2001_06.pdf",
                "C:/Users/marcu/Desktop/Arquivos/P?s-Gradua??o/Doutorado/Tese/Artigo1/cp_2001_09.pdf",
                "C:/Users/marcu/Desktop/Arquivos/P?s-Gradua??o/Doutorado/Tese/Artigo1/cp_2001_12.pdf",
                "C:/Users/marcu/Desktop/Arquivos/P?s-Gradua??o/Doutorado/Tese/Artigo1/cp_2002_03.pdf",
                "C:/Users/marcu/Desktop/Arquivos/P?s-Gradua??o/Doutorado/Tese/Artigo1/cp_2002_06.pdf",
                "C:/Users/marcu/Desktop/Arquivos/P?s-Gradua??o/Doutorado/Tese/Artigo1/cp_2002_09.pdf",
                "C:/Users/marcu/Desktop/Arquivos/P?s-Gradua??o/Doutorado/Tese/Artigo1/cp_2002_12.pdf",
                "C:/Users/marcu/Desktop/Arquivos/P?s-Gradua??o/Doutorado/Tese/Artigo1/cp_2003_03.pdf",
                "C:/Users/marcu/Desktop/Arquivos/P?s-Gradua??o/Doutorado/Tese/Artigo1/cp_2003_06.pdf",
                "C:/Users/marcu/Desktop/Arquivos/P?s-Gradua??o/Doutorado/Tese/Artigo1/cp_2003_09.pdf",
                "C:/Users/marcu/Desktop/Arquivos/P?s-Gradua??o/Doutorado/Tese/Artigo1/cp_2003_12.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN200094-COPOM20040330-94th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN200097-COPOM20040625-97th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN200100-COPOM20040930-100th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2004103-COPOM20041231-103rd%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2005106-COPOM20050328-106th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2005109-COPOM20050630-109th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2005112-COPOM20050923-112th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2005115-COPOM20051223-115th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2006116-COPOM20060130-116th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2006117-COPOM20060328-117th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2006118-COPOM20060428-118th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2006119-COPOM20060531-119th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2006120-COPOM20060731-120th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2006121-COPOM20060831-121st%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2006122-COPOM20061030-122nd%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2006123-COPOM20061130-123rd%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2007124-COPOM20070131-124th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2007125-COPOM20070331-125th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2007126-COPOM20070430-126th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2007127-COPOM20070629-127th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2007128-COPOM20070731-128th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2007129-COPOM20070929-129th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2007130-COPOM20071031-130th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2007131st-COPOM20071231-131st%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2008132-COPOM20080131-132nd%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2008133-COPOM20080331-133rd%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2008134-COPOM20080430-134th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/min2008135th-COPOM20080630-135th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2008136TH-COPOM20080731-136th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2008137TH-COPOM20080930-137th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2008138-COPOM20081130-138th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2008139TH-COPOM20081231-139th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2009140TH-COPOM20090131-140th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2009141ST-COPOM20090331-141st%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2009142ND-COPOM20090529-142nd%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2009143RD-COPOM20090630-143rd%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2009144TH-COPOM20090731-144th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2009145th-COPOM20090930-145th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2009146th-COPOM20091031-146th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2009147th-COPOM20091231-147thCopom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2010148th-COPOM20090131-148th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2010149th-COPOM20090331-149th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2010150th-COPOM20090430-150th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2010151st-COPOM20100630-151st%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2010152nd-COPOM20100731-152nd%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2010153rd-COPOM20100930-153rd%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2010154th-COPOM20101031-154th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2010155th-COPOM20101227-155th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2011156th-COPOM20110131-156th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2011157th-COPOM20110331-157th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2011158th-COPOM20110429-158th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2011159th-COPOM20110621-159th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2011160th-COPOM20110805-160th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2011161st-COPOM20110831-161st%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2011162nd-COPOM20111031-162nd%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2011163rd-COPOM20111130-163rd%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2012164th-COPOM20120131-164th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2012165th-COPOM20120323-165th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2012166th-COPOM20120430-166th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2012167th-COPOM20120531-167th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2012168th-COPOM20120726-168th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2012169th-COPOM20120831-169th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2012170th-COPOM20121025-170th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2012171st-COPOM20121212-171st%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2013172nd-COPOM20130201-172nd%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2013173rd-COPOM20130322-173rd%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2013174th-COPOM20130430-174th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2013175th-COPOM20130614-175th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2013176th-COPOM20130726-176th%20Copom%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2013177th-COPOM20130831-177th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2013178th-COPOM20131023-178th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2013179th-COPOM20131213-179th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2014180-COPOM20140131-180th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2014181st-COPOM20140313-181st_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2014182nd-COPOM20140415-182nd_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2014183rd-COPOM20140613-183rd_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2014184th-COPOM20140730-184th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2014185th-COPOM20140916-185th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2014186th-COPOM20141112-186th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2014187th-COPOM20141217-187th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2015188th-COPOM20150131-188th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2015189th-COPOM20150319-189th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2015190th-COPOM20150513-190th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2015191st-COPOM20150617-191st_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2015192nd-COPOM20150813-192nd_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2015193rd-COPOM20150916-193rd_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2015194th-COPOM20151105-194th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2015195th-COPOM20151209-195th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2016196th-COPOM20160203-196th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2016197th-COPOM20160318-197th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2016198th-COPOM20160510-198th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2016199th-COPOM20160621-199th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2016200th-COPOM20160801-200th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2016201st-COPOM20160831-201st_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2016202nd-COPOM20161025-202nd_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2016203rd-COPOM20161206-203rd_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2017204th-COPOM20170117-204th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2017205th-COPOM20170302-205th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2017206th-COPOM20170418-206th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2017207th-COPOM20170606-207th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2017208th-COPOM20170801-208th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2017209th-COPOM20170912-209th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2017210-COPOM20171031-210th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2017211th-COPOM20171205-211th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2018212th-COPOM20180206-212th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MIN2018213th-COPOM20180320-213th_Copom_Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MINUTES214-min20180516214.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MINUTES215-min20180620215.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MINUTES216-min20180801216.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MINUTES217-min20180919217.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MINUTES218-min20181031218.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MINUTES219-min20181212219.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MINUTES220-min20190206220.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MINUTES221-min20190320221.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MINUTES222-min20190508222.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/min20190619223.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/min20190731224.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/min20190918225.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MINUTES%20226.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MINUTES227-min20191211227.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/Copom%20Minutes%20228.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/Copom%20229%20Minutes.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/Copom%20Minutes%20230.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/Copom%20Minutes%20231.pdf",
                "https://www.bcb.gov.br/content/copom/copomminutes/MINUTES%20232.pdf",
                "C:/Users/marcu/Desktop/Arquivos/P?s-Gradua??o/Doutorado/Tese/Artigo1/233.pdf",
                "C:/Users/marcu/Desktop/Arquivos/P?s-Gradua??o/Doutorado/Tese/Artigo1/234.pdf",
                "C:/Users/marcu/Desktop/Arquivos/P?s-Gradua??o/Doutorado/Tese/Artigo1/235.pdf",
                "C:/Users/marcu/Desktop/Arquivos/P?s-Gradua??o/Doutorado/Tese/Artigo1/236.pdf",
                "C:/Users/marcu/Desktop/Arquivos/P?s-Gradua??o/Doutorado/Tese/Artigo1/237.pdf",
                "C:/Users/marcu/Desktop/Arquivos/P?s-Gradua??o/Doutorado/Tese/Artigo1/238.pdf",
                "C:/Users/marcu/Desktop/Arquivos/P?s-Gradua??o/Doutorado/Tese/Artigo1/239.pdf",
                "C:/Users/marcu/Desktop/Arquivos/P?s-Gradua??o/Doutorado/Tese/Artigo1/240.pdf",
                "C:/Users/marcu/Desktop/Arquivos/P?s-Gradua??o/Doutorado/Tese/Artigo1/241.pdf",
                "C:/Users/marcu/Desktop/Arquivos/P?s-Gradua??o/Doutorado/Tese/Artigo1/233.pdf")


## Relat?rio da Infla??o


copom_links<- c("https://www.bcb.gov.br/content/ri/inflationreport/200503/INFREP200503-ri200503I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/200506/INFREP200506-ri200506I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/200509/INFREP200509-ri200509I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/200512/INFREP200512-ri200512I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/200603/INFREP200603-ri200603I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/200606/INFREP200606-ri200606I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/200609/INFREP200609-ri200609I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/200612/INFREP200612-ri200612I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/200703/INFREP200703-ri200703I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/200706/INFREP200706-ri200706I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/200709/INFREP200709-ri200709I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/200712/INFREP200712-ri200712I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/200803/INFREP200803-ri200803I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/200806/INFREP200806-ri200806I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/200809/INFREP200809-ri200809I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/200812/INFREP200812-ri200812I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/200903/INFREP200903-ri200903I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/200906/INFREP200906-ri200906I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/200909/INFREP200909-ri200909I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/200912/INFREP200912-ri200912I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201003/INFREP201003-ri201003I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201006/INFREP201006-ri201006I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201009/INFREP201009-ri201009I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201012/INFREP201012-ri201012I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201103/INFREP201103-ri201103I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201106/INFREP201106-ri201106I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201109/ri201109i.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201112/ri201112i.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201203/INFREP201203-ri201203sei.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201206/INFREP201206-ri201206sei.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201209/INFREP201209-ri201209sei.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201212/INFREP201212-ri201212sei.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201303/INFREP201303-ri201303sei.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201306/INFREP201306-ri201306sei.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201309/INFREP201309-ri201309sei.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201312/INFREP201312-ri201312sei.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201403/INFREP201403-ri201403sei.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201406/INFREP201406-ri201406sei.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201409/INFREP201409-ri201409sei.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201412/INFREP201412-ri201412sei.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201503/INFREP201503-ri201503sei.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201506/INFREP201506-ri201506sei.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201509/INFREP201509-ri201509sei.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201512/INFREP201512-ri201512sei.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201603/INFREP201603-ri201603sei.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201606/ri201606i.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201609/INFREP201609-ri201609I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201612/INFREP201612-ri201612I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201703/INFREP201703-ri201703I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201706/INFREP201706-ri201706I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201709/INFREP201709-ri201709I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201712/INFREP201712-ri201712I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201803/INFREP201803-ri201803I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201806/INFREP201806-ri201806I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201809/INFREP201809-ri201809I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201812/INFREP201812-ri201812I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201903/INFREP201903-ri201903I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201906/ri201906I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201909/ri201909I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/201912/ri201912I.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/202003/ri202003i.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/202006/ri202006i.pdf",
                "https://www.bcb.gov.br/content/ri/inflationreport/202009/ri202009i.pdf")



#####

#date stamps

dates<- as.Date(seq.Date(from = as.Date("2000/03/1"), to = as.Date("2037/09/1"), by = "quarter"))


# creating the data frame with the words from the reports

df_copom <- data.frame(report=dates,stringsAsFactors = FALSE) %>%
  
  mutate(text= map(copom_links,pdf_text)) %>% 
  
  unnest(text) %>% 
  
  group_by(report) %>% mutate(page=row_number()) %>%
  
  ungroup() %>%
  
  mutate(text=strsplit(text,"\r")) %>% 
  
  unnest(text) %>% 
  
  mutate(text=gsub("\n","",text)) %>%
  
  group_by(report) %>% 
  
  mutate(line=row_number()) %>% 
  
  ungroup() %>% 
  
  select(report,line,page,text)



# counting words

copom_words<- df_copom %>%
  
  unnest_tokens(word, text)%>%
  
  count(report, word, sort = TRUE)%>%
  
  ungroup()

total_words<- copom_words %>%
  
  group_by(report) %>%
  
  summarize(total = sum(n))

#spllting word counts

ggplot(data = total_words, aes( x = dates, y = total)) +
  
  geom_line( color = "blueviolet") + 
  
  geom_point( shape = 21, fill = "grey83", color ="red4", size = 3, stroke = 1.1) +
  
  scale_y_continuous( labels = scales::comma) +
  
  theme_ridges( font_family = "Roboto") +
  
  labs(x = "Year", y = "Number of Words", title = "Number of Words BACEN Inflation Report") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))


# merging stop words with some "useless" words on the reports

custom_stop_words <- 
  bind_rows(tibble(word = c(tolower(month.abb), "one","two","three","four","five","six",
                            "seven","eight","nine","ten","eleven","twelve","mam","ered",
                            "produc","ing","quar","ters","sug","quar",'fmam',"sug",
                            "cient","thirty","pter",
                            "pants","ter","ening","ances","www.bcb.gov.br",
                            "tion","fig","ure","figure","src"), 
                   lexicon = c("custom")), 
            stop_words)

custom_stop_words2 <- 
  bind_rows(tibble(word = c("debt",
                            "gross",
                            "crude",
                            "well",
                            "maturity",
                            "work",
                            "marginally",
                            "leverage"), 
                   lexicon = c("custom")), 
            custom_stop_words)


# words simple frequency


copom_text<- 
  
  df_copom%>%
  
  select(report,page,line,text) %>%
  unnest_tokens(word,text)

copom_text %>%
  
  mutate(word = gsub("[^A-Za-z ]","",word)) %>%
  
  filter(word!="") %>%
  
  anti_join(custom_stop_words) %>%
  
  group_by(report) %>%
  
  count(word, sort = TRUE) %>%
  
  mutate(rank = row_number()) %>%
  
  ungroup() %>%
  
  arrange(rank, report) %>%
  
  filter(rank < 10) %>%
  
  ggplot(aes(y=n, x = fct_reorder(word,n))) +
  
  geom_col(fill = "orange") +
  
  facet_wrap(~report, scales = "free", ncol = 5) +
  
  coord_flip() +
  
  theme_ridges(font_family = "Roboto", font_size = 10) +
  
  labs(x = "", y = "", title = "Frequent Words Inflation Reports",
       
       subtitle = "Clean Data"
       
  )


# words tf-idf frequency 

copom_text_v2<- 
  
  copom_text %>%
  
  mutate(word = gsub("[^A-Za-z ]","",word)) %>%
  
  filter(word!="") %>%
  
  count(report,word, sort = TRUE) %>%
  
  bind_tf_idf(word, report, n) %>%
  
  arrange(desc(tf_idf))

copom_text_v2 %>%
  
  anti_join(custom_stop_words, by = "word") %>%
  
  mutate(word = factor(word, levels = rev(unique(word)))) %>%
  
  group_by(report) %>%
  
  mutate(id = row_number()) %>%
  
  ungroup() %>%
  
  filter(id<10) %>%
  
  ggplot(aes(word, tf_idf, fill = report)) +
  
  geom_col(show.legend = FALSE) +
  
  labs( x = NULL, y = "tf-idf") +
  
  facet_wrap(~report, scales = "free", ncol = 5) +
  
  coord_flip() +
  
  
  theme_ridges(font_family = "Roboto", font_size = 10) +
  
  theme(axis.text.x = element_blank()) +
  
  labs(x = "", y = "tf-idf", title = "Words tf-idf")



# sentiment accross CBB reports


copom_sentiment<- 
  
  copom_text%>%
  
  anti_join(custom_stop_words2) %>%
  
  inner_join(get_sentiments("loughran")) %>%
  
  count(report, index = line %/%240, sentiment)%>%
  
  spread(sentiment,n, fill = 0) %>%
  
  mutate(sentiment = positive - negative)

ggplot(copom_sentiment, aes(index, sentiment, fill = sentiment >0)) +
  
  geom_col(show.legend = FALSE) +
  
  scale_fill_manual(values = c("red","blue4")) +
  
  facet_wrap(~report, ncol = 5, scales = "free_x") +
  
  theme_ridges(font_family = "Roboto") +
  
  labs(x= "index", y = "Sentiment", title  = "Sentiment Accross CBB Reports")


#sentiment on each CBB report

copom_sentiment_by_report<- 
  
  copom_text %>% 
  
  anti_join(custom_stop_words2) %>%
  
  inner_join(get_sentiments("bing")) %>%
  
  count(report, sentiment)%>%
  
  spread(sentiment, n, fill =0) %>%
  
  mutate(sentiment = positive - negative)

ggplot(copom_sentiment_by_report, aes(factor(dates), sentiment/(negative+positive), fill = sentiment>0)) +
  
  geom_col(show.legend = FALSE) + scale_fill_manual(values = c("red","blue4"))+
  
  theme_ridges(font_family = "Roboto", font_size = 10) +
  
  labs(x= "Reports", y = "Sentiment >0 good omens, <0 winter is comming", title  = "Sentiment CBB Inflation Reports")+
  
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))

