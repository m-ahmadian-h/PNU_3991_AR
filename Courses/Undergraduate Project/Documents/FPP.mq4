//+------------------------------------------------------------------+
//|                                                      pattern.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.10"
#property strict
#property indicator_chart_window
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+


input double ab=0.786;
input double bc=0.886;
input double cd=1.618;
input double xd=1.27;
input double tolerans=0.15;
double arr[];
int arrb[];
double xT=0.0;
int OnInit()
  {
  
   if( IsTesting()){
     getChartXY();
     LabelCreate(0,"labelFFp",0,0,y_distance-40,0,"Menu not work in Tester!");
   } 
  for(int i=1;i<100;i++)
    {
     xT=i;
    }
//--- indicator buffers mapping
     ChartSetInteger(0,CHART_EVENT_MOUSE_MOVE,true);
//---
 but[0].creat("bt1",100,10,50,25,"Power1",0,true);but[0].set.setColor(but[0].pro,clrWhite,clrRed,clrRed);
 but[1].creat("bt2",151,10,50,25,"Power2",0,true);but[1].set.setColor(but[1].pro,clrWhite,clrRed,clrRed);
 but[2].creat("bt3",202,10,50,25,"Power3",0,true);but[2].set.setColor(but[2].pro,clrWhite,clrRed,clrRed);
 but[3].creat("bt4",253,10,50,25,"Power4",0,true);but[3].set.setColor(but[3].pro,clrWhite,clrRed,clrRed);

 but[4].creat("bt5",304,10,50,25,"Power6",0,true);but[4].set.setColor(but[4].pro,clrWhite,clrDarkGray,clrDarkGray);
 but[5].creat("bt6",355,10,50,25,"Power7",0,true);but[5].set.setColor(but[5].pro,clrWhite,clrDarkGray,clrDarkGray);
 but[6].creat("bt7",406,10,50,25,"Power8",0,true);but[6].set.setColor(but[6].pro,clrWhite,clrDarkGray,clrDarkGray);
 but[7].creat("bt8",457,10,50,25,"Power9",0,true);but[7].set.setColor(but[7].pro,clrWhite,clrDarkGray,clrDarkGray);

 but[8].creat("bt9",508,10,50,25,"Power11",0,true);but[8].set.setColor(but[8].pro,clrWhite,clrGreen,clrGreen);
 but[9].creat("bt10",559,10,50,25,"Power12",0,true);but[9].set.setColor(but[9].pro,clrWhite,clrGreen,clrGreen);
 but[10].creat("bt11",610,10,50,25,"Power13",0,true);but[10].set.setColor(but[10].pro,clrWhite,clrGreen,clrGreen);
 but[11].creat("bt12",661,10,50,25,"Power14",0,true);but[11].set.setColor(but[11].pro,clrWhite,clrGreen,clrGreen);
 
 but[13].creat("control",0,100,50,25,"show",0,false);but[13].set.setColor(but[13].pro,clrWhite,clrRosyBrown,clrGreen);
 but[12].creat("li",100,37,661-50,4,"",0,false);but[12].set.setColor(but[12].pro,clrDeepSkyBlue,clrDeepSkyBlue,clrDeepSkyBlue);
 
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
  long x_distance;
  long y_distance;
void getChartXY(){

  //--- set window size
  ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0,y_distance);
  ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0,x_distance);     
}
//+------------------------------------------------------------------+
int bar=0;
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
   if(Bars!=bar)
     {
      bar=Bars;
      checkT1(1,arr,arrb);
      checkT2(1,arr,arrb);
      checkT3(1,arr,arrb);
     }

//--- return value of prev_calculated for next call
   return(rates_total);
  }
  
  
bool shwoHidden=false;
void showHidden()
  {
//---
   if(shwoHidden)
     {
      shwoHidden=false;
      for(int i=0;i<ArraySize(but)-1;i++)
        {
         if(but[i].pro.delet==false)
           {
             but[i].set.showMove(but[i].pro);
           }
        }
     }else{
      shwoHidden=true;
      for(int i=0;i<ArraySize(but)-1;i++)
        {
         if(but[i].pro.delet==false)
           {
             but[i].set.hiddenMove(but[i].pro);
           }
             
     }
  }   
  }
  
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
  
   for(int i=0;i<ArraySize(but);i++)
     {
      if(but[i].pro.delet==false)
        {
         ObjectDelete(but[i].pro.name);
        }
     }
     
   for(int i=0;i<ArraySize(tris4);i++)
     {
      if(tris4[i].pro1.delet==false)
        {
         tris4[i].delet();
        }
     }    
     
   for(int i=0;i<ArraySize(tris4_1);i++)
     {
      if(tris4_1[i].pro1.delet==false)
        {
         tris4_1[i].delet();
        }
     } 
     
     
    for(int i=0;i<ArraySize(tris4_r);i++)
     {
      if(tris4_r[i].pro1.delet==false)
        {
         tris4_r[i].delet();
        }
     } 
         
  }
  
  
  //+------------------------------------------------------------------+
//|                                                      Object3.mqh |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict
//+------------------------------------------------------------------+
struct Object3{
int tmp;
struct Property{
   string name;
   int xd;int xdtmp;
   int yd;int ydtmp;
   int xs;int xstmp;
   int ys;int ystmp;
   int ybottom;
   string text;string texttmp;
   int fontSize;string font;
   
   color colorText;color colorBack;color colorBorder;
   color MouseOverColorText;color MouseOverColorBack;color MouseOverColorBorder;
   
   color colorTexttmp;color colorBacktmp;color colorBordertmp;
   color MouseOverColorTexttmp;color MouseOverColorBacktmp;color MouseOverColorBordertmp;
   
   bool enableMouseOver;bool delet;bool canMoveWithAll;bool canMoveSelf;
   int ekhMX;int ekhMY;
   double price1;
   double price2;
   double price3;
   datetime time1;
   datetime time2;
   datetime time3;
   
};
//---------------------------------------------------------------------------------
struct SetObject{
   int tmp;
   void setPosiXY(Property &pro,int xd,int yd){
       pro.xd=xd;pro.yd=yd;
       ObjectSetInteger(0,pro.name,OBJPROP_XDISTANCE,xd);
       ObjectSetInteger(0,pro.name,OBJPROP_YDISTANCE,yd);
   }
   //---\\
   void setsizeY(Property &pro,int ys){
       pro.ys=ys;ObjectSetInteger(0,pro.name,OBJPROP_YSIZE,pro.ys);
   }
   //---\\
   void setPosiY(Property &pro,int yd){
       pro.yd=yd;ObjectSetInteger(0,pro.name,OBJPROP_YDISTANCE,pro.yd);
   }
   //---\\
   void setsizeX(Property &pro,int xs){
       pro.xs=xs;ObjectSetInteger(0,pro.name,OBJPROP_XSIZE,pro.xs);
   }
   //---\\
   void setSizeXY(Property &pro,int xs,int ys){
      pro.xs=xs;pro.ys=ys;pro.ystmp=ys;pro.xstmp=xs;
      ObjectSetInteger(0,pro.name,OBJPROP_XSIZE,xs);
      ObjectSetInteger(0,pro.name,OBJPROP_YSIZE,ys);
   }
   //---\\
   void setText(Property &pro,string text="text",int fontSize=8,color colorText=clrWhite,string font="Tahoma Bold"){
      pro.text=text;pro.fontSize=fontSize;pro.colorText=colorText;pro.font=font;
      ObjectSetInteger(0,pro.name,OBJPROP_COLOR,colorText);
      ObjectSetString(0,pro.name,OBJPROP_TEXT,text);
      ObjectSetString(0,pro.name,OBJPROP_FONT,font);
      ObjectSetInteger(0,pro.name,OBJPROP_FONTSIZE,fontSize);
   }
   //---\\
   void setColorMouseOver(Property &pro,color MouseOverColorText,color MouseOverColorBack,color MouseOverColorBorder){
      pro.MouseOverColorText=MouseOverColorText;pro.MouseOverColorBack=MouseOverColorBack;pro.MouseOverColorBorder=MouseOverColorBorder; 
   }
   //---\\
   void setColorMouseOverDone(Property &pro){
      ObjectSetInteger(0,pro.name,OBJPROP_COLOR,pro.MouseOverColorText);
      ObjectSetInteger(0,pro.name,OBJPROP_BGCOLOR,pro.MouseOverColorBack);
      ObjectSetInteger(0,pro.name,OBJPROP_BORDER_COLOR,pro.MouseOverColorBorder);
      ObjectSetInteger(0,pro.name,OBJPROP_STATE,false);
   }
   //---\\
   void setColor(Property &pro,color ColorText,color ColorBack,color ColorBorder){
      pro.colorText=ColorText;pro.colorBack=ColorBack;pro.colorBorder=ColorBorder;
      ObjectSetInteger(0,pro.name,OBJPROP_COLOR,pro.colorText);
      ObjectSetInteger(0,pro.name,OBJPROP_BGCOLOR,pro.colorBack);
      ObjectSetInteger(0,pro.name,OBJPROP_BORDER_COLOR,pro.colorBorder);
      ObjectSetInteger(0,pro.name,OBJPROP_STATE,false);
   }
   //---\\
   void setColorMouseOverDoneNt(Property &pro){
      ObjectSetInteger(0,pro.name,OBJPROP_COLOR,pro.colorText);
      ObjectSetInteger(0,pro.name,OBJPROP_BGCOLOR,pro.colorBack);
      ObjectSetInteger(0,pro.name,OBJPROP_BORDER_COLOR,pro.colorBorder);
      ObjectSetInteger(0,pro.name,OBJPROP_STATE,false);
   }
   //---\\
   void setColorDef(Property &pro){
      pro.colorText=clrYellow;pro.colorBack=clrRed;pro.colorBorder=clrYellow;
      ObjectSetInteger(0,pro.name,OBJPROP_COLOR,pro.colorText);
      ObjectSetInteger(0,pro.name,OBJPROP_BGCOLOR,pro.colorBack);
      ObjectSetInteger(0,pro.name,OBJPROP_BORDER_COLOR,pro.colorBorder);
   }
   //---\\
   void setColorDefButton(Property &pro){
      pro.enableMouseOver=true;
      pro.MouseOverColorText=clrRed;pro.MouseOverColorBack=clrYellow;pro.MouseOverColorBorder=clrWhite;
   }
   //---\\
   void setTimePrice3(Property &pro,double price1,double price2,double price3,datetime time1,datetime time2,datetime time3){
      ObjectSetInteger(0,pro.name,OBJPROP_TIME1,time1);
      ObjectSetInteger(0,pro.name,OBJPROP_TIME2,time2);
      ObjectSetInteger(0,pro.name,OBJPROP_TIME3,time3);
      ObjectSetDouble(0,pro.name,OBJPROP_PRICE1,price1);
      ObjectSetDouble(0,pro.name,OBJPROP_PRICE2,price2);
      ObjectSetDouble(0,pro.name,OBJPROP_PRICE3,price3);
      pro.price1=price1;
      pro.price2=price2;
      pro.price3=price3;
      pro.time1=time1;
      pro.time2=time2;
      pro.time3=time3;
   }
   
   //---\\
   void setTimePrice2(Property &pro,double price1,double price2,datetime time1,datetime time2){
      ObjectSetInteger(0,pro.name,OBJPROP_TIME1,time1);
      ObjectSetInteger(0,pro.name,OBJPROP_TIME2,time2);
      ObjectSetDouble(0,pro.name,OBJPROP_PRICE1,price1);
      ObjectSetDouble(0,pro.name,OBJPROP_PRICE2,price2);
      pro.price1=price1;
      pro.price2=price2;
      pro.time1=time1;
      pro.time2=time2;
   }
   //---\\
   void setTimePrice1(Property &pro,double price1,datetime time1){
      ObjectSetInteger(0,pro.name,OBJPROP_TIME,time1);
      ObjectSetDouble(0,pro.name,OBJPROP_PRICE,price1);
      pro.price1=price1;
      pro.time1=time1;
   }   
   //---\\
   void hiddenColor(Property &pro){
      pro.colorBacktmp=pro.colorBack;
      pro.colorBordertmp=pro.colorBorder;
      pro.colorTexttmp=pro.colorText;
      
      pro.MouseOverColorBacktmp=pro.MouseOverColorBack;
      pro.MouseOverColorBordertmp=pro.MouseOverColorBorder;
      pro.MouseOverColorTexttmp=pro.MouseOverColorText;
      
      
      pro.colorBack=clrNONE;
      pro.colorBorder=clrNONE;
      pro.colorText=clrNONE;
      
      pro.MouseOverColorBack=clrNONE;
      pro.MouseOverColorBorder=clrNONE;
      pro.MouseOverColorText=clrNONE;
      
      ObjectSetInteger(0,pro.name,OBJPROP_COLOR,pro.colorText);
      ObjectSetInteger(0,pro.name,OBJPROP_BGCOLOR,pro.colorBack);
      ObjectSetInteger(0,pro.name,OBJPROP_BORDER_COLOR,pro.colorBorder);
      ObjectSetInteger(0,pro.name,OBJPROP_STATE,false);
 
   } 
   
