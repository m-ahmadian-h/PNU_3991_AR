//+------------------------------------------------------------------+
//|                                                        Break.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.10"
#property strict
#property indicator_chart_window
//+------------------------------------------------------------------+
double toleranseBreakPips=0;
int st111=24;int st222=10;int st333=6;
double xT=0.0;
//+------------------------------------------------------------------+
double lastZi=0;
int OnInit()
  {
//--- indicator buffers mapping
   getZigZag(0,arr,arrb,2);
   lastZi=arr[1];
   ChartSetInteger(0,CHART_EVENT_MOUSE_MOVE,true);
   HideTestIndicators(true);
   ObjectsDeleteAll();
   //-------
   modelMenu();
   ///--------
   backCheck();
   Comment("SET PERIOD MID");

   if( IsTesting()){
     getChartXY();
     LabelCreate(0,"labelBreak",0,0,y_distance-40,0,"Menu not work in Tester!");
   }
  for(int i=1;i<100;i++)
    {
     xT=i;
    }
//---
   return(INIT_SUCCEEDED);
  }
  
  int deinit()
  {
    Comment("");
    ObjectsDeleteAll();
   return(INIT_SUCCEEDED);
  }
  
void backCheck(){
   for(int i=1;i<2000;i++)
     {
      getZigZag(i,arr,arrb,2);
      if(lastZi!=arr[1])
        {
         checkBreakOfflineInvers(i,0,1);
        }
     }
}
  
  
  
  
  
bool alram=false;
bool notic=false;
string setPeri="PERIOD MID";
void OnChartEvent(const int id,         // Event ID 
                  const long& lparam,   // Parameter of type long event 
                  const double& dparam, // Parameter of type double event 
                  const string& sparam  // Parameter of type string events
                   )
 {
 //----------
 obj4.checkMouse(id,lparam,dparam,sparam);
 if(sparam=="btr_show")
   {
    obj4.buttonRailDownRight[0].showHiddenRailTime("Panel","HidPanel",5,5);
   }
 if(sparam=="btr_d1")
   {
    ObjectsDeleteAll();
    obj4.buttonRailDownRight[0].hidden();
    obj4.buttonRailDownRight[0].show();
    st111=12;st222=5;st333=3;
    backCheck();
    setPeri="SET PERIOD : SHORT";
   }
 if(sparam=="btr_d2")
   {
    ObjectsDeleteAll();
    obj4.buttonRailDownRight[0].hidden();
    obj4.buttonRailDownRight[0].show();
    st111=24;st222=10;st333=6;
    backCheck();
    setPeri="SET PERIOD : MID";
   }
 if(sparam=="btr_d3")
   {
    ObjectsDeleteAll();
    obj4.buttonRailDownRight[0].hidden();
    obj4.buttonRailDownRight[0].show();
    st111=48;st222=20;st333=12;
    backCheck();
    setPeri="SET PERIOD : LONG";
   }
 if(sparam=="btr_r1")
   {
    if(alram){alram=false;obj4.buttonRailDownRight[0].setTextRight(1,"alarmOff");} 
    else{alram=true;obj4.buttonRailDownRight[0].setTextRight(1,"alarmOn");}
   }
 if(sparam=="btr_r2")
   {
    if(notic){notic=false;obj4.buttonRailDownRight[0].setTextRight(2,"noticOff");} 
    else{notic=true;obj4.buttonRailDownRight[0].setTextRight(2,"noticOn");}
   }
 Comment(setPeri+"\n"+"ALARM IS : "+alram+"\n"+"NOTIFICATION IS : "+notic);  
}
  
void modelMenu(){
   ArrayResize(obj4.buttonRailDownRight,1);
   //-------
   obj4.buttonRailDownRight[0].creat("btr",250,0,90,30,"buttR",3,2);
   obj4.buttonRailDownRight[0].setTextDown(1,"short");
   obj4.buttonRailDownRight[0].setTextDown(2,"mid");
   obj4.buttonRailDownRight[0].setTextDown(3,"long");
   obj4.buttonRailDownRight[0].setTextRight(1,"alarmOff");
   obj4.buttonRailDownRight[0].setTextRight(2,"noticOff");
   obj4.buttonRailDownRight[0].hiddenRail();
   obj4.set.setColor(obj4.buttonRailDownRight[0].pros[0],C'255,204,51',clrIndigo,clrBlack);
   obj4.set.setColor(obj4.buttonRailDownRight[0].pros[1],C'255,51,102',clrDarkOliveGreen,clrBlack);
   obj4.set.setColor(obj4.buttonRailDownRight[0].pros[2],C'255,255,204',clrCadetBlue,clrBlack);
   obj4.set.setColor(obj4.buttonRailDownRight[0].pros[3],C'51,51,153',clrTurquoise,clrBlack);
   obj4.set.setColor(obj4.buttonRailDownRight[0].pros[4],C'51,51,153',C'204,204,153',clrBlack);
   obj4.set.setColor(obj4.buttonRailDownRight[0].pros[5],C'51,51,153',C'255,204,51',clrBlack);
}  
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
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
   getZigZag(0,arr,arrb,2);
   if(lastZi!=arr[1])
     {
      checkBreakOnline(0);
     }
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
double arr[];
int arrb[]; 
double getZigZag(int ib,double &arr[],int &arrb[],int back=1){
 int cnt=0;
 ArrayResize(arr,back);
 ArrayResize(arrb,back);
 for(int i=ib;i<Bars+1;i++)
   {
    double ZigZagHigh=iCustom(Symbol(), 0, "ZigZag", st111,st222,st333,0, i);
    if(ZigZagHigh!=0){
      arr[cnt]=ZigZagHigh;
      arrb[cnt]=i;
      cnt++;
      if(cnt==back){return ZigZagHigh;}
     }
   }
   return 0;}
//+------------------------------------------------------------------+
datetime lastBreaktime=0;
double lastBreakprice=0; 