   //---\\
   void hiddenMove(Property &pro){
      pro.xdtmp=ObjectGetInteger(0,pro.name,OBJPROP_XDISTANCE);
      pro.ydtmp=ObjectGetInteger(0,pro.name,OBJPROP_YDISTANCE);
      //--
      pro.yd=-1000;
      pro.xd=-1000;
      //--------------
      ObjectSetInteger(0,pro.name,OBJPROP_XDISTANCE,pro.xd);
      ObjectSetInteger(0,pro.name,OBJPROP_YDISTANCE,pro.yd);
   } 
   //---\\
   void showMove(Property &pro){
      pro.yd=pro.ydtmp;
      pro.xd=pro.xdtmp;
      //--------------
      ObjectSetInteger(0,pro.name,OBJPROP_XDISTANCE,pro.xd);
      ObjectSetInteger(0,pro.name,OBJPROP_YDISTANCE,pro.yd);
   } 
   
   
};
//---------------------------------------------------------------------------------
struct Mouse{
string nameObjectClick;
SetObject set;
long chartX;
long chartY;

//---\\
   void getChartXY(){
     long x_distance;
     long y_distance;
     //--- set window size
     ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0,y_distance);
     ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0,x_distance);     
     chartX=x_distance;
     chartY=y_distance;
     }
//---\\
   int getTop(Property &pro){return ObjectGetInteger(0,pro.name,OBJPROP_YDISTANCE);}
//---\\
   int getBottom(Property &pro){return getTop(pro)+ObjectGetInteger(0,pro.name,OBJPROP_YSIZE);}
//---\\
   int getLeft(Property &pro){return ObjectGetInteger(0,pro.name,OBJPROP_XDISTANCE);}
//---\\
   int getRight(Property &pro){return  getLeft(pro)+ObjectGetInteger(0,pro.name,OBJPROP_XSIZE);} 
//---\\
   void getEkhteleafMouseY(Property &pro,int lparam,int dparam){pro.ekhMY=(dparam-getTop(pro));} 
//---\\
   void getEkhteleafMouseX(Property &pro,int lparam,int dparam){pro.ekhMX=(lparam-getLeft(pro));}
//---\\
   bool checkMouseOver(Property &pro,int lparam,int dparam){
     if(!pro.enableMouseOver || pro.delet){return false;}
     int left=getLeft(pro);int righ=getRight(pro);
     int top=getTop(pro);int bottom=getBottom(pro);
     if(lparam>left && lparam<righ && dparam>top && dparam<bottom)
       {
         set.setColorMouseOverDone(pro);return true;
       }else{ set.setColorMouseOverDoneNt(pro);}
     return false;
   }
//---\\
   void moveByMouseX(Property &pro,int lparam=0,int dparam=0){
     if(checkCanMoveX(pro,lparam,dparam))
       {
          ObjectSetInteger(0,pro.name,OBJPROP_XDISTANCE,lparam-pro.ekhMX);
          pro.xd=lparam-pro.ekhMX;
       }
   }
//---\\
   void moveByMouseY(Property &pro,int lparam=0,int dparam=0){
     if(checkCanMoveY(pro,lparam,dparam))
       {
         ObjectSetInteger(0,pro.name,OBJPROP_YDISTANCE,dparam-pro.ekhMY);
         pro.yd=dparam-pro.ekhMY;
       }
   }
//---\\
   bool checkCanMoveY(Property &pro,int lparam=0,int dparam=0){
     if(pro.canMoveSelf==false || pro.delet){return false;}
     if(dparam-pro.ekhMY>0 && (dparam-pro.ekhMY)+pro.ys<chartY){return true;}
     return false;
   }
//---\\
   bool checkCanMoveX(Property &pro,int lparam=0,int dparam=0){
     if(pro.canMoveSelf==false || pro.delet){return false;}
     if(lparam-pro.ekhMX>0 && (lparam-pro.ekhMX)+pro.xs<chartX){return true;}
     return false;
   }
   
//---\\
   bool checkObjectCanMoveXY(Property &pro,int lparam=0,int dparam=0){
     getChartXY();
     if(checkCanMoveY(pro,lparam,dparam)==false || checkCanMoveX(pro,lparam,dparam)==false)
       {
        return false;
       }
      return true;
   }
//---\\

//---\\

   
};
//---------------------------------------------------------------------------------
struct Button{
   Property pro;
   SetObject set;
   Mouse mouse;
//---\\
   void creat(string name,int xd,int yd,int xs,int ys,string text="Button",int sub_win=0,bool back=false){
     ObjectCreate(0,name,OBJ_BUTTON,sub_win,0,0);mouse.nameObjectClick="";pro.delet=false;
     pro.xd=xd;pro.yd=yd;pro.xs=xs;pro.ys=ys;pro.name=name;pro.text=text;pro.texttmp=text;
     set.setColorDef(pro);set.setPosiXY(pro,xd,yd);set.setSizeXY(pro,xs,ys);
     set.setText(pro,text,8,clrWhite,"Tahoma Bold");
     set.setColorDefButton(pro);
     //-------------------------------------------
     pro.canMoveWithAll=false;
     ObjectSetInteger(0,pro.name,OBJPROP_BACK,back);
   }
//---\\
void delet(){
  ObjectDelete(0,pro.name);
} 
//---\\
  bool checkMouse(int id,long lparam,double dparam,string sparam){
    bool res=mouse.checkMouseOver(pro,lparam,dparam);if(!res){mouse.nameObjectClick="";return res;}
    //--
    //--move
    if(pro.canMoveSelf){checkMove(pro,id,lparam,dparam,sparam);}
    //--
    return res;
  }
//---\\
  void setMove(){pro.canMoveSelf=true;}
  void setMoveWithAll(){pro.canMoveWithAll=true;}
//---\\
  void setText(string text){
      pro.text=text;
      ObjectSetString(0,pro.name,OBJPROP_TEXT,pro.text);
  }
//---\\
  bool checkMove(Property &pro,int id,long lparam,double dparam,string sparam){
     if(sparam=="1" && mouse.nameObjectClick=="")
       {
         mouse.nameObjectClick=pro.name;
         mouse.getEkhteleafMouseY(pro,lparam,dparam);
         mouse.getEkhteleafMouseX(pro,lparam,dparam);
       }
     else if (sparam=="1" && mouse.nameObjectClick!="")
       {
          mouse.nameObjectClick="";return false;
       }
    if(mouse.nameObjectClick==pro.name && sparam!="1" ){
       if(mouse.checkObjectCanMoveXY(pro,lparam,dparam))
         {
            mouse.moveByMouseY(pro,lparam,dparam );
            mouse.moveByMouseX(pro,lparam,dparam );
         }
       return true;  
      }
  return false;
  }
};



//---------------------------------------------------------------------------------
struct ButtonRec{
   Property pro1;
   Property pro2;
   SetObject set;
   Mouse mouse;
//---\\
   void creat(string name,int xd,int yd,int xs,int ys,string text="ButtonRe",int sub_win=0,bool back=false){
     ObjectCreate(0,name,OBJ_LABEL,sub_win,0,0);mouse.nameObjectClick="";pro1.delet=false;
     pro1.xd=xd;pro1.yd=yd;pro1.xs=xs;pro1.ys=ys;pro1.name=name;pro1.text=text;pro1.texttmp=text;
     set.setColorDef(pro1);set.setPosiXY(pro1,xd,yd);set.setSizeXY(pro1,xs,ys);
     set.setText(pro1,text,8,clrWhite,"Tahoma Bold");
     set.setColorDefButton(pro1);
     //-------------------------------------------
     pro1.canMoveWithAll=false;
     ObjectSetInteger(0,pro1.name,OBJPROP_BACK,back);
     //--------------------------------------------
     ObjectCreate(0,name+"r",OBJ_RECTANGLE_LABEL,sub_win,0,0);mouse.nameObjectClick="";pro2.delet=false;
     pro2.xd=xd;pro2.yd=yd;pro2.xs=xs;pro2.ys=ys;pro2.name=name+"r";pro2.text=text;pro2.texttmp=text;
     set.setColorDef(pro2);set.setPosiXY(pro2,xd,yd);set.setSizeXY(pro2,xs,ys);
     set.setText(pro2,text,8,clrWhite,"Tahoma Bold");
     set.setColorDefButton(pro2);
     //-------------------------------------------
     pro2.canMoveWithAll=false;
     ObjectSetInteger(0,pro2.name,OBJPROP_BACK,back);
     
     
   }
//---\\
void delet(){
  ObjectDelete(0,pro1.name);  ObjectDelete(0,pro2.name);
} 
//---\\
  bool checkMouse(int id,long lparam,double dparam,string sparam){
    bool res=mouse.checkMouseOver(pro1,lparam,dparam);if(!res){mouse.nameObjectClick="";return res;}
    //--
    //--move
    if(pro1.canMoveSelf){checkMove(pro1,id,lparam,dparam,sparam);}
    //--
    return res;
  }
//---\\
  void setMove(){pro1.canMoveSelf=true;pro2.canMoveSelf=true;}
  void setMoveWithAll(){pro1.canMoveWithAll=true;pro2.canMoveWithAll=true;}
//---\\
  void setText(string text){
      pro2.text=text;
      ObjectSetString(0,pro2.name,OBJPROP_TEXT,pro2.text);
  }
//---\\
  bool checkMove(Property &pro,int id,long lparam,double dparam,string sparam){
     if(sparam=="1" && mouse.nameObjectClick=="")
       {
         mouse.nameObjectClick=pro.name;
         mouse.getEkhteleafMouseY(pro,lparam,dparam);
         mouse.getEkhteleafMouseX(pro,lparam,dparam);
       }
     else if (sparam=="1" && mouse.nameObjectClick!="")
       {
          mouse.nameObjectClick="";return false;
       }
    if(mouse.nameObjectClick==pro.name && sparam!="1" ){
       if(mouse.checkObjectCanMoveXY(pro,lparam,dparam))
         {
            mouse.moveByMouseY(pro,lparam,dparam );
            mouse.moveByMouseX(pro,lparam,dparam );
         }
       return true;  
      }
  return false;
  }
};




//---------------------------------------------------------------------------------
struct Triangle{
   Property pro;
   SetObject set;
   Mouse mouse;
//---\\
   void creat(string name,
     double price1,double price2,double price3,
     datetime time1,datetime time2,datetime time3,
     color clr=clrBlue,bool back=true,int width=1,ENUM_LINE_STYLE style=STYLE_SOLID,
     int sub_win=0){
     //-------------------------------------------
     pro.name=name;pro.delet=false;
     ObjectCreate(0,name,OBJ_TRIANGLE,sub_win,time1,price1,time2,price2,time3,price3);
     ObjectSetInteger(0,name,OBJPROP_COLOR,clr);pro.colorBack=clr;
     ObjectSetInteger(0,name,OBJPROP_STYLE,style);
     ObjectSetInteger(0,name,OBJPROP_WIDTH,width);
     ObjectSetInteger(0,name,OBJPROP_BACK,back);
     set.setTimePrice3(pro,price1,price2,price3,time1,time2,time3);
   }
//---\\
void delet(){
  ObjectDelete(0,pro.name);
  pro.delet=true;
}
   
};
//---------------------------------------------------------------------------------
struct Triangle2{
   Property pro1;
   Property pro2;
   SetObject set;
   Mouse mouse;
//---\\
   void creat(string name,
     double price1,double price2,double price3,
     double price4,double price5,double price6,
     datetime time1,datetime time2,datetime time3,
     datetime time4,datetime time5,datetime time6,
     color clr=clrBlue,bool back=true,int width=1,ENUM_LINE_STYLE style=STYLE_SOLID,
     int sub_win=0){
     //-------------------------------------------
     pro1.name=name+"1";pro1.delet=false;pro2.delet=false;
     ObjectCreate(0,pro1.name,OBJ_TRIANGLE,sub_win,time1,price1,time2,price2,time3,price3);
     ObjectSetInteger(0,pro1.name,OBJPROP_COLOR,clr);pro1.colorBack=clr;
     ObjectSetInteger(0,pro1.name,OBJPROP_STYLE,style);
     ObjectSetInteger(0,pro1.name,OBJPROP_WIDTH,width);
     ObjectSetInteger(0,pro1.name,OBJPROP_BACK,back);
     set.setTimePrice3(pro1,price1,price2,price3,time1,time2,time3);
     
     pro2.name=name+"2";
     ObjectCreate(0,pro2.name,OBJ_TRIANGLE,sub_win,time4,price4,time5,price5,time6,price6);
     ObjectSetInteger(0,pro2.name,OBJPROP_COLOR,clr);pro2.colorBack=clr;
     ObjectSetInteger(0,pro2.name,OBJPROP_STYLE,style);
     ObjectSetInteger(0,pro2.name,OBJPROP_WIDTH,width);
     ObjectSetInteger(0,pro2.name,OBJPROP_BACK,back);
     set.setTimePrice3(pro2,price4,price5,price6,time4,time5,time6);
   }
void delet(){
  ObjectDelete(0,pro1.name);ObjectDelete(0,pro2.name);
  pro1.delet=true;pro2.delet=true;
} 
};


//---------------------------------------------------------------------------------
struct Triangle4{
   Property pro1;
   Property pro2;
   Property pro3;
   Property pro4;
   
   SetObject set;
   Mouse mouse;
//---\\
   void creat(string name,
     double price1,double price2,double price3,
     double price4,double price5,double price6,
     datetime time1,datetime time2,datetime time3,
     datetime time4,datetime time5,datetime time6,
     color clr=clrBlue,bool back=true,int width=1,ENUM_LINE_STYLE style=STYLE_SOLID,
     int sub_win=0){
     //-------------------------------------------
     pro1.name=name+"1";pro1.delet=false;pro2.delet=false;pro3.delet=false;pro4.delet=false;
     ObjectCreate(0,pro1.name,OBJ_TRIANGLE,sub_win,time1,price1,time2,price2,time3,price3);
     ObjectSetInteger(0,pro1.name,OBJPROP_COLOR,clr);pro1.colorBack=clr;
     ObjectSetInteger(0,pro1.name,OBJPROP_STYLE,style);
     ObjectSetInteger(0,pro1.name,OBJPROP_WIDTH,width);
     ObjectSetInteger(0,pro1.name,OBJPROP_BACK,back);
     set.setTimePrice3(pro1,price1,price2,price3,time1,time2,time3);
     
     pro2.name=name+"2";
     ObjectCreate(0,pro2.name,OBJ_TRIANGLE,sub_win,time4,price4,time5,price5,time6,price6);
     ObjectSetInteger(0,pro2.name,OBJPROP_COLOR,clr);pro2.colorBack=clr;
     ObjectSetInteger(0,pro2.name,OBJPROP_STYLE,style);
     ObjectSetInteger(0,pro2.name,OBJPROP_WIDTH,width);
     ObjectSetInteger(0,pro2.name,OBJPROP_BACK,back);
     set.setTimePrice3(pro2,price4,price5,price6,time4,time5,time6);
     
     pro3.name=name+"3";
     time2=Time[iBarShift(Symbol(),0,time1)+3];
     ObjectCreate(0,pro3.name,OBJ_TREND,sub_win,time2,price1,time1,price1);
     ObjectSetInteger(0,pro3.name,OBJPROP_COLOR,clr);pro2.colorBack=clr;
     ObjectSetInteger(0,pro3.name,OBJPROP_STYLE,0);
     ObjectSetInteger(0,pro3.name,OBJPROP_WIDTH,3);
     ObjectSetInteger(0,pro3.name,OBJPROP_BACK,back);
     ObjectSetInteger(0,pro3.name,OBJPROP_RAY_RIGHT,false);
     set.setTimePrice2(pro3,price1,price1,time1,time2);
     
     pro4.name=name+"4";
     ObjectCreate(0,pro4.name,OBJ_TEXT,sub_win,time1,price1,time2,price1);
     ObjectSetInteger(0,pro4.name,OBJPROP_COLOR,clr);pro2.colorBack=clr;
     set.setText(pro4,"Trade",8,clr);
     set.setTimePrice1(pro4,price1,time1);
   }
void delet(){
  ObjectDelete(0,pro1.name);ObjectDelete(0,pro2.name);
  ObjectDelete(0,pro3.name);ObjectDelete(0,pro4.name);
  pro1.delet=true;pro2.delet=true;pro3.delet=true;pro4.delet=true;
} 
void setText(string text="Trade"){
  pro4.text=text;
  ObjectSetString(0,pro4.name,OBJPROP_TEXT,text);
  }
};



int checkTriangle2Repeat(Triangle2 &tris2[],
                          double price4,double price5,double price6,
                          datetime time4,datetime time5,datetime time6 )
{
 for(int i=0;i<ArraySize(tris2);i++)
   {
    if(tris2[i].pro1.delet==false)
      {
       //---------
       if(tris2[i].pro2.price1==price4 && tris2[i].pro2.price2==price5 && tris2[i].pro2.price3==price6)
         {
          if(tris2[i].pro2.time1==time4 && tris2[i].pro2.time2==time5 && tris2[i].pro2.time3==time6)
            {
             return i;
            }
         }
       //---------
      }   
   }                         
return -1;
}

int checkTriangle4Repeat(Triangle4 &tris4[],
                          double price4,double price5,double price6,
                          datetime time4,datetime time5,datetime time6 )
{
 for(int i=0;i<ArraySize(tris4);i++)
   {
    if(tris4[i].pro1.delet==false)
      {
       if(tris4[i].pro2.price1==price4 && tris4[i].pro2.price2==price5 && tris4[i].pro2.price3==price6)
         {
          if(tris4[i].pro2.time1==time4 && tris4[i].pro2.time2==time5 && tris4[i].pro2.time3==time6)
            {
             return i;
            }
         }
     }    
   }                         
return -1;
}

int checkTriangle4Repeat_1(Triangle4 &tris4[],Triangle4 &tris4_base[],
                          double price4,double price5,double price6,
                          datetime time4,datetime time5,datetime time6 )
{

 for(int i=0;i<ArraySize(tris4_base);i++)
   {
    if(tris4_base[i].pro1.delet==false)
      {
       if(tris4_base[i].pro2.price1==price4 && tris4_base[i].pro2.price2==price5 && tris4_base[i].pro2.price3==price6)
         {
          if(tris4_base[i].pro2.time1==time4 && tris4_base[i].pro2.time2==time5 && tris4_base[i].pro2.time3==time6)
            {
             return -2;
            }
         }
     }    
   } 


 for(int i=0;i<ArraySize(tris4);i++)
   {
    if(tris4[i].pro1.delet==false)
      {
       if(tris4[i].pro2.price1==price4 && tris4[i].pro2.price2==price5 && tris4[i].pro2.price3==price6)
         {
          if(tris4[i].pro2.time1==time4 && tris4[i].pro2.time2==time5 && tris4[i].pro2.time3==time6)
            {
             return i;
            }
         }
     }    
   }                         
return -1;
}



int checkTriangle4RepeatDelet(Triangle4 &tris4_1[],
                          double price4,double price5,double price6,
                          datetime time4,datetime time5,datetime time6 )
{
 for(int i=0;i<ArraySize(tris4_1);i++)
   {
    if(tris4_1[i].pro1.delet==false)
      {
       if(tris4_1[i].pro2.price1==price4 && tris4_1[i].pro2.price2==price5 && tris4_1[i].pro2.price3==price6)
         {
          if(tris4_1[i].pro2.time1==time4 && tris4_1[i].pro2.time2==time5 && tris4_1[i].pro2.time3==time6)
            {
             tris4_1[i].delet();
             printf("delete "+i);
             return i;
            }
         }
     }    
   }                         
return -1;
}


void addTriangle2(Triangle2 &tris2[],
     double price1,double price2,double price3,
     double price4,double price5,double price6,
     datetime time1,datetime time2,datetime time3,
     datetime time4,datetime time5,datetime time6,
     color clr=clrBlue,bool back=true,int width=1,ENUM_LINE_STYLE style=STYLE_SOLID,
     int sub_win=0){
     //---------
     int chId=checkTriangle2Repeat(tris2,price4,price5,price6,time4,time5,time6);
     if(chId>=0)
       {
        tris2[chId].set.setTimePrice3(tris2[chId].pro1,price1,price2,price3,time1,time2,time3);
        return ;
       }
     //---------
     Triangle2 tri2;
     string name="Triangle2"+back+CreatRandomName();
     tri2.creat(name,price1,price2,price3,price4,price5,price6,
     time1,time2,time3,time4,time5,time6,
     clr,back,width,style,sub_win);
     ArrayResize(tris2,ArraySize(tris2)+1);
     tris2[ArraySize(tris2)-1]=tri2;
}


void addTriangle4(Triangle4 &tris4[],
     double price1,double price2,double price3,
     double price4,double price5,double price6,
     datetime time1,datetime time2,datetime time3,
     datetime time4,datetime time5,datetime time6,
     color clr=clrBlue,bool back=true,int width=1,ENUM_LINE_STYLE style=STYLE_SOLID,
     int sub_win=0){
     //---------
     int chId=checkTriangle4Repeat(tris4,price4,price5,price6,time4,time5,time6);
     if(chId>=0)
       {
        tris4[chId].set.setTimePrice3(tris4[chId].pro1,price1,price2,price3,time1,time2,time3);
        time2=Time[iBarShift(Symbol(),0,time1)+3];
        tris4[chId].set.setTimePrice2(tris4[chId].pro3,price1,price1,time1,time2);
        tris4[chId].set.setTimePrice1(tris4[chId].pro4,price1,time1);
        if(price6>price5){tris4[chId].setText("sell");}else{tris4[chId].setText("buy");}
        return ;
       }
     //---------
     Triangle4 tri4;
     string name="Triangle4"+back+CreatRandomName();
     tri4.creat(name,price1,price2,price3,price4,price5,price6,
     time1,time2,time3,time4,time5,time6,
     clr,back,width,style,sub_win);
     ArrayResize(tris4,ArraySize(tris4)+1);
     tris4[ArraySize(tris4)-1]=tri4;
     if(price6>price5){tris4[ArraySize(tris4)-1].setText("sell");}else{tris4[ArraySize(tris4)-1].setText("buy");}
}



void addTriangle4_1(Triangle4 &tris4[],Triangle4 &tris4_base[],
     double price1,double price2,double price3,
     double price4,double price5,double price6,
     datetime time1,datetime time2,datetime time3,
     datetime time4,datetime time5,datetime time6,
     color clr=clrBlue,bool back=true,int width=1,ENUM_LINE_STYLE style=STYLE_SOLID,
     int sub_win=0){
     //---------
     int chId=checkTriangle4Repeat_1(tris4,tris4_base,price4,price5,price6,time4,time5,time6);
     if(chId==-2){return;}
     if(chId>=0)
       {
        tris4[chId].set.setTimePrice3(tris4[chId].pro1,price1,price2,price3,time1,time2,time3);
        time2=Time[iBarShift(Symbol(),0,time1)+3];
        tris4[chId].set.setTimePrice2(tris4[chId].pro3,price1,price1,time1,time2);
        tris4[chId].set.setTimePrice1(tris4[chId].pro4,price1,time1);
        if(price6>price5){tris4[chId].setText("sell");}else{tris4[chId].setText("buy");}
        return ;
       }
     //---------
     Triangle4 tri4;
     string name="Triangle4"+back+CreatRandomName();
     tri4.creat(name,price1,price2,price3,price4,price5,price6,
     time1,time2,time3,time4,time5,time6,
     clr,back,width,style,sub_win);
     ArrayResize(tris4,ArraySize(tris4)+1);
     tris4[ArraySize(tris4)-1]=tri4;
     if(price6>price5){tris4[ArraySize(tris4)-1].setText("sell");}else{tris4[ArraySize(tris4)-1].setText("buy");}
}


void addTriangle(Triangle &tris[],
     double price1,double price2,double price3,
     datetime time1,datetime time2,datetime time3,
     color clr=clrBlue,bool back=true,int width=1,ENUM_LINE_STYLE style=STYLE_SOLID,
     int sub_win=0){
     Triangle tri;
     string name="Triangle"+CreatRandomName();
     tri.creat(name,price1,price2,price3,time1,time2,time3,clr,back,width,style,sub_win);
     ArrayResize(tris,ArraySize(tris)+1);
     tris[ArraySize(tris)-1]=tri;
}