string checkBreakOnline(int ib=1){
  getZigZag(ib,arr,arrb,4);
  if(arr[0]>arr[2]+toleranseBreakPips*Point && arr[0]>arr[1] && (lastBreaktime!=Time[arrb[2]] && lastBreakprice!=arr[2]) )
    {
        //arr[0]=arr[0]+toleranseBreakPips*Point;
        //--
        
        //--  
        obj.ArrowUpCreate(Time[ib],arr[2],clrBlue,1);
        obj.TrendCreate(Time[arrb[2]],arr[2],Time[ib],arr[2],clrBlue,1,3);//--break
        obj.TrendCreate(Time[ib+2],arr[0],Time[ib],arr[0],clrBlue,3);
        double tp=arr[0]-MathAbs(arr[0]-arr[1]);
        double sl=arr[0]+MathAbs(arr[0]-arr[1]);
        //obj.RectangleCreate( Time[ib],arr[0],Time[ib+3],sl,0,clrBlue);//--sl
        //obj.RectangleCreate( Time[ib],arr[0],Time[ib+3],tp,0,clrBlue);//--tp
        //obj.TrendCreate(Time[ib],tp,Time[ib+2],tp,clrBlue);//--tp
        //obj.TrendCreate(Time[ib],sl,Time[ib+2],sl,clrBlue);//--sl
        //obj.TrendCreate(Time[ib],arr[0],Time[ib],tp,clrSilver,1,2);//--tp
        //obj.TrendCreate(Time[ib],arr[0],Time[ib],sl,clrSilver,1,2);//--sl
        obj.TrendCreate(Time[arrb[0]],arr[0],Time[arrb[1]],arr[1],clrBlue,1,2);
        obj.TextCreate("BreakUp",Time[ib],arr[0],clrBlue);
        //---------------------
        lastBreaktime=Time[arrb[2]];
        lastBreakprice=arr[2];
        string res="";//checkTpSlPrice(arrb[0],arr[0],"sell",tp,sl,sperd,rr);
        //---
        if(alram){Alert ( "break long  "+Time[arrb[0]]+"  "+Symbol()+" "+timeFrame() );}
        if(notic){SendNotification("break long  "+Time[arrb[0]]+"  "+Symbol()+" "+timeFrame());}
        return res;
    }
  else
  if(arr[0]<arr[2]-toleranseBreakPips*Point && arr[0]<arr[1] && (lastBreaktime!=Time[arrb[2]] && lastBreakprice!=arr[2]) )
    {
     //arr[0]=arr[0]-toleranseBreakPips*Point;
     //--

     //--  
     obj.ArrowDownCreate(Time[ib],arr[2],clrRed,1);
     obj.TrendCreate(Time[arrb[2]],arr[2],Time[ib],arr[2],clrRed,1,3);//--break
     obj.TrendCreate(Time[ib+2],arr[0],Time[ib],arr[0],clrRed,3);
     double tp=arr[0]+MathAbs(arr[0]-arr[1]);
     double sl=arr[0]-MathAbs(arr[0]-arr[1]);
     //obj.RectangleCreate( Time[ib],arr[0],Time[ib+3],sl,0,clrRed);//--sl
     //obj.RectangleCreate( Time[ib],arr[0],Time[ib+3],tp,0,clrRed);//--tp
     //obj.TrendCreate(Time[ib],tp,Time[ib+2],tp,clrRed);//--tp
     //obj.TrendCreate(Time[ib],sl,Time[ib+2],sl,clrRed);//--sl
     //obj.TrendCreate(Time[ib],arr[0],Time[ib],tp,clrSilver,1,2);//--tp
     //obj.TrendCreate(Time[ib],arr[0],Time[ib],sl,clrSilver,1,2);//--sl
     obj.TrendCreate(Time[arrb[0]],arr[0],Time[arrb[1]],arr[1],clrRed,1,2);
     obj.TextCreate("BreakDown",Time[ib],arr[0],clrRed);
     //---------------------
     lastBreaktime=Time[arrb[2]];
     lastBreakprice=arr[2];
     //---
     string res="";//checkTpSlPrice(arrb[0],arr[0],"buy",tp,sl,sperd,rr);
     //---
     if(alram){Alert ( "break short  "+Time[arrb[0]]+"  "+Symbol()+" "+timeFrame() );}
     if(notic){SendNotification("break short  "+Time[arrb[0]]+"  "+Symbol()+" "+timeFrame());}
     return res;
    }
  return "";
}

string timeFrame(){
if(Period()>=60 && Period()<1440) {return Period()/60+"H";}
if(Period()==1440) {return (Period()/60)/24+"D";} 
if(Period()==10080) {return 1+"W";}
if(Period()==43200){return 1+"MN";}
return Period()+"M";
}