//---------------------------------------------------------------------------------
struct Rectangle{
   Property pro;
   SetObject set;
   Mouse mouse;
//---\\
   void creat(string name,int xd,int yd,int xs,int ys,int sub_win=0){
     ObjectCreate(0,name,OBJ_RECTANGLE_LABEL,sub_win,0,0);mouse.nameObjectClick="";pro.delet=false;
     pro.xd=xd;pro.yd=yd;pro.xs=xs;pro.ys=ys;pro.name=name;pro.text="";pro.texttmp="";
     set.setColorDef(pro);set.setPosiXY(pro,xd,yd);set.setSizeXY(pro,xs,ys);
     set.setText(pro,"",8,clrWhite,"Tahoma Bold");
     set.setColorDefButton(pro);
     //-------------------------------------------
     pro.canMoveWithAll=false;
   }
//---\\
  bool checkMouse(int id,long lparam,double dparam,string sparam){
    bool res=mouse.checkMouseOver(pro,lparam,dparam);if(!res){mouse.nameObjectClick="";return res;}
    //--
    //--move
    if(pro.canMoveSelf){checkMove(pro,id,lparam,dparam,sparam);}
    //--
    return res;
  }
//---\\
  void setMove(){pro.canMoveSelf=true;}
  void setMoveWithAll(){pro.canMoveWithAll=true;}
//---\\
  bool checkMove(Property &pro,int id,long lparam,double dparam,string sparam){
     if(sparam=="1" && mouse.nameObjectClick=="")
       {
         mouse.nameObjectClick=pro.name;
         mouse.getEkhteleafMouseY(pro,lparam,dparam);
         mouse.getEkhteleafMouseX(pro,lparam,dparam);
       }
     else if (sparam=="1" && mouse.nameObjectClick!="")
       {
          mouse.nameObjectClick="";return false;
       }
    if(mouse.nameObjectClick==pro.name && sparam!="1" ){
       if(mouse.checkObjectCanMoveXY(pro,lparam,dparam))
         {
            mouse.moveByMouseY(pro,lparam,dparam );
            mouse.moveByMouseX(pro,lparam,dparam );
         }
       return true;  
      }
  return false;
  }
};
//---------------------------------------------------------------------------------
struct Label{
   Property pro;
   SetObject set;
   Mouse mouse;
//---\\
   void creat(string name,int xd,int yd,int xs,int ys,string text="label",int sub_win=0,bool back=false){
     ObjectCreate(0,name,OBJ_LABEL,sub_win,0,0);mouse.nameObjectClick="";pro.delet=false;
     pro.xd=xd;pro.yd=yd;pro.xs=xs;pro.ys=ys;pro.name=name;pro.text=text;pro.texttmp=text;
     set.setColorDef(pro);set.setPosiXY(pro,xd,yd);set.setSizeXY(pro,xs,ys);
     set.setText(pro,text,8,clrWhite,"Tahoma Bold");
     set.setColorDefButton(pro);
     //-------------------------------------------
     pro.canMoveWithAll=false;
     ObjectSetInteger(0,pro.name,OBJPROP_BACK,back);
   }
//---\\
  bool checkMouse(int id,long lparam,double dparam,string sparam){
    bool res=mouse.checkMouseOver(pro,lparam,dparam);if(!res){mouse.nameObjectClick="";return res;}
    //--
    //--move
    if(pro.canMoveSelf){checkMove(pro,id,lparam,dparam,sparam);}
    //--
    return res;
  }
//---\\
  void setMove(){pro.canMoveSelf=true;}
  void setMoveWithAll(){pro.canMoveWithAll=true;}
  void setText(string text){
      pro.text=text;
      ObjectSetString(0,pro.name,OBJPROP_TEXT,pro.text);
  }
//---\\
  bool checkMove(Property &pro,int id,long lparam,double dparam,string sparam){
     if(sparam=="1" && mouse.nameObjectClick=="")
       {
         mouse.nameObjectClick=pro.name;
         mouse.getEkhteleafMouseY(pro,lparam,dparam);
         mouse.getEkhteleafMouseX(pro,lparam,dparam);
       }
     else if (sparam=="1" && mouse.nameObjectClick!="")
       {
          mouse.nameObjectClick="";return false;
       }
    if(mouse.nameObjectClick==pro.name && sparam!="1" ){
       if(mouse.checkObjectCanMoveXY(pro,lparam,dparam))
         {
            mouse.moveByMouseY(pro,lparam,dparam );
            mouse.moveByMouseX(pro,lparam,dparam );
         }
       return true;  
      }
  return false;
  }
  
};


//---------------------------------------------------------------------------------
struct ButtonType3{
   Property pro1;
   Property pro2;
   Property pro3;
   SetObject set;
   Mouse mouse;
//---\\
   void creat(string name,int xd,int yd,int xs,int ys,string text="Button",int sub_win=0){
     //---pro1  body
     ObjectCreate(0,name,OBJ_BUTTON,sub_win,0,0);mouse.nameObjectClick="";pro1.delet=false;
     pro1.xd=xd;pro1.yd=yd;pro1.xs=xs;pro1.ys=ys;pro1.name=name;pro1.text=text;pro1.texttmp=text;
     set.setColorDef(pro1);set.setPosiXY(pro1,xd,yd);set.setSizeXY(pro1,xs,ys);
     set.setText(pro1,text,8,clrWhite,"Tahoma Bold");
     set.setColorDefButton(pro1);
     //--
     int xsb=20;int ysb=20;
     //---pro2  *
     ObjectCreate(0,name+"*",OBJ_BUTTON,sub_win,0,0);mouse.nameObjectClick="";pro2.delet=false;
     pro2.xd=xd;pro2.yd=yd-ysb;pro2.xs=xsb;pro2.ys=ysb;pro2.name=name+"*";pro2.text="*";pro2.texttmp="*";pro2.delet=false;
     set.setColorDef(pro2);set.setPosiXY(pro2,xd,yd-ysb);set.setSizeXY(pro2,xsb,ysb);
     set.setText(pro2,"*",8,clrWhite,"Tahoma Bold");
     set.setColorDefButton(pro2);
     //---pro3  =
     ObjectCreate(0,name+"=",OBJ_BUTTON,sub_win,0,0);mouse.nameObjectClick="";pro3.delet=false;
     pro3.xd=xd+xsb;pro3.yd=yd-ysb;pro3.xs=xsb;pro3.ys=ysb;pro3.name=name+"=";pro3.text="=";pro3.texttmp="=";pro3.delet=false;
     set.setColorDef(pro3);set.setPosiXY(pro3,xd+xsb,yd-ysb);set.setSizeXY(pro3,xs-xsb,ysb);
     set.setText(pro3,"=",8,clrWhite,"Tahoma Bold");
     set.setColorDefButton(pro3);
     //-------------------------------------------
     pro1.canMoveWithAll=false;pro1.canMoveSelf=false;
     pro2.canMoveWithAll=false;pro2.canMoveSelf=false;
     pro3.canMoveWithAll=false;pro3.canMoveSelf=false;
   }
//---\\
  void setMove(){pro1.canMoveSelf=true;pro2.canMoveSelf=true;pro3.canMoveSelf=true;}
  void setMoveWithAll(){pro1.canMoveWithAll=true;pro2.canMoveWithAll=true;pro3.canMoveWithAll=true;}
//---\\
  void setText(string text){
      pro1.text=text;
      ObjectSetString(0,pro1.name,OBJPROP_TEXT,pro1.text);
  }
//---\\
  bool checkMouse(int id,long lparam,double dparam,string sparam){
    bool res=false;bool res1=false;bool res2=false;bool res3=false;
    res1=mouse.checkMouseOver(pro1,lparam,dparam);
    res2=mouse.checkMouseOver(pro2,lparam,dparam);
    res3=mouse.checkMouseOver(pro3,lparam,dparam);
    if(res1 || res2 || res3){res=true;}else{mouse.nameObjectClick="";return res;}
    //--
    //--move
    if(res3 && pro3.canMoveSelf){checkMove(pro1,pro2,pro3,id,lparam,dparam,sparam);}
    //--delete
    if(res2){delet(sparam);}
    return res;
  }
//---\\
   void delet(string sparam){
     if(sparam=="1")
       {
          ObjectDelete(0,pro1.name);ObjectDelete(0,pro2.name);ObjectDelete(0,pro3.name);
          pro1.delet=true;pro2.delet=true;pro3.delet=true;
          pro1.canMoveWithAll=false;pro2.canMoveWithAll=false;pro3.canMoveWithAll=false;
          pro1.canMoveSelf=false;pro2.canMoveSelf=false;pro3.canMoveSelf=false;
       }
   }
//---\\
  bool checkMove(Property &pro1,Property &pro2,Property &pro3,int id,long lparam,double dparam,string sparam){
     if(sparam=="1" && mouse.nameObjectClick=="")
       {
         mouse.nameObjectClick=pro3.name;
         mouse.getEkhteleafMouseY(pro1,lparam,dparam);
         mouse.getEkhteleafMouseX(pro1,lparam,dparam);
         mouse.getEkhteleafMouseY(pro2,lparam,dparam);
         mouse.getEkhteleafMouseX(pro2,lparam,dparam);
         mouse.getEkhteleafMouseY(pro3,lparam,dparam);
         mouse.getEkhteleafMouseX(pro3,lparam,dparam);
       }
     else if (sparam=="1" && mouse.nameObjectClick!="")
       {
           mouse.nameObjectClick="";return false; 
       }
    if(mouse.nameObjectClick==pro3.name && sparam!="1" ){
       if(
           mouse.checkObjectCanMoveXY(pro1,lparam,dparam) && 
           mouse.checkObjectCanMoveXY(pro2,lparam,dparam) &&
           mouse.checkObjectCanMoveXY(pro3,lparam,dparam)
          )
         {
            //-- body pro1
            mouse.moveByMouseY(pro1,lparam,dparam );
            mouse.moveByMouseX(pro1,lparam,dparam );
            //-- * pro2
            mouse.moveByMouseY(pro2,lparam,dparam );
            mouse.moveByMouseX(pro2,lparam,dparam );
            //-- = pro3
            mouse.moveByMouseY(pro3,lparam,dparam );
            mouse.moveByMouseX(pro3,lparam,dparam );
            return true;
         }
      }
  return false;
  }
  
};

//---------------------------------------------------------------------------------
struct ButtonType4{
   Property pro1;
   Property pro2;
   Property pro3;
   Property pro4;
   
   SetObject set;
   Mouse mouse;
//---\\
   void creat(string name,int xd,int yd,int xs,int ys,string text="Run",int sub_win=0){
     //---pro1  body
     ObjectCreate(0,name,OBJ_BUTTON,sub_win,0,0);mouse.nameObjectClick="";pro1.delet=false;
     pro1.xd=xd;pro1.yd=yd;pro1.xs=xs;pro1.ys=ys;pro1.name=name;pro1.text=text;pro1.texttmp=text;
     set.setColorDef(pro1);
     set.setPosiXY(pro1,xd,yd);set.setSizeXY(pro1,xs/2,ys);
     set.setText(pro1,text,8,clrWhite,"Tahoma Bold");
     set.setColorDefButton(pro1);
     //--
     int xsb=20;int ysb=20;
     //---pro2  *
     ObjectCreate(0,name+"*",OBJ_BUTTON,sub_win,0,0);mouse.nameObjectClick="";pro2.delet=false;
     pro2.xd=xd;pro2.yd=yd-ysb;pro2.xs=xsb;pro2.ys=ysb;pro2.name=name+"*";pro2.text="*";pro2.texttmp="*";pro2.delet=false;
     set.setColorDef(pro2);set.setPosiXY(pro2,xd,yd-ysb);set.setSizeXY(pro2,xsb,ysb);
     set.setText(pro2,"*",8,clrWhite,"Tahoma Bold");
     set.setColorDefButton(pro2);
     //---pro3  =
     ObjectCreate(0,name+"=",OBJ_BUTTON,sub_win,0,0);mouse.nameObjectClick="";pro3.delet=false;
     pro3.xd=xd+xsb;pro3.yd=yd-ysb;pro3.xs=xsb;pro3.ys=ysb;pro3.name=name+"=";pro3.text="=";pro3.texttmp="=";pro3.delet=false;
     set.setColorDef(pro3);set.setPosiXY(pro3,xd+xsb,yd-ysb);set.setSizeXY(pro3,xs-xsb,ysb);
     set.setText(pro3,"=",8,clrWhite,"Tahoma Bold");
     set.setColorDefButton(pro3);
     
     //---pro4  editor
     xsb=30;ysb=30;
     ObjectCreate(0,name+"editor",OBJ_EDIT,sub_win,0,0);mouse.nameObjectClick="";pro4.delet=false;
     pro4.xd=xd+xsb;pro4.yd=yd+ysb;pro4.xs=xsb;pro4.ys=ysb;pro4.name=name+"editor";pro4.text="0";pro4.texttmp="0";pro4.delet=false;
     set.setColorDef(pro4);
     //set.setPosiXY(pro4,xd+xs/2-xsb/2,yd+ys/2-ysb/2);
     set.setPosiXY(pro4,xd+xs/2,yd);
     set.setSizeXY(pro4,xs/2,ys);
     set.setText(pro4,"0",8,clrWhite,"Tahoma Bold");
     set.setColorDefButton(pro4);
     //-------------------------------------------
     pro1.canMoveWithAll=false;pro1.canMoveSelf=false;
     pro2.canMoveWithAll=false;pro2.canMoveSelf=false;
     pro3.canMoveWithAll=false;pro3.canMoveSelf=false;
     pro4.canMoveWithAll=false;pro4.canMoveSelf=false;
     
     
   }
//---\\
  void setMove(){pro1.canMoveSelf=true;pro2.canMoveSelf=true;pro3.canMoveSelf=true;pro4.canMoveSelf=true;}
  void setMoveWithAll(){pro1.canMoveWithAll=true;pro2.canMoveWithAll=true;pro3.canMoveWithAll=true;pro4.canMoveWithAll=true;}
//---\\
  void setText(string text){
      pro1.text=text;
      ObjectSetString(0,pro1.name,OBJPROP_TEXT,pro1.text);
  }
//---\\
 string getText(){return ObjectGetString(0,pro4.name,OBJPROP_TEXT,0);}
//---\\
  bool checkMouse(int id,long lparam,double dparam,string sparam){
    bool res=false;bool res1=false;bool res2=false;bool res3=false;bool res4=false;
    res1=mouse.checkMouseOver(pro1,lparam,dparam);
    res2=mouse.checkMouseOver(pro2,lparam,dparam);
    res3=mouse.checkMouseOver(pro3,lparam,dparam);
    res4=mouse.checkMouseOver(pro4,lparam,dparam);
    if(res1 || res2 || res3 || res4){res=true;}else{mouse.nameObjectClick="";return res;}
    //--
    //--move
    if(res3 && pro3.canMoveSelf){checkMove(pro1,pro2,pro3,pro4,id,lparam,dparam,sparam);}
    //--delete
    if(res2){delet(sparam);}
    return res;
  }
//---\\
   void delet(string sparam){
     if(sparam=="1")
       {
          ObjectDelete(0,pro1.name);ObjectDelete(0,pro2.name);
          ObjectDelete(0,pro3.name);ObjectDelete(0,pro4.name);
          pro1.delet=true;pro2.delet=true;pro3.delet=true;pro4.delet=true;
          pro1.canMoveWithAll=false;pro2.canMoveWithAll=false;
          pro3.canMoveWithAll=false;pro4.canMoveWithAll=false;
          pro1.canMoveSelf=false;pro2.canMoveSelf=false;
          pro3.canMoveSelf=false;pro4.canMoveSelf=false;
       }
   }
//---\\
  bool checkMove(Property &pro1,Property &pro2,Property &pro3,Property &pro4,int id,long lparam,double dparam,string sparam){
     if(sparam=="1" && mouse.nameObjectClick=="")
       {
         mouse.nameObjectClick=pro3.name;
         mouse.getEkhteleafMouseY(pro1,lparam,dparam);//--1
         mouse.getEkhteleafMouseX(pro1,lparam,dparam);//--1
         mouse.getEkhteleafMouseY(pro2,lparam,dparam);//--2
         mouse.getEkhteleafMouseX(pro2,lparam,dparam);//--2
         mouse.getEkhteleafMouseY(pro3,lparam,dparam);//--3
         mouse.getEkhteleafMouseX(pro3,lparam,dparam);//--3
         mouse.getEkhteleafMouseY(pro4,lparam,dparam);//--4
         mouse.getEkhteleafMouseX(pro4,lparam,dparam);//--4
       }
     else if (sparam=="1" && mouse.nameObjectClick!="")
       {
           mouse.nameObjectClick="";return false; 
       }
    if(mouse.nameObjectClick==pro3.name && sparam!="1" ){
       if(
           mouse.checkObjectCanMoveXY(pro1,lparam,dparam) && 
           mouse.checkObjectCanMoveXY(pro2,lparam,dparam) &&
           mouse.checkObjectCanMoveXY(pro3,lparam,dparam) &&
           mouse.checkObjectCanMoveXY(pro4,lparam,dparam)
          )
         {
            //-- body pro1
            mouse.moveByMouseY(pro1,lparam,dparam );
            mouse.moveByMouseX(pro1,lparam,dparam );
            //-- * pro2
            mouse.moveByMouseY(pro2,lparam,dparam );
            mouse.moveByMouseX(pro2,lparam,dparam );
            //-- = pro3
            mouse.moveByMouseY(pro3,lparam,dparam );
            mouse.moveByMouseX(pro3,lparam,dparam );
            //-- editor pro4
            mouse.moveByMouseY(pro4,lparam,dparam );
            mouse.moveByMouseX(pro4,lparam,dparam );
            return true;
         }
      }
  return false;
  }
  
};

//---------------------------------------------------------------------------------
struct ButtonPower{
   Property pro;
   SetObject set;
   Mouse mouse;
//---\\
   void creat(string name,int xd,int yd,int xs,int ys,string text="",int sub_win=0){
     ObjectCreate(0,name,OBJ_BUTTON,sub_win,0,0);mouse.nameObjectClick="";pro.delet=false;
     pro.xd=xd;pro.yd=yd;pro.xs=xs;pro.ys=ys;pro.name=name;pro.text=text;pro.texttmp=text;
     set.setColorDef(pro);
     set.setPosiXY(pro,xd,yd);
     set.setSizeXY(pro,xs,ys);
     set.setText(pro,text,8,clrWhite,"Tahoma Bold");
     set.setColorDefButton(pro);
     pro.ybottom=mouse.getBottom(pro);
     //-------------------------------------------
     pro.canMoveWithAll=false;
     ObjectSetInteger(0,pro.name,OBJPROP_BACK,true);

   }
//---\\
  bool checkMouse(int id,long lparam,double dparam,string sparam){
    bool res=mouse.checkMouseOver(pro,lparam,dparam);if(!res){mouse.nameObjectClick="";return res;}
    //--
    //--move
    if(pro.canMoveSelf){checkMove(pro,id,lparam,dparam,sparam);}
    //--
    return res;
  }
//---\\
  void setMove(){pro.canMoveSelf=true;}
  void setMoveWithAll(){pro.canMoveWithAll=true;}
//---\\
  void setPowerY(double power=1.0){
    if(power>=0 && power<=1){
      set.setsizeY(pro,pro.ystmp*power);
      ObjectSetString(0,pro.name,OBJPROP_TEXT,NormalizeDouble((power*100.0),2)+"%");
    }
  }
//---\\
  void setPowerYDown(double power=1.0){
    if(power>=0 && power<=1){
      pro.ybottom=mouse.getBottom(pro);
      set.setsizeY(pro,pro.ystmp*power);
      int tol=MathAbs(mouse.getBottom(pro)-mouse.getTop(pro));
      set.setPosiY(pro,pro.ybottom-tol);
      ObjectSetString(0,pro.name,OBJPROP_TEXT,NormalizeDouble((power*100.0),2)+"%");
    }
  }
  
//---\\
  void setPowerX(double power=1.0){
    if(power>=0 && power<=1){
      set.setsizeX(pro,pro.xstmp*power);
      pro.text=NormalizeDouble((power*100.0),2)+"%";
      ObjectSetString(0,pro.name,OBJPROP_TEXT,pro.text);
    }
  }
//---\\
  void setText(string text){
      pro.text=text;
      ObjectSetString(0,pro.name,OBJPROP_TEXT,pro.text);
  }
//---\\
  bool checkMove(Property &pro,int id,long lparam,double dparam,string sparam){
     if(sparam=="1" && mouse.nameObjectClick=="")
       {
         mouse.nameObjectClick=pro.name;
         mouse.getEkhteleafMouseY(pro,lparam,dparam);
         mouse.getEkhteleafMouseX(pro,lparam,dparam);
       }
     else if (sparam=="1" && mouse.nameObjectClick!="")
       {
          mouse.nameObjectClick="";return false;
       }
    if(mouse.nameObjectClick==pro.name && sparam!="1" ){
       if(mouse.checkObjectCanMoveXY(pro,lparam,dparam))
         {
            mouse.moveByMouseY(pro,lparam,dparam );
            mouse.moveByMouseX(pro,lparam,dparam );
         }
       return true;  
      }
  return false;
  }
};