string checkBreakOfflineInvers(int ib=1,double sperd=10,int rr=1){
  getZigZag(ib,arr,arrb,4);
  if(arr[0]>arr[2]+toleranseBreakPips*Point && arr[0]>arr[1] && (lastBreaktime!=Time[arrb[2]] && lastBreakprice!=arr[2]) )
    {
     arr[0]=arr[0]+toleranseBreakPips*Point;
     //--
     for(int i=arrb[1]-1;i>=arrb[0];i--)
       {
        if(High[i]>arr[2]){arr[0]=arr[2];arrb[0]=i;ib=i;break;}
       }
     
     //--  
     obj.ArrowUpCreate(Time[ib],arr[2],clrBlue,1);
     obj.TrendCreate(Time[arrb[2]],arr[2],Time[ib],arr[2],clrBlue,1,2);//--break
     obj.TrendCreate(Time[ib+2],arr[2],Time[ib],arr[2],clrBlue,3);
     double tp=arr[0]-MathAbs(arr[0]-arr[1]);
     double sl=arr[0]+MathAbs(arr[0]-arr[1]);
     //obj.RectangleCreate( Time[ib],arr[0],Time[ib+3],sl,0,clrBlue);//--sl
     //obj.RectangleCreate( Time[ib],arr[0],Time[ib+3],tp,0,clrBlue);//--tp
     //obj.TrendCreate(Time[ib],tp,Time[ib+2],tp,clrBlue);//--tp
     //obj.TrendCreate(Time[ib],sl,Time[ib+2],sl,clrBlue);//--sl
     //obj.TrendCreate(Time[ib],arr[0],Time[ib],tp,clrSilver,1,2);//--tp
     //obj.TrendCreate(Time[ib],arr[0],Time[ib],sl,clrSilver,1,2);//--sl
     obj.TextCreate("BreakUp",Time[ib],arr[0],clrBlue);
     //---------------------
     lastBreaktime=Time[arrb[2]];
     lastBreakprice=arr[2];
     string res="";//checkTpSlPrice(arrb[0],arr[0],"sell",tp,sl,sperd,rr);
     //---
     return res;
    }
  else
  if(arr[0]<arr[2]-toleranseBreakPips*Point && arr[0]<arr[1] && (lastBreaktime!=Time[arrb[2]] && lastBreakprice!=arr[2]) )
    {
     arr[0]=arr[0]-toleranseBreakPips*Point;
     //--
     for(int i=arrb[1]-1;i>=arrb[0];i--)
       {
        if(Low[i]<arr[2]){arr[0]=arr[2];arrb[0]=i;ib=i;break;}
       }
     //--  
     obj.ArrowDownCreate(Time[ib],arr[2],clrRed,1);
     obj.TrendCreate(Time[arrb[2]],arr[2],Time[ib],arr[2],clrRed,1,2);//--break
     obj.TrendCreate(Time[ib+2],arr[2],Time[ib],arr[2],clrRed,3);
     double tp=arr[0]+MathAbs(arr[0]-arr[1]);
     double sl=arr[0]-MathAbs(arr[0]-arr[1]);
     
     //obj.RectangleCreate( Time[ib],arr[0],Time[ib+3],sl,0,clrRed);//--sl
     //obj.RectangleCreate( Time[ib],arr[0],Time[ib+3],tp,0,clrRed);//--tp
     //obj.TrendCreate(Time[ib],tp,Time[ib+2],tp,clrRed);//--tp
     //obj.TrendCreate(Time[ib],sl,Time[ib+2],sl,clrRed);//--sl
     //obj.TrendCreate(Time[ib],arr[0],Time[ib],tp,clrSilver,1,2);//--tp
     //obj.TrendCreate(Time[ib],arr[0],Time[ib],sl,clrSilver,1,2);//--sl
     obj.TextCreate("BreakDown",Time[ib],arr[0],clrRed);
     //---------------------
     lastBreaktime=Time[arrb[2]];
     lastBreakprice=arr[2];
     //---
     string res="";//checkTpSlPrice(arrb[0],arr[0],"buy",tp,sl,sperd,rr);
     return res;
    }
  return "";
}
//+------------------------------------------------------------------+
struct Object4{
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
   color colorTexttmp;color colorBacktmp;color colorBordertmp;
   color MouseOverColorText;color MouseOverColorBack;color MouseOverColorBorder;
   bool enableMouseOver;bool delet;bool canMoveWithAll;bool canMoveSelf;
   bool hidden;
   int ekhMX;int ekhMY;
   double price1;
   double price2;
   double price3;
   datetime time1;
   datetime time2;
   datetime time3;
   int sub_win;
   bool back;
   ENUM_OBJECT object_type;  
};
//---------------------------------------------------------------------------------
struct SetObject{
   int tmp;
   void setPosiXY(Property &pro,int xd,int yd){
       pro.xd=xd;pro.yd=yd;pro.xdtmp=xd;pro.ydtmp=yd;
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
      pro.text=text;pro.texttmp=text;pro.fontSize=fontSize;pro.colorText=colorText;pro.font=font;
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
   void setHidden(Property &pro){
      pro.hidden=true;pro.delet=true;ObjectDelete(0,pro.name);
   }
   //---\\
   void setHiddens(Property &pros[]){
     for(int i=0;i<ArraySize(pros);i++)
       {
         if(pros[i].hidden==false)
           {
             setHidden(pros[i]);
           }
       }
   }
   //---\\
   void setDelete(Property &pro){
     getSetPosiXY(pro);ObjectDelete(0,pro.name);pro.delet=true;pro.hidden=true;
   }
   //---\\
   void setMove(Property &pros[]){
     for(int i=0;i<ArraySize(pros);i++){pros[i].canMoveSelf=true;}      
   }
   void setMoveWithAll(Property &pros[]){
     for(int i=0;i<ArraySize(pros);i++)  {pros[i].canMoveWithAll=true;}
   }
   //---\\
   void setDeletes(Property &pros[]){
     for(int i=0;i<ArraySize(pros);i++){ObjectDelete(0,pros[i].name);pros[i].delet=true;pros[i].hidden=true;} 
   }
   //---\\
   void setShow(Property &pro){
      pro.delet=false;pro.hidden=false;
      ObjectCreate(0,pro.name,OBJ_BUTTON,pro.sub_win,0,0);
      setPosiXY(pro,pro.xd,pro.yd);
      setColor(pro,pro.colorText,pro.colorBack,pro.colorBorder);
      setText(pro,pro.text,pro.fontSize,pro.colorText,pro.font);
      setSizeXY(pro,pro.xs,pro.ys);
   }
   //---\\
   void setShows(Property &pros[]){
      for(int i=0;i<ArraySize(pros);i++)
        {
         if(pros[i].hidden)
           {
             setShow(pros[i]);
           }
        }
   }
   //---\\
   void setGoPosXY(Property &pro,int posX1=1,int posY1=1,int posX2=1,int posY2=1,int timeSleep=10){
     setPosiXY(pro,posX1,posY1);
     int stepX=-1;
     int stepY=-1;
     if(posY1<posY2){stepY=+1;}
     if(posX1<posX2){stepX=+1;}
     
     while(posY1!=posY2 || posX1!=posX2){
          if(posY1!=posY2){posY1=posY1+stepY;}
          if(posX1!=posX2){posX1=posX1+stepX;}
          ObjectSetInteger(0,pro.name,OBJPROP_YDISTANCE,posY1);
          ObjectSetInteger(0,pro.name,OBJPROP_XDISTANCE,posX1);
          Sleep(timeSleep);
          ChartRedraw();
       }
    getSetPosiXY(pro);
   }
   
   void getSetPosiXY(Property &pro){
     pro.yd=ObjectGetInteger(0,pro.name,OBJPROP_YDISTANCE);
     pro.xd=ObjectGetInteger(0,pro.name,OBJPROP_XDISTANCE);
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
   void getEkhteleafMouseXY(Property &pro,int lparam,int dparam){
     pro.ekhMY=(dparam-getTop(pro));
     pro.ekhMX=(lparam-getLeft(pro));
   }
//---\\
   bool checkMouseOver(Property &pro,int lparam,int dparam){
     if(!pro.enableMouseOver || pro.delet || pro.hidden){return false;}
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
   void moveByMouseXY(Property &pro,int lparam=0,int dparam=0){
     if(checkCanMoveX(pro,lparam,dparam))
       {
          ObjectSetInteger(0,pro.name,OBJPROP_XDISTANCE,lparam-pro.ekhMX);
          pro.xd=lparam-pro.ekhMX;
       }
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
   bool checkObjectsCanMoveXY(Property &pros[],int lparam=0,int dparam=0){
     getChartXY();
     for(int i=0;i<ArraySize(pros);i++)
       {
        if(checkCanMoveY(pros[i],lparam,dparam)==false || checkCanMoveX(pros[i],lparam,dparam)==false)
          {
           return false;
          }
       }
      return true;
   }
   

};

//---------------------------------------------------------------------------------
struct Button{
   Property pros[];
   SetObject set;
   Mouse mouse;
   bool resM[];
//---\\---------
 void creat(string name,int xd,int yd,int xs,int ys,string text="Button",int sub_win=0,bool back=false){
     ArrayResize(pros,1);ArrayResize(resM,ArraySize(pros));int id;
     //---------- id 0  --- button----------------
     id=0;pros[id].name=name;pros[id].object_type=OBJ_BUTTON;
     pros[id].back=back;
     pros[id].sub_win=sub_win;pros[id].delet=false;pros[id].canMoveSelf=false;
     mouse.nameObjectClick="";pros[id].canMoveWithAll=false;pros[id].hidden=false;
     ObjectCreate(0,pros[id].name,pros[id].object_type,pros[id].sub_win,0,0);
     pros[id].xd=xd;pros[id].yd=yd;pros[id].xs=xs;pros[id].ys=ys;pros[id].text=text;
     set.setColorDef(pros[id]);
     set.setPosiXY(pros[id],pros[id].xd,pros[id].yd);
     set.setSizeXY(pros[id],pros[id].xs,pros[id].ys);
     set.setText(pros[id],pros[id].text,10,clrWhite,"Tahoma Bold");
     set.setColorDefButton(pros[id]);
     ObjectSetInteger(0,pros[id].name,OBJPROP_BACK,pros[id].back);
     //-------------------------------------------
   }
//---\\---------
 void delet(){set.setDeletes(pros);} 
//---\\---------
 bool checkMouse(int id,long lparam,double dparam,string sparam){
    if(!chM(lparam,dparam)){return false;}
    //--
    //--move id 0
    if(pros[0].canMoveSelf && resM[0]){moveObj(id,lparam,dparam,sparam);}
    //--move id other
    
    return true;
 }
//---\\---------
 void hidden(){
  set.setHiddens(pros);
 }
 void show(){
   set.setShows(pros);
 }
//---\\---------
 bool chM(long lparam,double dparam){
    for(int i=0;i<ArraySize(resM);i++) {resM[i]=false;}  
    for(int i=0;i<ArraySize(resM);i++)
      {
       resM[i]=mouse.checkMouseOver(pros[i],lparam,dparam);
       if(resM[i]){return resM[i];}
      }
     mouse.nameObjectClick=""; 
     return false; 
  }
//---\\---------
 void moveObj(int id,long lparam,double dparam,string sparam){
    if(mouse.checkObjectsCanMoveXY(pros,lparam,dparam)){checkMove(pros[0],id,lparam,dparam,sparam);} 
  }
//---\\---------
 void setMove(){set.setMove(pros);}
 void setMoveWithAll(){set.setMoveWithAll(pros);}
//---\\---------
 void getgetEkhteleafMouseXY(long lparam,double dparam){
   for(int i=0;i<ArraySize(pros);i++){mouse.getEkhteleafMouseXY(pros[i],lparam,dparam); }
  }
 void moveByMouseXY(long lparam,double dparam){
   for(int i=0;i<ArraySize(pros);i++) {mouse.moveByMouseXY(pros[i],lparam,dparam);} 
  }
//---\\---------
 void setText(string text){
    pros[0].text=text;ObjectSetString(0,pros[0].name,OBJPROP_TEXT,pros[0].text);
  }
//---\\---------
 bool checkMove(Property &pro,int id,long lparam,double dparam,string sparam){
     if(sparam=="1" && mouse.nameObjectClick=="")
       {
         mouse.nameObjectClick=pro.name;
         getgetEkhteleafMouseXY(lparam,dparam);
       }
     else if (sparam=="1" && mouse.nameObjectClick!="")
       {
         mouse.nameObjectClick="";return false;
       }
    if(mouse.nameObjectClick==pro.name && sparam!="1" ){
       if(mouse.checkObjectsCanMoveXY(pros,lparam,dparam))
         {
           moveByMouseXY(lparam,dparam);
         }
       return true;  
      }
  return false;
  }
};
//---------------------------------------------------------------------------------
struct ButtonRail{
   Property pros[];
   SetObject set;
   Mouse mouse;
   bool resM[];
//---\\---------
 void creat(string name,int xd,int yd,int xs,int ys,string text="Button",int tedRail=3,int sub_win=0,bool back=false){
     ArrayResize(pros,tedRail+1);ArrayResize(resM,ArraySize(pros));int id;
     //---------- id 0  --- button----------------
     id=0;pros[id].name=name+"_show";pros[id].object_type=OBJ_BUTTON;
     pros[id].back=back;
     pros[id].sub_win=sub_win;pros[id].delet=false;pros[id].canMoveSelf=false;
     mouse.nameObjectClick="";pros[id].canMoveWithAll=false;pros[id].hidden=false;
     ObjectCreate(0,pros[id].name,pros[id].object_type,pros[id].sub_win,0,0);
     pros[id].xd=xd;pros[id].yd=yd;pros[id].xs=xs;pros[id].ys=ys;pros[id].text="show";
     set.setColorDef(pros[id]);
     set.setPosiXY(pros[id],pros[id].xd,pros[id].yd);
     set.setSizeXY(pros[id],pros[id].xs,pros[id].ys);
     set.setText(pros[id],pros[id].text,10,clrWhite,"Tahoma Bold");
     set.setColorDefButton(pros[id]);
     ObjectSetInteger(0,pros[id].name,OBJPROP_BACK,pros[id].back);
     //---------- id 1  --- button----------------
     for(int i=1;i<=tedRail;i++)
       {
        yd=yd+ys+1;
        id=i;pros[id].name=name+"_"+i;pros[id].object_type=OBJ_BUTTON;
        pros[id].back=back;
        pros[id].sub_win=sub_win;pros[id].delet=false;pros[id].canMoveSelf=false;
        mouse.nameObjectClick="";pros[id].canMoveWithAll=false;pros[id].hidden=false;
        ObjectCreate(0,pros[id].name,pros[id].object_type,pros[id].sub_win,0,0);
        pros[id].xd=xd;pros[id].yd=yd;pros[id].xs=xs;pros[id].ys=ys;pros[id].text=text+i;
        set.setColorDef(pros[id]);
        set.setPosiXY(pros[id],pros[id].xd,pros[id].yd);
        set.setSizeXY(pros[id],pros[id].xs,pros[id].ys);
        set.setText(pros[id],pros[id].text,10,clrWhite,"Tahoma Bold");
        set.setColorDefButton(pros[id]);
        ObjectSetInteger(0,pros[id].name,OBJPROP_BACK,pros[id].back);
        set.setHidden(pros[id]);
       }
   }
//---\\---------
 void delet(){set.setDeletes(pros);} 
//---\\---------
 bool checkMouse(int id,long lparam,double dparam,string sparam){
    if(!chM(lparam,dparam)){return false;}
    //--
    //--move id 0
    if(pros[0].canMoveSelf && resM[0]){moveObj(id,lparam,dparam,sparam);}
    //--move id other
    
    return true;
 }
//---\\---------
 void hidden(){
  set.setHiddens(pros);
 }
 void show(){
   set.setShows(pros);
 }
//---\\---------
 void hiddenRail(string sh="Show"){
  for(int i=1;i<ArraySize(pros);i++)
    {
      set.setHidden(pros[i]);
    }
  setText(0,sh);  
 }
 void showRail(string hid="Hidden"){
  set.getSetPosiXY(pros[0]);
  for(int i=1;i<ArraySize(pros);i++)
    {
      pros[i].yd=pros[i-1].yd+1+pros[i].ys;
      pros[i].xd=pros[0].xd;
      set.setShow(pros[i]);
    }
  setText(0,hid);  
 }
 void showHiddenRail(string sh="Show",string hid="Hidden"){
  set.getSetPosiXY(pros[0]);
  if(pros[1].hidden)
    {
     showRail(hid);
    }else{
     hiddenRail(sh);  
    }
 }
 
 void showHiddenRailTime(string sh="Show",string hid="Hidden"){
  set.getSetPosiXY(pros[0]);
  if(pros[1].hidden)
    {
     for(int i=1;i<ArraySize(pros);i++)
       {
        pros[i].yd=pros[i-1].yd+1+pros[i].ys;
        pros[i].xd=pros[0].xd;
        set.setShow(pros[i]);
        set.setGoPosXY(pros[i],pros[0].xd,pros[0].yd,pros[i].xd,pros[i].yd,7);
       }
       setText(0,hid);
    }else{
     for(int i=1;i<ArraySize(pros);i++)
       {
        set.getSetPosiXY(pros[i]);
        set.setGoPosXY(pros[i],pros[i].xd,pros[i].yd,pros[0].xd,pros[0].yd,7);
        set.setHidden(pros[i]);
       }
     setText(0,sh);
    }
 }
 
//---\\---------
 bool chM(long lparam,double dparam){
    for(int i=0;i<ArraySize(resM);i++) {resM[i]=false;}  
    for(int i=0;i<ArraySize(resM);i++)
      {
       resM[i]=mouse.checkMouseOver(pros[i],lparam,dparam);
       if(resM[i]){return resM[i];}
      }
     mouse.nameObjectClick=""; 
     return false; 
  }
//---\\---------
 void moveObj(int id,long lparam,double dparam,string sparam){
    if(mouse.checkObjectsCanMoveXY(pros,lparam,dparam)){checkMove(pros[0],id,lparam,dparam,sparam);} 
  }
//---\\---------
 void setMove(){set.setMove(pros);}
 void setMoveWithAll(){set.setMoveWithAll(pros);}
//---\\---------
 void getgetEkhteleafMouseXY(long lparam,double dparam){
   for(int i=0;i<ArraySize(pros);i++){mouse.getEkhteleafMouseXY(pros[i],lparam,dparam); }
  }
 void moveByMouseXY(long lparam,double dparam){
   for(int i=0;i<ArraySize(pros);i++) {mouse.moveByMouseXY(pros[i],lparam,dparam);} 
  }
//---\\---------
 void setText(int id,string text){
    pros[id].text=text;ObjectSetString(0,pros[id].name,OBJPROP_TEXT,pros[id].text);
  }
//---\\---------
 bool checkMove(Property &pro,int id,long lparam,double dparam,string sparam){
     if(sparam=="1" && mouse.nameObjectClick=="")
       {
         mouse.nameObjectClick=pro.name;
         getgetEkhteleafMouseXY(lparam,dparam);
       }
     else if (sparam=="1" && mouse.nameObjectClick!="")
       {
         mouse.nameObjectClick="";return false;
       }
    if(mouse.nameObjectClick==pro.name && sparam!="1" ){
       if(mouse.checkObjectsCanMoveXY(pros,lparam,dparam))
         {
           moveByMouseXY(lparam,dparam);
         }
       return true;  
      }
  return false;
  }
};



//---------------------------------------------------------------------------------
struct ButtonRailDownRight{
   Property pros[];
   SetObject set;
   Mouse mouse;
   int tedRailDownP;
   int tedRailRightP;
   bool resM[];
//---\\---------
 void creat(string name,int xd,int yd,int xs,int ys,string text="Button",int tedRailDown=3,int tedRailRight=3,int sub_win=0,bool back=false){
     ArrayResize(pros,tedRailDown+tedRailRight+1);ArrayResize(resM,ArraySize(pros));int id;
     tedRailDownP=tedRailDown;tedRailRightP=tedRailRight;
     //---------- id 0  --- button----------------
     id=0;pros[id].name=name+"_show";pros[id].object_type=OBJ_BUTTON;
     pros[id].back=back;
     pros[id].sub_win=sub_win;pros[id].delet=false;pros[id].canMoveSelf=false;
     mouse.nameObjectClick="";pros[id].canMoveWithAll=false;pros[id].hidden=false;
     ObjectCreate(0,pros[id].name,pros[id].object_type,pros[id].sub_win,0,0);
     pros[id].xd=xd;pros[id].yd=yd;pros[id].xs=xs;pros[id].ys=ys;pros[id].text="show";
     set.setColorDef(pros[id]);
     set.setPosiXY(pros[id],pros[id].xd,pros[id].yd);
     set.setSizeXY(pros[id],pros[id].xs,pros[id].ys);
     set.setText(pros[id],pros[id].text,10,clrWhite,"Tahoma Bold");
     set.setColorDefButton(pros[id]);
     ObjectSetInteger(0,pros[id].name,OBJPROP_BACK,pros[id].back);
     //---------- id other down  --- button----------------
     for(int i=1;i<=tedRailDown;i++)
       {
        yd=yd+ys+1;
        id=i;pros[id].name=name+"_d"+i;pros[id].object_type=OBJ_BUTTON;
        pros[id].back=back;
        pros[id].sub_win=sub_win;pros[id].delet=false;pros[id].canMoveSelf=false;
        mouse.nameObjectClick="";pros[id].canMoveWithAll=false;pros[id].hidden=false;
        ObjectCreate(0,pros[id].name,pros[id].object_type,pros[id].sub_win,0,0);
        pros[id].xd=xd;pros[id].yd=yd;pros[id].xs=xs;pros[id].ys=ys;pros[id].text=text+i;
        set.setColorDef(pros[id]);
        set.setPosiXY(pros[id],pros[id].xd,pros[id].yd);
        set.setSizeXY(pros[id],pros[id].xs,pros[id].ys);
        set.setText(pros[id],pros[id].text,10,clrWhite,"Tahoma Bold");
        set.setColorDefButton(pros[id]);
        ObjectSetInteger(0,pros[id].name,OBJPROP_BACK,pros[id].back);
        set.setHidden(pros[id]);
       }
     //---------- id other righ  --- button----------------
     for(int i=1;i<=tedRailRight;i++)
       {
        xd=xd+xs+1;
        id=tedRailDown+i;pros[id].name=name+"_r"+i;pros[id].object_type=OBJ_BUTTON;
        pros[id].back=back;
        pros[id].sub_win=sub_win;pros[id].delet=false;pros[id].canMoveSelf=false;
        mouse.nameObjectClick="";pros[id].canMoveWithAll=false;pros[id].hidden=false;
        ObjectCreate(0,pros[id].name,pros[id].object_type,pros[id].sub_win,0,0);
        pros[id].xd=xd;pros[id].yd=yd;pros[id].xs=xs;pros[id].ys=ys;pros[id].text=text+i;
        set.setColorDef(pros[id]);
        set.setPosiXY(pros[id],pros[id].xd,pros[id].yd);
        set.setSizeXY(pros[id],pros[id].xs,pros[id].ys);
        set.setText(pros[id],pros[id].text,10,clrWhite,"Tahoma Bold");
        set.setColorDefButton(pros[id]);
        ObjectSetInteger(0,pros[id].name,OBJPROP_BACK,pros[id].back);
        set.setHidden(pros[id]);
       }
   }
//---\\---------
 void delet(){set.setDeletes(pros);} 
//---\\---------
 bool checkMouse(int id,long lparam,double dparam,string sparam){
    if(!chM(lparam,dparam)){return false;}
    //--
    //--move id 0
    if(pros[0].canMoveSelf && resM[0]){moveObj(id,lparam,dparam,sparam);}
    //--move id other
    
    return true;
 }
//---\\---------
 void hidden(){
  set.setHiddens(pros);
 }
 void show(){
   set.setShows(pros);
 }
//---\\---------
 void hiddenRail(string sh="Show"){
  for(int i=1;i<ArraySize(pros);i++)
    {
      set.setHidden(pros[i]);
    }
  setText(0,sh);  
 }
 void showRail(string hid="Hidden"){
  set.getSetPosiXY(pros[0]);
  for(int i=1;i<=tedRailDownP;i++)
    {
      pros[i].yd=pros[i-1].yd+1+pros[i].ys;
      pros[i].xd=pros[0].xd;
      set.setShow(pros[i]);
    }
  for(int i=tedRailDownP+1;i<=tedRailRightP+tedRailDownP;i++)
    {
      pros[i].yd=pros[0].yd;
      pros[i].xd=pros[i-1].xd+1+pros[i].xs;
      set.setShow(pros[i]);
    }
    
  setText(0,hid);  
 }
 void showHiddenRail(string sh="Show",string hid="Hidden"){
  set.getSetPosiXY(pros[0]);
  if(pros[1].hidden)
    {
     showRail(hid);
    }else{
     hiddenRail(sh);
    }
 }
 
 void showHiddenRailTime(string sh="Show",string hid="Hidden",int timeD=6,int timeR=4){
  set.getSetPosiXY(pros[0]);
  if(pros[1].hidden)
    {
     for(int i=1;i<=tedRailDownP;i++)
       {
        pros[i].yd=pros[i-1].yd+1+pros[i].ys;
        pros[i].xd=pros[0].xd;
        set.setShow(pros[i]);
        set.setGoPosXY(pros[i],pros[0].xd,pros[0].yd,pros[i].xd,pros[i].yd,timeD);
       }
     for(int i=tedRailDownP+1;i<=tedRailRightP+tedRailDownP;i++)
       {
        pros[i].yd=pros[0].yd;
        pros[i].xd=pros[i-1].xd+1+pros[i].xs;
        set.setShow(pros[i]);
        set.setGoPosXY(pros[i],pros[0].xd,pros[0].yd,pros[i].xd,pros[i].yd,timeR);
       }
       setText(0,hid);
    }else{
     for(int i=1;i<ArraySize(pros);i++)
       {
        set.getSetPosiXY(pros[i]);
        set.setGoPosXY(pros[i],pros[i].xd,pros[i].yd,pros[0].xd,pros[0].yd,timeR);
        set.setHidden(pros[i]);
       }
     setText(0,sh);
    }
 }
 
//---\\---------
 bool chM(long lparam,double dparam){
    for(int i=0;i<ArraySize(resM);i++) {resM[i]=false;}  
    for(int i=0;i<ArraySize(resM);i++)
      {
       resM[i]=mouse.checkMouseOver(pros[i],lparam,dparam);
       if(resM[i]){return resM[i];}
      }
     mouse.nameObjectClick=""; 
     return false; 
  }
//---\\---------
 void moveObj(int id,long lparam,double dparam,string sparam){
    if(mouse.checkObjectsCanMoveXY(pros,lparam,dparam)){checkMove(pros[0],id,lparam,dparam,sparam);} 
  }
//---\\---------
 void setMove(){set.setMove(pros);}
 void setMoveWithAll(){set.setMoveWithAll(pros);}
//---\\---------
 void getgetEkhteleafMouseXY(long lparam,double dparam){
   for(int i=0;i<ArraySize(pros);i++){mouse.getEkhteleafMouseXY(pros[i],lparam,dparam); }
  }
 void moveByMouseXY(long lparam,double dparam){
   for(int i=0;i<ArraySize(pros);i++) {mouse.moveByMouseXY(pros[i],lparam,dparam);} 
  }
//---\\---------
 void setText(int id,string text){
    pros[id].text=text;ObjectSetString(0,pros[id].name,OBJPROP_TEXT,pros[id].text);
  }
//---\\---------
 void setTextDown(int id,string text){
    pros[id].text=text;ObjectSetString(0,pros[id].name,OBJPROP_TEXT,pros[id].text);
  }
//---\\---------
 void setTextRight(int id,string text){
    id=id+tedRailDownP;
    pros[id].text=text;ObjectSetString(0,pros[id].name,OBJPROP_TEXT,pros[id].text);
  }
//---\\---------
 bool checkMove(Property &pro,int id,long lparam,double dparam,string sparam){
     if(sparam=="1" && mouse.nameObjectClick=="")
       {
         mouse.nameObjectClick=pro.name;
         getgetEkhteleafMouseXY(lparam,dparam);
       }
     else if (sparam=="1" && mouse.nameObjectClick!="")
       {
         mouse.nameObjectClick="";return false;
       }
    if(mouse.nameObjectClick==pro.name && sparam!="1" ){
       if(mouse.checkObjectsCanMoveXY(pros,lparam,dparam))
         {
           moveByMouseXY(lparam,dparam);
         }
       return true;  
      }
  return false;
  }
};

SetObject set;
//---------------------------------------------------------------------------------
Button button[];
ButtonRail buttonRail[];
ButtonRailDownRight buttonRailDownRight[];
//---------------------------------------------------------------------------------
void checkMouse(int id,long lparam,double dparam,string sparam){    
 bool done=false;
 while(!done){
   //-------move all
   //butML.checkMouse(but,but3,lab,but4,butp,rec,butPtd,butPtd2,id,lparam,dparam,sparam);
   //------------check last mouse----------
   //------------------------------
   //---------------------- 
   //-------button
   for(int i=0;i<ArraySize(button);i++){
   if(button[i].mouse.nameObjectClick!=""){if(button[i].checkMouse(id,lparam,dparam,sparam)){done=true;break;};break;}}
   if(done){break;}
   //-------button Rail
   for(int i=0;i<ArraySize(buttonRail);i++){
   if(buttonRail[i].mouse.nameObjectClick!=""){if(buttonRail[i].checkMouse(id,lparam,dparam,sparam)){done=true;break;};break;}}
   if(done){break;}
   //-------button Rail down right
   for(int i=0;i<ArraySize(buttonRailDownRight);i++){
   if(buttonRailDownRight[i].mouse.nameObjectClick!=""){if(buttonRailDownRight[i].checkMouse(id,lparam,dparam,sparam)){done=true;break;};break;}}
   if(done){break;}
   //-----------------------
   //------------------------------  
   
   //-------button
   for(int i=0;i<ArraySize(button);i++){if(button[i].checkMouse(id,lparam,dparam,sparam)){done=true;break;};}
   if(done){break;}
   //-------button Rail
   for(int i=0;i<ArraySize(buttonRail);i++){if(buttonRail[i].checkMouse(id,lparam,dparam,sparam)){done=true;break;};}
   if(done){break;}
   //-------button rail down right
   for(int i=0;i<ArraySize(buttonRailDownRight);i++){if(buttonRailDownRight[i].checkMouse(id,lparam,dparam,sparam)){done=true;break;};}
   if(done){break;}
   //-------button type4
   //for(int i=0;i<ArraySize(but4);i++){if(but4[i].checkMouse(id,lparam,dparam,sparam)){done=true;break;};}
   if(done){break;}
   //-------button power
   //for(int i=0;i<ArraySize(butp);i++){if(butp[i].checkMouse(id,lparam,dparam,sparam)){done=true;break;};}
   if(done){break;}
   //-------Rectangle
   //for(int i=0;i<ArraySize(rec);i++){if(rec[i].checkMouse(id,lparam,dparam,sparam)){done=true;break;};}
   if(done){break;}
   //-------ButtonPowerWithTextDown
   //for(int i=0;i<ArraySize(butPtd);i++){if(butPtd[i].checkMouse(id,lparam,dparam,sparam)){done=true;break;};}
   if(done){break;}
   //-------ButtonPowerWithTextDown2
   //for(int i=0;i<ArraySize(butPtd2);i++){if(butPtd2[i].checkMouse(id,lparam,dparam,sparam)){done=true;break;};}
   if(done){break;}
   
   //-----------
   break;
 } 
}



};



//+------------------------------------------------------------------+
//|                                                     Objectss.mqh |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
struct Objectss{
//| Create a trend line by the given coordinates                     |

//+------------------------------------------------------------------+
bool TrendCreate(datetime time1=0, double price1=0,datetime time2=0,double price2=0, color clr=clrRed, int width=1, ENUM_LINE_STYLE style=STYLE_SOLID, bool back=true, 
                 int                   Shift=0,
                 const long            chart_ID=0,        // chart's ID
                 string                name="TrendLine",  // line name
                 const int             sub_window=0,      // subwindow index
                        // in the background
                 const bool            selection=false,    // highlight to move
                 const bool            ray_right=false,   // line's continuation to the right
                 const bool            hidden=true,       // hidden in the object list
                 const long            z_order=0)         // priority for mouse click
  {
//--- set anchor points' coordinates if they are not set
   //ChangeTrendEmptyPoints(time1,price1,time2,price2);
//--- reset the error value
   name="trend_"+CreatRandomName();
   if(Shift>0){time1=time1+60*(Shift*5);}
   if(Shift>0){time2=time2+60*(Shift*5);}
   ResetLastError();
//--- create a trend line by the given coordinates
   if(!ObjectCreate(chart_ID,name,OBJ_TREND,sub_window,time1,price1,time2,price2))
     {
      Print(__FUNCTION__,
            ": failed to create a trend line! Error code = ",GetLastError());
      return(false);
     }
//--- set line color
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- set line display style
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
//--- set line width
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);
//--- display in the foreground (false) or background (true)
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- enable (true) or disable (false) the mode of moving the line by mouse
//--- when creating a graphical object using ObjectCreate function, the object cannot be
//--- highlighted and moved by default. Inside this method, selection parameter
//--- is true by default making it possible to highlight and move the object
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- enable (true) or disable (false) the mode of continuation of the line's display to the right
   ObjectSetInteger(chart_ID,name,OBJPROP_RAY_RIGHT,ray_right);
//--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- set the priority for receiving the event of a mouse click in the chart
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- successful execution
   return(true);
  }
  //-----------------------------------------------------------------------


bool HLineCreate(double    price=0,    
                 color           clr=clrRed,   
                 int             width=1,  
                 ENUM_LINE_STYLE style=STYLE_SOLID, // line style
                 const long            chart_ID=0, 
                 const bool            back=false, 
                 string          name="HLine",      // line name
                 const int             sub_window=0,      // subwindow index
                 const bool            selection=false,    // highlight to move
                 const bool            hidden=true,       // hidden in the object list
                 const long            z_order=0)         // priority for mouse click
  {
//--- if the price is not set, set it at the current Bid price level
   //if(!price)
    //  price=SymbolInfoDouble(Symbol(),SYMBOL_BID);
    name="HLine"+CreatRandomName();
//--- reset the error value
   ResetLastError();
//--- create a horizontal line
   if(!ObjectCreate(chart_ID,name,OBJ_HLINE,sub_window,0,price))
     {
      Print(__FUNCTION__,
            ": failed to create a horizontal line! Error code = ",GetLastError());
      return(false);
     }
//--- set line color
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- set line display style
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
//--- set line width
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);
//--- display in the foreground (false) or background (true)
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- enable (true) or disable (false) the mode of moving the line by mouse
//--- when creating a graphical object using ObjectCreate function, the object cannot be
//--- highlighted and moved by default. Inside this method, selection parameter
//--- is true by default making it possible to highlight and move the object
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- set the priority for receiving the event of a mouse click in the chart
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- successful execution
   return(true);
  }

  //-----------------------------------------------------------------------



  bool ArrowUpCreate(datetime  time=0, double  price=0,color clr=clrRed, int               width=3,
                   const long              chart_ID=0,           // chart's ID
                   string            name="ArrowUp",       // sign name
                   const int               sub_window=0,         // subwindow index
                   const ENUM_ARROW_ANCHOR anchor=ANCHOR_BOTTOM, // anchor type
                   const ENUM_LINE_STYLE   style=STYLE_SOLID,    // border line style
                                 // sign size
                   const bool              back=false,           // in the background
                   const bool              selection=false,       // highlight to move
                   const bool              hidden=true,          // hidden in the object list
                   const long              z_order=0)            // priority for mouse click
  {
//--- set anchor point coordinates if they are not set
//--- reset the error value
   name="ArrowUpCreate"+CreatRandomName();
   ResetLastError();
//--- create the sign
   if(!ObjectCreate(chart_ID,name,OBJ_ARROW_UP,sub_window,time,price))
     {
      Print(__FUNCTION__,
            ": failed to create \"Arrow Up\" sign! Error code = ",GetLastError());
      return(false);
     }
//--- set anchor type
   ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor);
//--- set a sign color
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- set the border line style
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
//--- set the sign size
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);
//--- display in the foreground (false) or background (true)
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- enable (true) or disable (false) the mode of moving the sign by mouse
//--- when creating a graphical object using ObjectCreate function, the object cannot be
//--- highlighted and moved by default. Inside this method, selection parameter
//--- is true by default making it possible to highlight and move the object
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- set the priority for receiving the event of a mouse click in the chart
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- successful execution
   return(true);
  }
 //----------------------------------------------------------------------
 
 bool ArrowDownCreate (datetime  time=0, double  price=0,color clr=clrRed,  int               width=3,  
                   const long              chart_ID=0,           // chart's ID
                   string            name="ArrowUp",       // sign name
                   const int               sub_window=0,         // subwindow index
                   const ENUM_ARROW_ANCHOR anchor=ANCHOR_BOTTOM, // anchor type
                   const ENUM_LINE_STYLE   style=STYLE_SOLID,    // border line style
                              // sign size
                   const bool              back=false,           // in the background
                   const bool              selection=false,       // highlight to move
                   const bool              hidden=true,          // hidden in the object list
                   const long              z_order=0)            // priority for mouse click
  {
//--- set anchor point coordinates if they are not set
   name="ArrowDownCreate"+CreatRandomName();
//--- reset the error value
   ResetLastError();
//--- create the sign
   if(!ObjectCreate(chart_ID,name,OBJ_ARROW_DOWN,sub_window,time,price))
     {
      Print(__FUNCTION__,
            ": failed to create \"Arrow Down\" sign! Error code = ",GetLastError());
      return(false);
     }
//--- anchor type
   ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor);