//---------------------------------------------------------------------------------
struct ButtonPowerWithTextDown{
   Property pro;
   Property prot;
   SetObject set;
   Mouse mouse;
//---\\
   void creat(string name,int xd,int yd,int xs,int ys,string text="EUR_short",int sub_win=0){
     ObjectCreate(0,name,OBJ_BUTTON,sub_win,0,0);mouse.nameObjectClick="";pro.delet=false;
     pro.name=name;pro.text="100%";pro.texttmp="100%";
     set.setColorDef(pro);
     set.setPosiXY(pro,xd,yd);
     set.setSizeXY(pro,xs,ys);
     set.setText(pro,"100%",8,clrWhite,"Tahoma Bold");
     set.setColorDefButton(pro);
     pro.ybottom=mouse.getBottom(pro);
     pro.canMoveWithAll=false;
     //-------------------------------------------
     int yst=25;
     ObjectCreate(0,name+"t",OBJ_BUTTON,sub_win,0,0);mouse.nameObjectClick="";prot.delet=false;
     prot.name=name+"t";prot.text=text;prot.texttmp=text;
     set.setColorDef(prot);
     set.setPosiXY(prot,xd,ys+yst*2);
     set.setSizeXY(prot,xs,yst);
     set.setText(prot,text,8,clrWhite,"Tahoma Bold");
     set.setColorDefButton(prot);
     prot.ybottom=mouse.getBottom(prot);
     //-------------------------------------------
     prot.canMoveWithAll=false;
   }
//---\\
  bool checkMouse(int id,long lparam,double dparam,string sparam){
    bool res=false;bool res1=false;bool res2=false;bool res3=false;
    res1=mouse.checkMouseOver(pro,lparam,dparam);
    res2=mouse.checkMouseOver(prot,lparam,dparam);
    if(res1 || res2){res=true;}else{mouse.nameObjectClick="";return res;}
    //--
    //--move
    if(prot.canMoveSelf){checkMove(pro,prot,id,lparam,dparam,sparam);}
    //--
    return res;
  }
//---\\
  void setMove(){pro.canMoveSelf=true;prot.canMoveSelf=true;}
  void setMoveWithAll(){pro.canMoveWithAll=true;prot.canMoveWithAll=true;}
//---\\
  void setPowerY(double power=1.0){
    if(power>=0 && power<=1){
      set.setsizeY(pro,pro.ystmp*power);
      ObjectSetString(0,pro.name,OBJPROP_TEXT,NormalizeDouble((power*100.0),2)+"%");
    }
  }
//---\\
  void setPowerYDown(double power=1.0){
    if(power>=0 && power<=1){
      pro.ybottom=mouse.getBottom(pro);
      prot.ybottom=mouse.getBottom(prot);
      set.setsizeY(pro,pro.ystmp*power);
      int tol=MathAbs(mouse.getBottom(pro)-mouse.getTop(pro));
      set.setPosiY(pro,pro.ybottom-tol);
      ObjectSetString(0,pro.name,OBJPROP_TEXT,NormalizeDouble((power*100.0),2)+"%");
      //--
      set.setPosiY(prot,mouse.getBottom(pro));
    }
  }
  
//---\\
  void setPowerX(double power=1.0){
    if(power>=0 && power<=1){
      set.setsizeX(pro,pro.xstmp*power);
      pro.text=NormalizeDouble((power*100.0),2)+"%";
      ObjectSetString(0,pro.name,OBJPROP_TEXT,pro.text);
    }
  }
//---\\
  void setText(string text){
      pro.text=text;
      ObjectSetString(0,pro.name,OBJPROP_TEXT,pro.text);
  }
//---\\
  bool checkMove(Property &pro,Property &prot,int id,long lparam,double dparam,string sparam){
     if(sparam=="1" && mouse.nameObjectClick=="")
       {
         mouse.nameObjectClick=prot.name;
         mouse.getEkhteleafMouseY(pro,lparam,dparam);
         mouse.getEkhteleafMouseX(pro,lparam,dparam);
         mouse.getEkhteleafMouseY(prot,lparam,dparam);
         mouse.getEkhteleafMouseX(prot,lparam,dparam);
       }
     else if (sparam=="1" && mouse.nameObjectClick!="")
       {
          mouse.nameObjectClick="";return false;
       }
    if(mouse.nameObjectClick==prot.name && sparam!="1" ){
       if(mouse.checkObjectCanMoveXY(pro,lparam,dparam) && mouse.checkObjectCanMoveXY(prot,lparam,dparam))
         {
            mouse.moveByMouseY(pro,lparam,dparam );
            mouse.moveByMouseX(pro,lparam,dparam );
            mouse.moveByMouseY(prot,lparam,dparam );
            mouse.moveByMouseX(prot,lparam,dparam );
         }
       return true;  
      }
  return false;
  }
};
//---------------------------------------------------------------------------------
struct ButtonPowerWithTextDown2{
   Property pro1;
   Property pro2;
   Property prot;
   SetObject set;
   Mouse mouse;
//---\\
   void creat(string name,int xd,int yd,int xs,int ys,string text="EUR_short",int sub_win=0){
     ObjectCreate(0,name+"1",OBJ_BUTTON,sub_win,0,0);mouse.nameObjectClick="";pro1.delet=false;
     pro1.name=name+"1";pro1.text="100%";pro1.texttmp="100%";
     set.setColorDef(pro1);
     set.setPosiXY(pro1,xd,yd);
     set.setSizeXY(pro1,xs/2-1,ys);
     set.setText(pro1,"100%",6,clrWhite,"Arial");
     set.setColorDefButton(pro1);
     pro1.ybottom=mouse.getBottom(pro1);
     pro1.canMoveWithAll=false;
     set.setColor(pro1,clrWhite,clrRed,clrYellow);
     ////////////
     ObjectCreate(0,name+"2",OBJ_BUTTON,sub_win,0,0);mouse.nameObjectClick="";pro2.delet=false;
     pro2.name=name+"2";pro2.text="100%";pro2.texttmp="100%";
     set.setColorDef(pro2);
     set.setPosiXY(pro2,xd+xs/2,yd);
     set.setSizeXY(pro2,xs/2-1,ys);
     set.setText(pro2,"100%",6,clrWhite,"Arial");
     set.setColorDefButton(pro2);
     pro2.ybottom=mouse.getBottom(pro2);
     pro2.canMoveWithAll=false;
     set.setColor(pro2,clrWhite,clrBlue,clrYellow);
     //-------------------------------------------
     int yst=25;
     ObjectCreate(0,name+"t",OBJ_LABEL,sub_win,0,0);mouse.nameObjectClick="";prot.delet=false;
     prot.name=name+"t";prot.text=text;prot.texttmp=text;
     set.setColorDef(prot);
     set.setPosiXY(prot,xd,ys+yst*2);
     set.setSizeXY(prot,xs,yst);
     set.setText(prot,text,7,clrWhite,"Arial");
     set.setColorDefButton(prot);
     prot.ybottom=mouse.getBottom(prot);
     set.setColor(prot,clrWhite,clrMagenta,clrYellow);
     //-------------------------------------------
     prot.canMoveWithAll=false;
     //--
     setPowerYDown1(1);
     setPowerYDown2(1); 
     ObjectSetInteger(0,name+"t",OBJPROP_BACK,true);
     ObjectSetInteger(0,name+"1",OBJPROP_BACK,true);
     ObjectSetInteger(0,name+"2",OBJPROP_BACK,true);
       }
//---\\
  bool checkMouse(int id,long lparam,double dparam,string sparam){
    bool res=false;bool res1=false;bool res2=false;bool res3=false;
    res1=mouse.checkMouseOver(pro1,lparam,dparam);
    res2=mouse.checkMouseOver(pro2,lparam,dparam);
    res3=mouse.checkMouseOver(prot,lparam,dparam);
    if(res1 || res2 || res3){res=true;}else{mouse.nameObjectClick="";return res;}
    //--
    //--move
    if(prot.canMoveSelf){checkMove(pro1,pro2,prot,id,lparam,dparam,sparam);}
    //--
    return res;
  }
//---\\
  void setMove(){pro1.canMoveSelf=true;pro2.canMoveSelf=true;prot.canMoveSelf=true;}
  void setMoveWithAll(){pro1.canMoveWithAll=true;pro2.canMoveWithAll=true;prot.canMoveWithAll=true;}
//---\\
  void setPowerY1(double power=1.0){
    if(power>=0 && power<=1){
      set.setsizeY(pro1,pro1.ystmp*power);
      ObjectSetString(0,pro1.name,OBJPROP_TEXT,NormalizeDouble((power*100.0),2)+"%");
    }
  }
//---\\
  void setPowerY2(double power=1.0){
    if(power>=0 && power<=1){
      set.setsizeY(pro2,pro2.ystmp*power);
      ObjectSetString(0,pro2.name,OBJPROP_TEXT,NormalizeDouble((power*100.0),2)+"%");
    }
  }
//---\\
  void setPowerYDown1(double power=1.0){
    if(power>=0 && power<=1){
      pro1.ybottom=mouse.getBottom(pro1);
      prot.ybottom=mouse.getBottom(prot);
      set.setsizeY(pro1,pro1.ystmp*power);
      int tol=MathAbs(mouse.getBottom(pro1)-mouse.getTop(pro1));
      set.setPosiY(pro1,pro1.ybottom-tol);
      //pro1.text=NormalizeDouble((power*100.0),2)+"%";
      pro1.text="";
      ObjectSetString(0,pro1.name,OBJPROP_TEXT,pro1.text);
      //--
      set.setPosiY(prot,mouse.getBottom(pro1));
    }
  }
//---\\
  void setPowerYDown2(double power=1.0){
    if(power>=0 && power<=1){
      pro2.ybottom=mouse.getBottom(pro2);
      prot.ybottom=mouse.getBottom(prot);
      set.setsizeY(pro2,pro2.ystmp*power);
      int tol=MathAbs(mouse.getBottom(pro2)-mouse.getTop(pro2));
      set.setPosiY(pro2,pro2.ybottom-tol);
      //pro2.text=NormalizeDouble((power*100.0),2)+"%";
      pro2.text="";
      ObjectSetString(0,pro2.name,OBJPROP_TEXT,pro2.text);
      //--
      set.setPosiY(prot,mouse.getBottom(pro2));
    }
  }
  
//---\\
  void setPowerX1(double power=1.0){
    if(power>=0 && power<=1){
      set.setsizeX(pro1,pro1.xstmp*power);
      //pro1.text=NormalizeDouble((power*100.0),2)+"%";
      pro1.text="";
      ObjectSetString(0,pro1.name,OBJPROP_TEXT,pro1.text);
    }
  }
//---\\
  void setPowerX2(double power=1.0){
    if(power>=0 && power<=1){
      set.setsizeX(pro2,pro2.xstmp*power);
      //pro2.text=NormalizeDouble((power*100.0),2)+"%";
      pro2.text="";
      ObjectSetString(0,pro2.name,OBJPROP_TEXT,pro2.text);
    }
  }
//---\\
  void setText(string text){
      prot.text=text;
      ObjectSetString(0,prot.name,OBJPROP_TEXT,prot.text);
  }
//---\\
  bool checkMove(Property &pro1,Property &pro2,Property &prot,int id,long lparam,double dparam,string sparam){
     if(sparam=="1" && mouse.nameObjectClick=="")
       {
         mouse.nameObjectClick=prot.name;
         mouse.getEkhteleafMouseY(pro1,lparam,dparam);
         mouse.getEkhteleafMouseX(pro1,lparam,dparam);
         mouse.getEkhteleafMouseY(pro2,lparam,dparam);
         mouse.getEkhteleafMouseX(pro2,lparam,dparam);
         mouse.getEkhteleafMouseY(prot,lparam,dparam);
         mouse.getEkhteleafMouseX(prot,lparam,dparam);
       }
     else if (sparam=="1" && mouse.nameObjectClick!="")
       {
          mouse.nameObjectClick="";return false;
       }
    if(mouse.nameObjectClick==prot.name && sparam!="1" ){
       if(mouse.checkObjectCanMoveXY(pro1,lparam,dparam) &&
          mouse.checkObjectCanMoveXY(pro2,lparam,dparam) &&
          mouse.checkObjectCanMoveXY(prot,lparam,dparam)
          )
         {
            mouse.moveByMouseY(pro1,lparam,dparam );
            mouse.moveByMouseX(pro1,lparam,dparam );
            mouse.moveByMouseY(pro2,lparam,dparam );
            mouse.moveByMouseX(pro2,lparam,dparam );
            mouse.moveByMouseY(prot,lparam,dparam );
            mouse.moveByMouseX(prot,lparam,dparam );
         }
       return true;  
      }
  return false;
  }
};




//---------------------------------------------------------------------------------
struct ButtonMoveAll{
   Property pro;
   SetObject set;
   Mouse mouse;
//---\\
   void creat(string name,int xd,int yd,int xs,int ys,string text="Button",int sub_win=0){
     ObjectCreate(0,name,OBJ_BUTTON,sub_win,0,0);mouse.nameObjectClick="";pro.delet=false;
     pro.xd=xd;pro.yd=yd;pro.xs=xs;pro.ys=ys;pro.name=name;pro.text=text;pro.texttmp=text;
     set.setColorDef(pro);set.setPosiXY(pro,xd,yd);set.setSizeXY(pro,xs,ys);
     set.setText(pro,text,8,clrWhite,"Tahoma Bold");
     set.setColorDefButton(pro);
     //-------------------------------------------
     pro.canMoveWithAll=true;pro.canMoveSelf=true;
   }
//---\\
  void setText(string text){
      pro.text=text;
      ObjectSetString(0,pro.name,OBJPROP_TEXT,pro.text);
  }
//---\\
  bool checkMouse(Button &but[],ButtonType3 &but3[],
                 Label &lab[],ButtonType4 &but4[],
                 ButtonPower &butp[],Rectangle &rec[],
                 ButtonPowerWithTextDown &butPtd[],
                 ButtonPowerWithTextDown2 &butPtd2[],
                 int id,long lparam,double dparam,string sparam){
    bool res=mouse.checkMouseOver(pro,lparam,dparam);if(!res){mouse.nameObjectClick="";return res;}
    //--
    //--move
    if(pro.canMoveSelf){checkMove(pro,but,but3,lab,but4,butp,rec,butPtd,butPtd2,id,lparam,dparam,sparam);}
    //--
    return res;
  }
//---\\
  bool checkMove(
             Property &pro,Button &but[],
             ButtonType3 &but3[],Label &lab[],
             ButtonType4 &but4[],
             ButtonPower &butp[],Rectangle &rec[],
             ButtonPowerWithTextDown &butPtd[],
             ButtonPowerWithTextDown2 &butPtd2[],
             int id,long lparam,double dparam,string sparam){
     if(sparam=="1" && mouse.nameObjectClick=="")
       {
         mouse.nameObjectClick=pro.name;
         mouse.getEkhteleafMouseY(pro,lparam,dparam);
         mouse.getEkhteleafMouseX(pro,lparam,dparam);
         //---button
         for(int i=0;i<ArraySize(but);i++)
           {
               if(but[i].pro.canMoveWithAll){
                  but[i].mouse.getEkhteleafMouseY(but[i].pro,lparam,dparam);
                  but[i].mouse.getEkhteleafMouseX(but[i].pro,lparam,dparam);
               }
           }
         //---button type 3
         for(int i=0;i<ArraySize(but3);i++)
           {
            if(but3[i].pro3.canMoveWithAll)
              {
                  but3[i].mouse.getEkhteleafMouseY(but3[i].pro1,lparam,dparam);
                  but3[i].mouse.getEkhteleafMouseX(but3[i].pro1,lparam,dparam);
                  but3[i].mouse.getEkhteleafMouseY(but3[i].pro2,lparam,dparam);
                  but3[i].mouse.getEkhteleafMouseX(but3[i].pro2,lparam,dparam);
                  but3[i].mouse.getEkhteleafMouseY(but3[i].pro3,lparam,dparam);
                  but3[i].mouse.getEkhteleafMouseX(but3[i].pro3,lparam,dparam);
              }
           }
         //---button type 4
         for(int i=0;i<ArraySize(but4);i++)
           {
            if(but4[i].pro3.canMoveWithAll)
              {
                  but4[i].mouse.getEkhteleafMouseY(but4[i].pro1,lparam,dparam);
                  but4[i].mouse.getEkhteleafMouseX(but4[i].pro1,lparam,dparam);
                  but4[i].mouse.getEkhteleafMouseY(but4[i].pro2,lparam,dparam);
                  but4[i].mouse.getEkhteleafMouseX(but4[i].pro2,lparam,dparam);
                  but4[i].mouse.getEkhteleafMouseY(but4[i].pro3,lparam,dparam);
                  but4[i].mouse.getEkhteleafMouseX(but4[i].pro3,lparam,dparam);
                  but4[i].mouse.getEkhteleafMouseY(but4[i].pro4,lparam,dparam);
                  but4[i].mouse.getEkhteleafMouseX(but4[i].pro4,lparam,dparam);
              }
           }
         //---Label
         for(int i=0;i<ArraySize(lab);i++)
           {
               if(lab[i].pro.canMoveWithAll){
                  lab[i].mouse.getEkhteleafMouseY(lab[i].pro,lparam,dparam);
                  lab[i].mouse.getEkhteleafMouseX(lab[i].pro,lparam,dparam);
               }
           }
         //--- button power
         for(int i=0;i<ArraySize(butp);i++)
           {
               if(butp[i].pro.canMoveWithAll){
                  butp[i].mouse.getEkhteleafMouseY(butp[i].pro,lparam,dparam);
                  butp[i].mouse.getEkhteleafMouseX(butp[i].pro,lparam,dparam);
               }
           }
         //--- Rectangle
         for(int i=0;i<ArraySize(rec);i++)
           {
               if(rec[i].pro.canMoveWithAll){
                  rec[i].mouse.getEkhteleafMouseY(rec[i].pro,lparam,dparam);
                  rec[i].mouse.getEkhteleafMouseX(rec[i].pro,lparam,dparam);
               }
           }
         //--- Button power text down
         for(int i=0;i<ArraySize(butPtd);i++)
           {
               if(butPtd[i].prot.canMoveWithAll){
                  butPtd[i].mouse.getEkhteleafMouseY(butPtd[i].pro,lparam,dparam);
                  butPtd[i].mouse.getEkhteleafMouseX(butPtd[i].pro,lparam,dparam);
                  butPtd[i].mouse.getEkhteleafMouseY(butPtd[i].prot,lparam,dparam);
                  butPtd[i].mouse.getEkhteleafMouseX(butPtd[i].prot,lparam,dparam);
               }
           }
         //--- Button power text down2
         for(int i=0;i<ArraySize(butPtd2);i++)
           {
               if(butPtd2[i].prot.canMoveWithAll){
                  butPtd2[i].mouse.getEkhteleafMouseY(butPtd2[i].pro1,lparam,dparam);
                  butPtd2[i].mouse.getEkhteleafMouseX(butPtd2[i].pro1,lparam,dparam);
                  butPtd2[i].mouse.getEkhteleafMouseY(butPtd2[i].pro2,lparam,dparam);
                  butPtd2[i].mouse.getEkhteleafMouseX(butPtd2[i].pro2,lparam,dparam);
                  butPtd2[i].mouse.getEkhteleafMouseY(butPtd2[i].prot,lparam,dparam);
                  butPtd2[i].mouse.getEkhteleafMouseX(butPtd2[i].prot,lparam,dparam);
               }
           }
           
           
         //---button  none
       }
     else if (sparam=="1" && mouse.nameObjectClick!="")
       {
          mouse.nameObjectClick="";return false;
       }
    if(mouse.nameObjectClick==pro.name && sparam!="1" ){
       if(checkAllObjectCanMoveXY(pro,but,but3,lab,but4,butp,rec,butPtd,butPtd2,lparam,dparam))
         {
           //--- Button
           for(int i=0;i<ArraySize(but);i++)
             {
              if(but[i].pro.canMoveWithAll)
                {
                  mouse.moveByMouseY(but[i].pro,lparam,dparam );
                  mouse.moveByMouseX(but[i].pro,lparam,dparam );
                }
             }
           //-----  ButtonType3
           for(int i=0;i<ArraySize(but3);i++)
             {
              if(but3[i].pro3.canMoveWithAll)
                {
                  mouse.moveByMouseY(but3[i].pro1,lparam,dparam );
                  mouse.moveByMouseX(but3[i].pro1,lparam,dparam );
                  mouse.moveByMouseY(but3[i].pro2,lparam,dparam );
                  mouse.moveByMouseX(but3[i].pro2,lparam,dparam );
                  mouse.moveByMouseY(but3[i].pro3,lparam,dparam );
                  mouse.moveByMouseX(but3[i].pro3,lparam,dparam );
                }
             }
           //-----  ButtonType4
           for(int i=0;i<ArraySize(but4);i++)
             {
              if(but4[i].pro3.canMoveWithAll)
                {
                  mouse.moveByMouseY(but4[i].pro1,lparam,dparam );
                  mouse.moveByMouseX(but4[i].pro1,lparam,dparam );
                  mouse.moveByMouseY(but4[i].pro2,lparam,dparam );
                  mouse.moveByMouseX(but4[i].pro2,lparam,dparam );
                  mouse.moveByMouseY(but4[i].pro3,lparam,dparam );
                  mouse.moveByMouseX(but4[i].pro3,lparam,dparam );
                  mouse.moveByMouseY(but4[i].pro4,lparam,dparam );
                  mouse.moveByMouseX(but4[i].pro4,lparam,dparam );
                }
             }
           //--- label
           for(int i=0;i<ArraySize(but);i++)
             {
              if(lab[i].pro.canMoveWithAll)
                {
                  mouse.moveByMouseY(lab[i].pro,lparam,dparam );
                  mouse.moveByMouseX(lab[i].pro,lparam,dparam );
                }
             }
           //--- Button power
           for(int i=0;i<ArraySize(butp);i++)
             {
              if(butp[i].pro.canMoveWithAll)
                {
                  mouse.moveByMouseY(butp[i].pro,lparam,dparam );
                  mouse.moveByMouseX(butp[i].pro,lparam,dparam );
                }
             }
           //--- Button power text down
           for(int i=0;i<ArraySize(butPtd);i++)
             {
              if(butPtd[i].pro.canMoveWithAll)
                {
                  mouse.moveByMouseY(butPtd[i].pro,lparam,dparam );
                  mouse.moveByMouseX(butPtd[i].pro,lparam,dparam );
                  mouse.moveByMouseY(butPtd[i].prot,lparam,dparam );
                  mouse.moveByMouseX(butPtd[i].prot,lparam,dparam );
                }
             }
           //--- Button power text down2
           for(int i=0;i<ArraySize(butPtd2);i++)
             {
              if(butPtd2[i].prot.canMoveWithAll)
                {
                  mouse.moveByMouseY(butPtd2[i].pro1,lparam,dparam );
                  mouse.moveByMouseX(butPtd2[i].pro1,lparam,dparam );
                  mouse.moveByMouseY(butPtd2[i].pro2,lparam,dparam );
                  mouse.moveByMouseX(butPtd2[i].pro2,lparam,dparam );
                  mouse.moveByMouseY(butPtd2[i].prot,lparam,dparam );
                  mouse.moveByMouseX(butPtd2[i].prot,lparam,dparam );
                }
             }
           //--- Rectangle 
           for(int i=0;i<ArraySize(rec);i++)
             {
              if(rec[i].pro.canMoveWithAll)
                {
                  mouse.moveByMouseY(rec[i].pro,lparam,dparam );
                  mouse.moveByMouseX(rec[i].pro,lparam,dparam );
                }
             }
            //--- self object 
            mouse.moveByMouseY(pro,lparam,dparam );
            mouse.moveByMouseX(pro,lparam,dparam );
         }
       return true;  
      }
  return false;
  }
//---\\
   bool checkAllObjectCanMoveXY(
             Property &pro,Button &but[],
             ButtonType3 &but3[],
             Label &lab[],ButtonType4 &but4[],
             ButtonPower &butp[],Rectangle &rec[],
             ButtonPowerWithTextDown &butPtd[],
             ButtonPowerWithTextDown2 &butPtd2[],
             int lparam=0,int dparam=0){
     //--        
     mouse.getChartXY();
     //-----------------------  Button
     for(int i=0;i<ArraySize(but);i++)
       {
        if(but[i].pro.canMoveWithAll)
          {
           if(mouse.checkCanMoveY(but[i].pro,lparam,dparam)==false || mouse.checkCanMoveX(but[i].pro,lparam,dparam)==false)
             {
              return false;
             }
          }
       }
     //-----------------------  Button power
     for(int i=0;i<ArraySize(butp);i++)
       {
        if(butp[i].pro.canMoveWithAll)
          {
           if(mouse.checkCanMoveY(butp[i].pro,lparam,dparam)==false || mouse.checkCanMoveX(butp[i].pro,lparam,dparam)==false)
             {
              return false;
             }
          }
       }
     //-----------------------  ButtonType3
     for(int i=0;i<ArraySize(but3);i++)
       {
           if(but3[i].pro1.canMoveWithAll)
             {
              if(mouse.checkCanMoveY(but3[i].pro1,lparam,dparam)==false || mouse.checkCanMoveX(but3[i].pro1,lparam,dparam)==false)
                {
                 return false;
                }
             }
           if(but3[i].pro2.canMoveWithAll)
             {
              if(mouse.checkCanMoveY(but3[i].pro2,lparam,dparam)==false || mouse.checkCanMoveX(but3[i].pro2,lparam,dparam)==false)
                {
                 return false;
                }
             }
           if(but3[i].pro3.canMoveWithAll)
             {
              if(mouse.checkCanMoveY(but3[i].pro3,lparam,dparam)==false || mouse.checkCanMoveX(but3[i].pro3,lparam,dparam)==false)
                {
                 return false;
                }
             }
       }
     //-----------------------  ButtonType4
     for(int i=0;i<ArraySize(but4);i++)
       {
        if(but4[i].pro1.canMoveWithAll)
          {
           if(mouse.checkCanMoveY(but4[i].pro1,lparam,dparam)==false || mouse.checkCanMoveX(but4[i].pro1,lparam,dparam)==false)
             {
              return false;
             }
          }
        if(but4[i].pro2.canMoveWithAll)
          {
           if(mouse.checkCanMoveY(but4[i].pro2,lparam,dparam)==false || mouse.checkCanMoveX(but4[i].pro2,lparam,dparam)==false)
             {
              return false;
             }
          }
        if(but4[i].pro3.canMoveWithAll)
          {
           if(mouse.checkCanMoveY(but4[i].pro3,lparam,dparam)==false || mouse.checkCanMoveX(but4[i].pro3,lparam,dparam)==false)
             {
              return false;
             }
          }
        if(but4[i].pro4.canMoveWithAll)
          {
           if(mouse.checkCanMoveY(but4[i].pro4,lparam,dparam)==false || mouse.checkCanMoveX(but4[i].pro4,lparam,dparam)==false)
             {
              return false;
             }
          }
       }
     //-----------------------  Label
     for(int i=0;i<ArraySize(lab);i++)
       {
        if(lab[i].pro.canMoveWithAll)
          {
           if(mouse.checkCanMoveY(lab[i].pro,lparam,dparam)==false || mouse.checkCanMoveX(lab[i].pro,lparam,dparam)==false)
             {
              return false;
             }
          }
       }
     //-----------------------  Rectangle
     for(int i=0;i<ArraySize(rec);i++)
       {
        if(rec[i].pro.canMoveWithAll)
          {
           if(mouse.checkCanMoveY(rec[i].pro,lparam,dparam)==false || mouse.checkCanMoveX(rec[i].pro,lparam,dparam)==false)
             {
              return false;
             }
          }
       }
     //-----------------------  ButtonPowerWithTextDown
     for(int i=0;i<ArraySize(butPtd);i++)
       {
        if(butPtd[i].pro.canMoveWithAll)
          {
           if(mouse.checkCanMoveY(butPtd[i].pro,lparam,dparam)==false || mouse.checkCanMoveX(butPtd[i].pro,lparam,dparam)==false)
             {
              return false;
             }
          }
        if(butPtd[i].prot.canMoveWithAll)
          {
           if(mouse.checkCanMoveY(butPtd[i].prot,lparam,dparam)==false || mouse.checkCanMoveX(butPtd[i].prot,lparam,dparam)==false)
             {
              return false;
             }
          }
       }
     //-----------------------  ButtonPowerWithTextDown2
     for(int i=0;i<ArraySize(butPtd2);i++)
       {
        if(butPtd2[i].pro1.canMoveWithAll)
          {
           if(mouse.checkCanMoveY(butPtd2[i].pro1,lparam,dparam)==false || mouse.checkCanMoveX(butPtd2[i].pro1,lparam,dparam)==false)
             {
              return false;
             }
          }
        if(butPtd2[i].pro2.canMoveWithAll)
          {
           if(mouse.checkCanMoveY(butPtd2[i].pro2,lparam,dparam)==false || mouse.checkCanMoveX(butPtd2[i].pro2,lparam,dparam)==false)
             {
              return false;
             }
          }
        if(butPtd2[i].prot.canMoveWithAll)
          {
           if(mouse.checkCanMoveY(butPtd2[i].prot,lparam,dparam)==false || mouse.checkCanMoveX(butPtd2[i].prot,lparam,dparam)==false)
             {
              return false;
             }
          }
       }
       
     //---------------------------  self
     if(mouse.checkCanMoveY(pro,lparam,dparam)==false || mouse.checkCanMoveX(pro,lparam,dparam)==false)
       {
         return false;
       }
      //-----
      return true;
   }
};




//---------------------------------------------------------------------------------
struct ControlMouse{
int tmp;
   void checkMouse(
            ButtonMoveAll &butML,
            Button &but[],ButtonType3 &but3[],
            Label &lab[],ButtonType4 &but4[],
            ButtonPower &butp[],Rectangle &rec[],
            ButtonPowerWithTextDown &butPtd[],ButtonPowerWithTextDown2 &butPtd2[],
            int id,long lparam,double dparam,string sparam){
    bool done=false;
    while(!done){
      //-------move all
      butML.checkMouse(but,but3,lab,but4,butp,rec,butPtd,butPtd2,id,lparam,dparam,sparam);
    
      //-------button
      for(int i=0;i<ArraySize(but);i++){if(but[i].checkMouse(id,lparam,dparam,sparam)){done=true;break;};}
      if(done){break;}
      //-------button type3
      for(int i=0;i<ArraySize(but3);i++){if(but3[i].checkMouse(id,lparam,dparam,sparam)){done=true;break;};}
      if(done){break;}
      //-------button label
      for(int i=0;i<ArraySize(lab);i++){if(lab[i].checkMouse(id,lparam,dparam,sparam)){done=true;break;};}
      if(done){break;}
      //-------button type4
      for(int i=0;i<ArraySize(but4);i++){if(but4[i].checkMouse(id,lparam,dparam,sparam)){done=true;break;};}
      if(done){break;}
      //-------button power
      for(int i=0;i<ArraySize(butp);i++){if(butp[i].checkMouse(id,lparam,dparam,sparam)){done=true;break;};}
      if(done){break;}
      //-------Rectangle
      for(int i=0;i<ArraySize(rec);i++){if(rec[i].checkMouse(id,lparam,dparam,sparam)){done=true;break;};}
      if(done){break;}
      //-------ButtonPowerWithTextDown
      for(int i=0;i<ArraySize(butPtd);i++){if(butPtd[i].checkMouse(id,lparam,dparam,sparam)){done=true;break;};}
      if(done){break;}
      //-------ButtonPowerWithTextDown2
      for(int i=0;i<ArraySize(butPtd2);i++){if(butPtd2[i].checkMouse(id,lparam,dparam,sparam)){done=true;break;};}
      if(done){break;}
      
      //-----------
      break;
    } 
   }
};
//---------------------------------------------------------------------------------
string CreatRandomName(){
  return  string(MathRand())+""+string(MathRand())+""+string(MathRand()) ;
}
//---------------------------------------------------------------------------------
};