//--- set a sign color
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- set the border line style
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
//--- set the sign size
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);
//--- display in the foreground (false) or background (true)
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- enable (true) or disable (false) the mode of moving the sign by mouse
//--- when creating a graphical object using ObjectCreate function, the object cannot be
//--- highlighted and moved by default. Inside this method, selection parameter
//--- is true by default making it possible to highlight and move the object
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- set the priority for receiving the event of a mouse click in the chart
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- successful execution
   return(true);
  } 
//----------------------------------------------------------------------

bool ArrowStopCreate  (datetime  time=0, double  price=0,color clr=clrRed, 
                   const long              chart_ID=0,           // chart's ID
                   string            name="ArrowUp",       // sign name
                   const int               sub_window=0,         // subwindow index
                   const ENUM_ARROW_ANCHOR anchor=ANCHOR_BOTTOM, // anchor type
                   const ENUM_LINE_STYLE   style=STYLE_SOLID,    // border line style
                   const int               width=3,              // sign size
                   const bool              back=false,           // in the background
                   const bool              selection=false,       // highlight to move
                   const bool              hidden=true,          // hidden in the object list
                   const long              z_order=0)            // priority for mouse click
  {
//--- set anchor point coordinates if they are not set
   name="ArrowStopCreate"+CreatRandomName();
//--- reset the error value
   ResetLastError();
//--- create the sign
   if(!ObjectCreate(chart_ID,name,OBJ_ARROW_STOP,sub_window,time,price))
     {
      Print(__FUNCTION__,
            ": failed to create \"Stop\" sign! Error code = ",GetLastError());
      return(false);
     }
//--- set anchor type
   ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor);
//--- set a sign color
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- set the border line style
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
//--- set the sign size
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);
//--- display in the foreground (false) or background (true)
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- enable (true) or disable (false) the mode of moving the sign by mouse
//--- when creating a graphical object using ObjectCreate function, the object cannot be
//--- highlighted and moved by default. Inside this method, selection parameter
//--- is true by default making it possible to highlight and move the object
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- set the priority for receiving the event of a mouse click in the chart
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- successful execution
      return(true);
  }
 //---------------------------------------------------------------------------
  bool TextCreate(string  text="Text", datetime  time=0,double  price=0,color  clr=clrRed, double angle=0.0,   int font_size=10, 
                const long              chart_ID=0,               // chart's ID
                string                  name="Text",              // object name
                const int               sub_window=0,             // subwindow index
                const string            font="Arial",             // font
                const ENUM_ANCHOR_POINT anchor=ANCHOR_LEFT_UPPER, // anchor type
                const bool              back=false,               // in the background
                const bool              selection=false,          // highlight to move
                const bool              hidden=true,              // hidden in the object list
                const long              z_order=0)                // priority for mouse click
  {
//--- set anchor point coordinates if they are not set
   //ChangeTextEmptyPoint(time,price);
//--- reset the error value
   name="ArrowStopCreate"+CreatRandomName();
   ResetLastError();
//--- create Text object
   if(!ObjectCreate(chart_ID,name,OBJ_TEXT,sub_window,time,price))
     {
      Print(__FUNCTION__,
            ": failed to create \"Text\" object! Error code = ",GetLastError());
      return(false);
     }
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
//--- enable (true) or disable (false) the mode of moving the object by mouse
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- set the priority for receiving the event of a mouse click in the chart
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- successful execution
   return(true);
  }
 
 //--------------------------------------------------------------------------------------------
 bool VLineCreate(datetime time=0,color clr=clrRed, int width=1,const ENUM_LINE_STYLE style=STYLE_SOLID,bool  back=true,   
                 const long            chart_ID=0,        // chart's ID
                 string          name="VLine",      // line name
                 const int             sub_window=0,      // subwindow index
                  // line style
                 const bool            selection=false,    // highlight to move
                 const bool            hidden=true,       // hidden in the object list
                 const long            z_order=0)         // priority for mouse click
  {
//--- if the line time is not set, draw it via the last bar
   //if(!time)
    //  time=TimeCurrent();
//--- reset the error value
   ResetLastError();
   name="VLineCreate"+CreatRandomName();
//--- create a vertical line
   if(!ObjectCreate(chart_ID,name,OBJ_VLINE,sub_window,time,0))
     {
      Print(__FUNCTION__,
            ": failed to create a vertical line! Error code = ",GetLastError());
      return(false);
     }
//--- set line color
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- set line display style
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
//--- set line width
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);
//--- display in the foreground (false) or background (true)
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- enable (true) or disable (false) the mode of moving the line by mouse
//--- when creating a graphical object using ObjectCreate function, the object cannot be
//--- highlighted and moved by default. Inside this method, selection parameter
//--- is true by default making it possible to highlight and move the object
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- set the priority for receiving the event of a mouse click in the chart
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- successful execution
   return(true);
  }
  
  
 //-------------------------------------------------------------------------
                     
 bool RectangleCreate(                     
                     datetime              time1=0,           // first point time
                     double                price1=0,          // first point price
                     datetime              time2=0,           // second point time
                     double                price2=0,          // second point price
                     int                   Shift=0,        // rectangle color
                     const color           clr=clrRed,        // rectangle color
                     const bool            back=true,        // in the background
                     const ENUM_LINE_STYLE style=STYLE_SOLID, // style of rectangle lines
                     const int             width=1,           // width of rectangle lines
                     const bool            fill=true,        // filling rectangle with color
                     const bool            selection=false,    // highlight to move
                     const long            chart_ID=0,        // chart's ID
                     string          name="Rectangle",  // rectangle name
                     const int             sub_window=0,      // subwindow index 
                     const bool            hidden=true,       // hidden in the object list
                     const long            z_order=0)         // priority for mouse click
  {
//--- set anchor points' coordinates if they are not set
   //ChangeRectangleEmptyPoints(time1,price1,time2,price2);
   name="RectangleCreate"+CreatRandomName();
   if(Shift>0){time1=time1+60*(Shift*5);}
   if(Shift>0){time2=time2+60*(Shift*5);}
//--- reset the error value
   ResetLastError();
//--- create a rectangle by the given coordinates
   if(!ObjectCreate(chart_ID,name,OBJ_RECTANGLE,sub_window,time1,price1,time2,price2))
     {
      Print(__FUNCTION__,
            ": failed to create a rectangle! Error code = ",GetLastError());
      return(false);
     }
//--- set rectangle color
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- set the style of rectangle lines
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
//--- set width of the rectangle lines
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);
//--- enable (true) or disable (false) the mode of filling the rectangle
   ObjectSetInteger(chart_ID,name,OBJPROP_FILL,fill);