Triangle4 tris4[];
Triangle4 tris4_1[];
Triangle4 tris4_r[];
Button but[14];

Object3 obj3;

double getZig(int ib,double &arr[],int &arrb[],int back=1,int st1=12,int st2=5,int st3=3){
 int cnt=0;ArrayResize(arr,back);ArrayResize(arrb,back);
 for(int i=ib;i<Bars+1;i++)
   {
    double ZigZagHigh=iCustom(Symbol(), 0, "ZigZag", st1,st2,st3,0, i);
    if(ZigZagHigh!=0){
      arr[cnt]=ZigZagHigh;arrb[cnt]=i;
      cnt++;
      if(cnt==back){return ZigZagHigh;}
     }
   }
   return 0;}
//--------------------------------------------
bool checkT1(int ib,double &arr[],int &arrb[]){
getZig(ib,arr,arrb,5,12,5,3);
//---------------------------------------------- 
double AX=MathAbs(arr[4]-arr[3]);//-------------
double AB=MathAbs(arr[3]-arr[2]);
double BC=MathAbs(arr[2]-arr[1]);
double CD=MathAbs(arr[1]-arr[0]);
double AD=MathAbs(arr[0]-arr[3]);
if(AX==0|| AB==0 || BC==0){return false;}
//----------
bool res1=false;bool res2=false;bool res3=false;bool res4=false;
//----------------------------------------------                                 
if( (AB/AX)<=(ab+ab*tolerans) && (AB/AX)>=(ab-ab*tolerans) ){res1=true;}
if( (BC/AB)<=(bc+bc*tolerans) && (BC/AB)>=(bc-bc*tolerans) ){res2=true;}
if( (CD/BC)<=(cd+cd*tolerans) && (CD/BC)>=(cd-cd*tolerans) ){res3=true;}
if( (AD/AX)<=(xd+xd*tolerans) && (AD/AX)>=(xd-xd*tolerans) ){res4=true;}
//--------------
but[0].setText(NormalizeDouble((AB/AX),2));
but[1].setText(NormalizeDouble((BC/AB),2));
but[2].setText(NormalizeDouble((CD/BC),2));
but[3].setText(NormalizeDouble((AD/AX),2));

if(res1 && res2 && res3 && res4)
  {
      //-----
      obj3.addTriangle4(tris4,
                        arr[0],arr[1],arr[2],arr[2],arr[3],arr[4],
                        Time[arrb[0]],Time[arrb[1]],Time[arrb[2]],
                        Time[arrb[2]],Time[arrb[3]],Time[arrb[4]],
                        clrRed,true,1,3);
      ////---
      obj3.addTriangle4(tris4_r,
                        arr[0],arr[1],arr[2],arr[2],arr[3],arr[4],
                        Time[arrb[0]],Time[arrb[1]],Time[arrb[2]],
                        Time[arrb[2]],Time[arrb[3]],Time[arrb[4]],
                        clrYellow,false,2,1);                
      //-----   
      obj3.checkTriangle4RepeatDelet(tris4_1,arr[2],arr[3],arr[4],Time[arrb[2]],Time[arrb[3]],Time[arrb[4]]);            
      return true;
      //-----  
  }else if(res1 && res2){
      //-----
      double arr1=AX*xd;
      if(arr[4]<arr[3]){arr1=arr[3]-arr1;}
      if(arr[4]>arr[3]){arr1=arr[3]+arr1;}
      obj3.addTriangle4_1(tris4_1,tris4,
                        arr1,arr[1],arr[2],arr[2],arr[3],arr[4],
                        Time[arrb[0]],Time[arrb[1]],Time[arrb[2]],
                        Time[arrb[2]],Time[arrb[3]],Time[arrb[4]],
                        clrRed,false);
      //-----
  }

return false;
}

//--------------------------------------------
bool checkT2(int ib,double &arr[],int &arrb[]){
getZig(ib,arr,arrb,5,24,10,6);
//---------------------------------------------- 
double AX=MathAbs(arr[4]-arr[3]);//-------------
double AB=MathAbs(arr[3]-arr[2]);
double BC=MathAbs(arr[2]-arr[1]);
double CD=MathAbs(arr[1]-arr[0]);
double AD=MathAbs(arr[0]-arr[3]);
if(AX==0|| AB==0 || BC==0){return false;}
//----------
bool res1=false;bool res2=false;bool res3=false;bool res4=false;
//----------------------------------------------                                 
if( (AB/AX)<=(ab+ab*tolerans) && (AB/AX)>=(ab-ab*tolerans) ){res1=true;}
if( (BC/AB)<=(bc+bc*tolerans) && (BC/AB)>=(bc-bc*tolerans) ){res2=true;}
if( (CD/BC)<=(cd+cd*tolerans) && (CD/BC)>=(cd-cd*tolerans) ){res3=true;}
if( (AD/AX)<=(xd+xd*tolerans) && (AD/AX)>=(xd-xd*tolerans) ){res4=true;}
//--------------
but[4].setText(NormalizeDouble((AB/AX),2));
but[5].setText(NormalizeDouble((BC/AB),2));
but[6].setText(NormalizeDouble((CD/BC),2));
but[7].setText(NormalizeDouble((AD/AX),2));
if(res1 && res2 && res3 && res4)
  {
      //-----
      obj3.addTriangle4(tris4,
                        arr[0],arr[1],arr[2],arr[2],arr[3],arr[4],
                        Time[arrb[0]],Time[arrb[1]],Time[arrb[2]],
                        Time[arrb[2]],Time[arrb[3]],Time[arrb[4]],
                        clrDarkGray,true,1,3);
      ////---
      obj3.addTriangle4(tris4_r,
                        arr[0],arr[1],arr[2],arr[2],arr[3],arr[4],
                        Time[arrb[0]],Time[arrb[1]],Time[arrb[2]],
                        Time[arrb[2]],Time[arrb[3]],Time[arrb[4]],
                        clrCrimson,false,2,1);                
      //-----   
      obj3.checkTriangle4RepeatDelet(tris4_1,arr[2],arr[3],arr[4],Time[arrb[2]],Time[arrb[3]],Time[arrb[4]]);            
      return true;
      //-----  
  }else if(res1 && res2){
      //-----
      double arr1=AX*xd;
      if(arr[4]<arr[3]){arr1=arr[3]-arr1;}
      if(arr[4]>arr[3]){arr1=arr[3]+arr1;}
      obj3.addTriangle4_1(tris4_1,tris4,
                        arr1,arr[1],arr[2],arr[2],arr[3],arr[4],
                        Time[arrb[0]],Time[arrb[1]],Time[arrb[2]],
                        Time[arrb[2]],Time[arrb[3]],Time[arrb[4]],
                        clrDarkGray,false);
      //-----
  }

return false;
}

//--------------------------------------------
bool checkT3(int ib,double &arr[],int &arrb[]){
getZig(ib,arr,arrb,5,48,20,12);
//---------------------------------------------- 
double AX=MathAbs(arr[4]-arr[3]);//-------------
double AB=MathAbs(arr[3]-arr[2]);
double BC=MathAbs(arr[2]-arr[1]);
double CD=MathAbs(arr[1]-arr[0]);
double AD=MathAbs(arr[0]-arr[3]);
if(AX==0|| AB==0 || BC==0){return false;}
//----------
bool res1=false;bool res2=false;bool res3=false;bool res4=false;
//----------------------------------------------                                 
if( (AB/AX)<=(ab+ab*tolerans) && (AB/AX)>=(ab-ab*tolerans) ){res1=true;}
if( (BC/AB)<=(bc+bc*tolerans) && (BC/AB)>=(bc-bc*tolerans) ){res2=true;}
if( (CD/BC)<=(cd+cd*tolerans) && (CD/BC)>=(cd-cd*tolerans) ){res3=true;}
if( (AD/AX)<=(xd+xd*tolerans) && (AD/AX)>=(xd-xd*tolerans) ){res4=true;}
//--------------
but[8].setText(NormalizeDouble((AB/AX),2));
but[9].setText(NormalizeDouble((BC/AB),2));
but[10].setText(NormalizeDouble((CD/BC),2));
but[11].setText(NormalizeDouble((AD/AX),2));
if(res1 && res2 && res3 && res4)
  {
      //-----
      obj3.addTriangle4(tris4,
                        arr[0],arr[1],arr[2],arr[2],arr[3],arr[4],
                        Time[arrb[0]],Time[arrb[1]],Time[arrb[2]],
                        Time[arrb[2]],Time[arrb[3]],Time[arrb[4]],
                        clrGreen,true,1,3);
      ////---
      obj3.addTriangle4(tris4_r,
                        arr[0],arr[1],arr[2],arr[2],arr[3],arr[4],
                        Time[arrb[0]],Time[arrb[1]],Time[arrb[2]],
                        Time[arrb[2]],Time[arrb[3]],Time[arrb[4]],
                        clrYellow,false,2,1);                
      //-----   
      obj3.checkTriangle4RepeatDelet(tris4_1,arr[2],arr[3],arr[4],Time[arrb[2]],Time[arrb[3]],Time[arrb[4]]);            
      return true;
      //-----  
  }else if(res1 && res2){
      //-----
      double arr1=AX*xd;
      if(arr[4]<arr[3]){arr1=arr[3]-arr1;}
      if(arr[4]>arr[3]){arr1=arr[3]+arr1;}
      obj3.addTriangle4_1(tris4_1,tris4,
                        arr1,arr[1],arr[2],arr[2],arr[3],arr[4],
                        Time[arrb[0]],Time[arrb[1]],Time[arrb[2]],
                        Time[arrb[2]],Time[arrb[3]],Time[arrb[4]],
                        clrGreen,false);
      //-----
  }

return false;
}

void OnChartEvent(const int id,         // Event ID 
                  const long& lparam,   // Parameter of type long event 
                  const double& dparam, // Parameter of type double event 
                  const string& sparam  // Parameter of type string events 
  ){
  
  if(sparam=="control")
    {
     showHidden();
    }
  
  
  }
  
  
  bool LabelCreate(const long              chart_ID=0,               // chart's ID
                 const string            name="Label",             // label name
                 const int               sub_window=0,             // subwindow index
                 const int               x=0,                      // X coordinate
                 const int               y=0,                      // Y coordinate
                 const ENUM_BASE_CORNER  corner=CORNER_LEFT_UPPER, // chart corner for anchoring
                 const string            text="Label",             // text
                 const string            font="Arial",             // font
                 const int               font_size=10,             // font size
                 const color             clr=clrRed,               // color
                 const double            angle=0.0,                // text slope
                 const ENUM_ANCHOR_POINT anchor=ANCHOR_LEFT_UPPER, // anchor type
                 const bool              back=false,               // in the background
                 const bool              selection=false,          // highlight to move
                 const bool              hidden=true,              // hidden in the object list
                 const long              z_order=0)                // priority for mouse click
  {
//--- reset the error value
   ResetLastError();
//--- create a text label
   if(!ObjectCreate(chart_ID,name,OBJ_LABEL,sub_window,0,0))
     {
      Print(__FUNCTION__,
            ": failed to create text label! Error code = ",GetLastError());
      return(false);
     }
//--- set label coordinates
   ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
   ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
//--- set the chart's corner, relative to which point coordinates are defined
   ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
//--- set the text
   ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
//--- set text font
   ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
//--- set font size
   ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
//--- set the slope angle of the text
   ObjectSetDouble(chart_ID,name,OBJPROP_ANGLE,angle);
//--- set anchor type
   ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor);
//--- set color
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- display in the foreground (false) or background (true)
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- enable (true) or disable (false) the mode of moving the label by mouse
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- set the priority for receiving the event of a mouse click in the chart
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- successful execution
   return(true);
  }