//--- display in the foreground (false) or background (true)
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- enable (true) or disable (false) the mode of highlighting the rectangle for moving
//--- when creating a graphical object using ObjectCreate function, the object cannot be
//--- highlighted and moved by default. Inside this method, selection parameter
//--- is true by default making it possible to highlight and move the object
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- set the priority for receiving the event of a mouse click in the chart
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- successful execution
   return(true);
  } 
  
  
  
  bool TriangleCreate( 
                    datetime              time1=0,           // first point time
                    double                price1=0,          // first point price
                    datetime              time2=0,           // second point time
                    double                price2=0,          // second point price
                    datetime              time3=0,           // third point time
                    double                price3=0,          // third point price
                    const color           clr=clrRed,        // triangle color
                    const ENUM_LINE_STYLE style=STYLE_SOLID, // style of triangle lines
                    const int             width=1,    
                    const long            chart_ID=0,  
                    const int             sub_window=0,        // width of triangle lines
                    const bool            fill=false,        // filling triangle with color
                    const bool            back=false,        // in the background
                    const bool            selection=false,    // highlight to move
                    const bool            hidden=true,       // hidden in the object list
                    const long            z_order=0)         // priority for mouse click
  {
  string name;
//--- set anchor points' coordinates if they are not set
 name="TriangleCreate"+CreatRandomName();
//--- reset the error value
   ResetLastError();
//--- create triangle by the given coordinates
   if(!ObjectCreate(chart_ID,name,OBJ_TRIANGLE,sub_window,time1,price1,time2,price2,time3,price3))
     {
      Print(__FUNCTION__,
            ": failed to create a triangle! Error code = ",GetLastError());
      return(false);
     }
//--- set triangle color
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- set style of triangle lines
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
//--- set width of triangle lines
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);
//--- display in the foreground (false) or background (true)
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- enable (true) or disable (false) the mode of highlighting the triangle for moving
//--- when creating a graphical object using ObjectCreate function, the object cannot be
//--- highlighted and moved by default. Inside this method, selection parameter
//--- is true by default making it possible to highlight and move the object
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- set the priority for receiving the event of a mouse click in the chart
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- successful execution
   return(true);
  }
  
  
  
//-------------------------------------------------------------------------
double resRan;
double rb(int a , int b,int Taghsim=1 ){resRan = a+MathRand()%(b-a+1)  ; return(resRan/Taghsim); }
//-----------
string CreatRandomName(){
  return  string(MathRand())+""+string(MathRand())+""+string(MathRand()) ;
}

};
//+------------------------------------------------------------------+
Objectss obj;
Object4 obj4;

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
  long x_distance;
  long y_distance;
void getChartXY(){

  //--- set window size
  ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0,y_distance);
  ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0,x_distance);     
}  