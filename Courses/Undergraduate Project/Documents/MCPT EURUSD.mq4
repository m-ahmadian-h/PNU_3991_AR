//+------------------------------------------------------------------+
//|                                                   testObject.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//#property indicator_chart_window
#property indicator_separate_window

#property indicator_buffers 2      // Number of buffers
double Buf_0[],Buf_1[];

int lowestBar=Bars;
int cntBack=300;
int History;
int periods=60;
int endBar=1;
double xt=1;
//+------------------------------------------------------------------+
double Buf_0_EUR,Buf_1_EUR,Buf_0_USD,Buf_1_USD;
bool firstOnCal=true;
int lastBar=0;


string base;

bool first;
int lowBar;
string baseCurEUR;
string baseCurUSD;


//+----------------
struct Currency{
   string name;
   int bars;
   int ibs;
   string typeCandel;
   double power;
   string curBase;
   string typeBaseCandel;
   double zarib;
};


Currency curEUR[];
Currency curUSD[];

double xT=0.0;
//+------------------------------------------------------------------+
string endSymbol="";
int OnInit()
  {
  endSymbol=StringSubstr(Symbol(),6,StringLen(Symbol()));
  for(int i=1;i<100;i++)
    {
     xT=i;
    }
   //ObjectsDeleteAll();

//--- indicator buffers mapping
   SetIndexBuffer(0,Buf_0);         // Assigning an array to a buffer
   SetIndexStyle (0,DRAW_LINE,STYLE_SOLID,2,clrRed);// Line style
   SetIndexLabel(0,"powerLongs");

   SetIndexBuffer(1,Buf_1);         // Assigning an array to a buffer
   SetIndexStyle (1,DRAW_LINE,STYLE_SOLID,2,clrBlue);// Line style
   
   SetIndexLabel(1,"powerLong1");
      if(IsTesting()){
         string nameD="commentShow1";
         ObjectCreate(0,nameD,OBJ_LABEL,0,0,0);
         ObjectSetInteger(0,nameD,OBJPROP_COLOR,clrRed);
         ObjectSetString(0,nameD,OBJPROP_TEXT,"Wait a minute...Load Data...don't close tester");
         ObjectSetInteger(0,nameD,OBJPROP_FONTSIZE,24);
         ObjectSetInteger(0,nameD,OBJPROP_SELECTABLE,false);
         ObjectSetInteger(0,nameD,OBJPROP_BACK,false);
         ObjectSetInteger(0,nameD,OBJPROP_XSIZE,200);
         ObjectSetInteger(0,nameD,OBJPROP_YSIZE,200);
         ObjectSetInteger(0,nameD,OBJPROP_XDISTANCE,100);
         ObjectSetInteger(0,nameD,OBJPROP_YDISTANCE,100);
         ChartRedraw();
      }else{
          lasBBB=Bars-2;
      }
   

//---
   return(INIT_SUCCEEDED);
  }











/*
int OnStart(){

      creatBBB=true;
   CountBarsCurraba();
   lowestBar=lowBar-periods;
   History=lowestBar;
   
   if(History<0)
     {
      History=0;
     }
   if(creatMM==false){creatModel(2,-90);creatMM=true;}  
   ChartSetInteger(0,CHART_EVENT_MOUSE_MOVE,true);//---mouse over actions
   
         firstOnCal=false;

             if(!IsTesting()){runFirstAB(500);}
            
          
   

return 1;
}
*/



bool creatMM=false;
int deinit()
  {
    Comment("");
    ObjectsDeleteAll();
   return(INIT_SUCCEEDED);
  }
void runFirst(int ie=1){
   CountBarsCurraba();
   lowestBar=lowBar-periods;
   History=lowestBar;
   
   if(ie!=0)
     {
      if(ie<=History)
        {
         History=ie;
        }
     }
   if(History<0)
     {
      History=0;
     }
   lastBar=Bars;
   for(int i=1;i<History;i++)
    {
       PowerLongShortIMAEUR(i,periods,cntBack);
       Buf_0_EUR=powerBaseLongIMAEUR;        // Value of 0 buffer on i bar
       Buf_1_EUR=powerBaseShortIMAEUR;       // Value of 0 buffer on i bar
       PowerLongShortIMAUSD(i,periods,cntBack);
       Buf_0_USD=powerBaseLongIMAUSD;        // Value of 0 buffer on i bar
       Buf_1_USD=powerBaseShortIMAUSD;       // Value of 0 buffer on i bar
       Buf_0[i]=powerBaseLongIMAEUR-powerBaseLongIMAUSD;        // Value of 0 buffer on i bar
       //Buf_1[i]=powerBaseShortIMAEUR-powerBaseShortIMAUSD;       // Value of 0 buffer on i bar
       /*
       if(Buf_0[i]>Buf_1[i])
         {
          if(Close[i]>Open[i])
            {
             Buf_0[i]=Close[i];
             Buf_1[i]=Open[i];
            }else if(Close[i]<Open[i]){
             Buf_0[i]=Open[i];
             Buf_1[i]=Close[i];
            } 
         }else{
          if(Close[i]>Open[i])
            {
             Buf_1[i]=Close[i];
             Buf_0[i]=Open[i];
            }else if(Close[i]<Open[i]){
             Buf_1[i]=Open[i];
             Buf_0[i]=Close[i];
            } 
             
         }
         */

    }

}  
  
int lastPro=0;
void runFirstAB(int ie=1){
   
   CountBarsCurraba();
   lowestBar=lowBar-periods;
   History=lowestBar;
   
   if(ie!=0)
     {
      if(ie<History)
        {
         History=ie;
        }
     }
   if(History<0)
     {
      History=0;
     }
   lastBar=Bars;
   PowerLongShortIMAEUR_AB(1,History-1,cntBack);
   PowerLongShortIMAUSD_AB(1,History-1,cntBack);
   delectObject();
   free(lastPro);
   for(int i=1;i<History;i++)
    {

       Buf_0[i]=(powerBaseLongIMAEUR_AB[i]-powerBaseLongIMAUSD_AB[i])-(powerBaseShortIMAEUR_AB[i]-powerBaseShortIMAUSD_AB[i]);
       Buf_1[i]=NULL;
       if(Buf_0[i]>0){Buf_1[i]=Buf_0[i];Buf_0[i]=NULL;}
       if(i>1)
           {
            /*
            if(Buf_0[i]<Buf_1[i] && Buf_0[i-1]>Buf_1[i-1])
              {
               addObject(TimeToString(Time[i]),Low[i-1]-15*Point);
               ObjectCreate(ChartID(),TimeToString(Time[i]),OBJ_ARROW_UP,0,Time[i-1],Low[i-1]-15*Point);
               ObjectSetInteger(ChartID(),TimeToString(Time[i]),OBJPROP_COLOR,clrBlue);
               ObjectSetInteger(ChartID(),TimeToString(Time[i]),OBJPROP_WIDTH,1);
               ObjectSetInteger(ChartID(),TimeToString(Time[i]),OBJPROP_SELECTABLE,false);
               ObjectSetInteger(ChartID(),TimeToString(Time[i]),OBJPROP_BACK,true);
              }
            if(Buf_0[i]>Buf_1[i] && Buf_0[i-1]<Buf_1[i-1])
              {
               addObject(TimeToString(Time[i]),High[i-1]+15*Point);
               ObjectCreate(ChartID(),TimeToString(Time[i]),OBJ_ARROW_DOWN,0,Time[i-1],High[i-1]+15*Point);
               ObjectSetInteger(ChartID(),TimeToString(Time[i]),OBJPROP_COLOR,clrRed);
               ObjectSetInteger(ChartID(),TimeToString(Time[i]),OBJPROP_WIDTH,1);
               ObjectSetInteger(ChartID(),TimeToString(Time[i]),OBJPROP_SELECTABLE,false);
               ObjectSetInteger(ChartID(),TimeToString(Time[i]),OBJPROP_BACK,true);
              }
              */
           }

    }
   addObject(TimeToString(Time[History]),0);
   ObjectCreate(ChartID(),TimeToString(Time[History]),OBJ_VLINE,0,Time[History],0);
   ObjectSetInteger(ChartID(),TimeToString(Time[History]),OBJPROP_COLOR,clrYellow);
   ObjectSetInteger(ChartID(),TimeToString(Time[History]),OBJPROP_SELECTABLE,false);
   ObjectSetInteger(ChartID(),TimeToString(Time[History]),OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),TimeToString(Time[History]),OBJPROP_STYLE,STYLE_DASHDOTDOT);
   lastPro=History;
   
}  

string objectDelect[];
double objectDelectPrice[];
void addObject(string name,double price){
   ArrayResize(objectDelect,ArraySize(objectDelect)+1);
   ArrayResize(objectDelectPrice,ArraySize(objectDelectPrice)+1);
   objectDelect[ArraySize(objectDelect)-1]=name;
   objectDelectPrice[ArraySize(objectDelectPrice)-1]=price;
}
void delectObject(){
   for(int i=0;i<ArraySize(objectDelect);i++)
     {
      ObjectDelete(ChartID(),objectDelect[i]);
     }
}
void showObject(){
   for(int i=0;i<ArraySize(objectDelect);i++)
     {
      ObjectSetDouble(ChartID(),objectDelect[i], OBJPROP_PRICE,objectDelectPrice[i]);
     }
}

void hiddenObject(){
   for(int i=0;i<ArraySize(objectDelect);i++)
     {
      ObjectSetDouble(ChartID(),objectDelect[i], OBJPROP_PRICE,0);
     }
}

void changeWigh(double wi){
   for(int i=0;i<ArraySize(objectDelect);i++)
     {
      ObjectSetInteger(ChartID(),objectDelect[i],OBJPROP_WIDTH,wi);
     }
}
//+------------------------------------------------------------------+
 int ChartScaleGet(const long chart_ID=0)
  {
//--- prepare the variable to get the property value
   long result=-1;
//--- reset the error value
   ResetLastError();
//--- receive the property value
   if(!ChartGetInteger(chart_ID,CHART_SCALE,0,result))
     {
      //--- display the error message in Experts journal
      Print(__FUNCTION__+", Error Code = ",GetLastError());
     }
//--- return the value of the chart property
   return((int)result);
  }
  
bool fraw=true;  
void setScale(){
   if(fraw)
      {
       showObject();
       if(ChartScaleGet()==5)
         {
            SetIndexStyle (0,DRAW_LINE,STYLE_SOLID,2,clrRed);// Line style
            SetIndexStyle (1,DRAW_LINE,STYLE_SOLID,2,clrBlue);// Line style
            changeWigh(2);
         }
      
       if(ChartScaleGet()==4)
         {
            SetIndexStyle (0,DRAW_LINE,STYLE_SOLID,2,clrRed);// Line style
            SetIndexStyle (1,DRAW_LINE,STYLE_SOLID,2,clrBlue);// Line style
            changeWigh(1);
         }
       if(ChartScaleGet()==3)
         {
            SetIndexStyle (0,DRAW_LINE,STYLE_SOLID,2,clrRed);// Line style
            SetIndexStyle (1,DRAW_LINE,STYLE_SOLID,2,clrBlue);// Line style
            changeWigh(0.9);
         }
       if(ChartScaleGet()<=2)
         {
            SetIndexStyle (0,DRAW_LINE,STYLE_SOLID,2,clrRed);// Line style
            SetIndexStyle (1,DRAW_LINE,STYLE_SOLID,2,clrBlue);// Line style
            changeWigh(0.1);
         }
    }
    else{
       hiddenObject();
       SetIndexStyle (0,DRAW_NONE,STYLE_SOLID,2,clrBlue);// Line style
       SetIndexStyle (1,DRAW_NONE,STYLE_SOLID,2,clrRed);// Line style
    }
}  
//+------------------------------------------------------------------+
int lasBBB=Bars;
bool creatBBB=false;
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
  
  
if(Bars-lasBBB>1 && creatBBB==false)
  {
      creatBBB=true;
   CountBarsCurraba();
   lowestBar=lowBar-periods;
   History=lowestBar;
   
   if(History<0)
     {
      History=0;
     }
   if(creatMM==false){creatModel(2,-90);creatMM=true;}  
   ChartSetInteger(0,CHART_EVENT_MOUSE_MOVE,true);//---mouse over actions
     
  }else if(creatMM){ 
  
//---
     if(firstOnCal)
       {
             
         firstOnCal=false;
         if(lastBar!=Bars)
           {
             if(!IsTesting()){runFirstAB(500);}
            
           }
       }else{
           if(lastBar!=Bars)
             {
                lastBar=Bars;
                int i=1;
                PowerLongShortIMAEUR(i,periods,cntBack);
                Buf_0_EUR=powerBaseLongIMAEUR;        // Value of 0 buffer on i bar
                Buf_1_EUR=powerBaseShortIMAEUR;       // Value of 0 buffer on i bar
                PowerLongShortIMAUSD(i,periods,cntBack);
                Buf_0_USD=powerBaseLongIMAUSD;        // Value of 0 buffer on i bar
                Buf_1_USD=powerBaseShortIMAUSD;       // Value of 0 buffer on i bar
                Buf_0[i]=(powerBaseLongIMAEUR-powerBaseLongIMAUSD)-(powerBaseShortIMAEUR-powerBaseShortIMAUSD);        // Value of 0 buffer on i bar
                Buf_1[i]=NULL;
                if(Buf_0[i]>0){Buf_1[i]=Buf_0[i];Buf_0[i]=NULL;}
                ///-----
               if(Buf_1[i+1]==0 && Buf_1[i]!=0 )
                 {
                 /*
                  addObject(TimeToString(Time[i]),Low[i]-15*Point);
                  ObjectCreate(ChartID(),TimeToString(Time[i]),OBJ_ARROW_UP,0,Time[i],Low[i]-15*Point);
                  ObjectSetInteger(ChartID(),TimeToString(Time[i]),OBJPROP_COLOR,clrBlue);
                  ObjectSetInteger(ChartID(),TimeToString(Time[i]),OBJPROP_WIDTH,2);
                  ObjectSetInteger(ChartID(),TimeToString(Time[i]),OBJPROP_SELECTABLE,false);
                  ObjectSetInteger(ChartID(),TimeToString(Time[i]),OBJPROP_BACK,true);
                  */
                  if(alarmShow){Alert ("Mcpt pro : BUY  "+"  "+Symbol()+" Time frame "+timeFrame()+" time: "+TimeToString(Time[1]));}
                  if(alarmShowNoti){SendNotification("Mcpt pro : BUY  "+"  "+Symbol()+" Time frame "+timeFrame()+" time: "+TimeToString(Time[1]));}
                 }
               if(Buf_0[i+1]==0 && Buf_0[i]!=0)
                 {
                  /*
                  addObject(TimeToString(Time[i]),High[i]+15*Point);
                  ObjectCreate(ChartID(),TimeToString(Time[i]),OBJ_ARROW_DOWN,0,Time[i],High[i]+15*Point);
                  ObjectSetInteger(ChartID(),TimeToString(Time[i]),OBJPROP_COLOR,clrRed);
                  ObjectSetInteger(ChartID(),TimeToString(Time[i]),OBJPROP_WIDTH,2);
                  ObjectSetInteger(ChartID(),TimeToString(Time[i]),OBJPROP_SELECTABLE,false);
                  ObjectSetInteger(ChartID(),TimeToString(Time[i]),OBJPROP_BACK,true);
                  */
                  if(alarmShow){Alert ("Mcpt pro : SELL  "+"  "+Symbol()+" Time frame "+timeFrame()+" time: "+TimeToString(Time[1]));}
                  if(alarmShowNoti){SendNotification("Mcpt pro : SELL  "+"  "+Symbol()+" Time frame "+timeFrame()+" time: "+TimeToString(Time[1]));}
                 }
               
             }
       }
       ChartRedraw();
}
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+

string timeFrame(){
if(Period()>=60 && Period()<1440) {return Period()/60+"H";}
if(Period()==1440) {return (Period()/60)/24+"D";} 
if(Period()==10080) {return 1+"W";}
if(Period()==43200){return 1+"MN";}
return Period()+"M";
}

//+------------------------------------------------------------------+
bool alarmShow=false;
bool alarmShowNoti=false;
void free(int en){
for(int i=1;i<en;i++)
  {
    Buf_0[i]=0;
    //Buf_0[i]=0;
  }

}
void creatModel(int xe,int ye){
   ObjectsDeleteAll();
   objC.creatObject(ChartID(),"buttonShowMenu",OBJ_BUTTON,5+xe,90+ye,40,20,"show",C'20,167,172',C'20,167,172',clrWhite,7,0,"Tahoma",
   C'145,151,176',clrWhite,clrYellow,C'89,93,138',clrWhite,clrRed,true,true);
   objC.hiddenObject("buttonShowMenu");
     
   objB.creatObject(ChartID(),"backMenu1",OBJ_RECTANGLE_LABEL,5+xe,100+ye,154,100,"",C'89,93,138',0,clrLightSlateGray,10,1,"",
   C'57,66,99',C'57,66,99',clrYellow,clrRed,clrRed,clrRed);
   
   objB.creatObject(ChartID(),"backMenu2",OBJ_RECTANGLE_LABEL,7+xe,102+ye,150,96,"",clrLightSlateGray,0,clrLightSlateGray,10,1,"",
   C'57,66,99',C'57,66,99',clrYellow,clrRed,clrRed,clrRed);
   
   objB.creatObject(ChartID(),"text1",OBJ_LABEL,20+xe,80+53+ye,20,20,"---------------------",0,0,clrRed,10,0,"Tahoma Bold",
   C'57,66,99',C'57,66,99',clrYellow,clrRed,clrRed,clrRed);
   
   objB.creatObject(ChartID(),"buttonMoveMenu",OBJ_BUTTON,142+xe,180+ye,15,15,"*",clrLightSlateGray,clrLightSlateGray,C'145,151,176',10,0,"Tahoma Bold",
   C'57,66,99',C'57,66,99',clrYellow,C'57,66,99',C'57,66,99',clrRed,true,true);
   
   objB.creatObject(ChartID(),"edit1",OBJ_EDIT,90+xe,170+ye,40,20,periods,clrBisque,C'180,50,50',clrBlack,10,0,"Tahoma Bold",
   C'57,66,99',C'57,66,99',clrYellow,C'57,66,99',C'57,66,99',clrRed,true,true);
   
   objB.creatObject(ChartID(),"buttonRun",OBJ_BUTTON,40+xe,170+ye,40,20,"Run",clrRed,C'20,167,172',clrWhiteSmoke,7,0,"Tahoma",
   C'145,151,176',clrWhite,clrYellow,C'89,93,138',clrWhite,clrRed,true,true);
   
   objB.creatObject(ChartID(),"text9",OBJ_LABEL,65+xe,148+ye,30,20,"Set Period",C'20,167,172',C'20,167,172',clrWhite,7,0,"Tahoma",
   C'145,151,176',clrWhite,clrYellow,C'89,93,138',clrWhite,clrRed,false,false);
   
   objB.creatObject(ChartID(),"text11",OBJ_LABEL,40+xe,200+ye,30,20,"",C'20,167,172',C'20,167,172',clrWhite,15,0,"Tahoma",
   C'145,151,176',clrWhite,clrYellow,C'89,93,138',clrWhite,clrRed,false,false);
   
   objB.creatObject(ChartID(),"buttonHiddenMenu",OBJ_BUTTON,10+xe,180+ye,15,15,"=",clrLightSlateGray,clrLightSlateGray,C'145,151,176',10,0,"Tahoma Bold",
   C'57,66,99',C'57,66,99',clrYellow,C'57,66,99',C'57,66,99',clrRed,true,true);
   
   objB.creatObject(ChartID(),"alarmText",OBJ_LABEL,55+xe,100+ye,20,20,"Alarm on",0,0,clrWhite,8,0,"Tahoma Bold",
   C'57,66,99',C'57,66,99',clrGold,clrGold,clrGold,clrGold,true,true);
   
   objB.creatObject(ChartID(),"alarmTextNotification",OBJ_LABEL,40+xe,120+ye,20,20,"Notification on",0,0,clrWhite,8,0,"Tahoma Bold",
   C'57,66,99',C'57,66,99',clrGold,clrGold,clrGold,clrGold,true,true);

   if( IsTesting()){
     getChartXY();
     LabelCreate(0,"labelBreak",0,200,y_distance-20,0,"Menu not work in Tester!");
   }

}



bool firstShow=false;
void OnChartEvent(const int id,         // Event ID 
                  const long& lparam,   // Parameter of type long event 
                  const double& dparam, // Parameter of type double event 
                  const string& sparam  // Parameter of type string events
                   ){  
                   
                   
   if(firstShow==false && creatMM)
     {
      firstShow=true;
       if(!IsTesting()){runFirstAB(600);}
     }                      
   //----------------------                
   if(id==9 && lparam==0 && dparam==0)//--change chart x  y
    {
      objB.moveModel();
      objC.moveModel();
    }   
    
  //-------   reset
  if(id==0 && lparam==82 && dparam==1 && sparam==19 )
    {
     objB.reset();
     objC.reset();
     objC.hiddenObject("buttonShowMenu");
     ChartRedraw();
    }  
   //----------------------  
   objB.checkMouseClickMoveTotal(sparam,lparam,dparam,"buttonMoveMenu");
   objC.checkMouseClickMoveTotal(sparam,lparam,dparam,"none");
   //-------------------------------------------------------------
   //---   button3


   //---   button5
   if(sparam=="buttonHiddenMenu")
     {
        objB.hiddenAllObject();
        objC.showObject("buttonShowMenu");
     }
   //---   button4
   if(sparam=="buttonShowMenu")
     {
        objB.showAllObject();
        objC.hiddenObject("buttonShowMenu");
     }


   if(sparam=="buttonRun")
     {
       int edi1=objB.getTextInt("edit1");
       if(edi1<=0)
         {
          objB.setText("edit1","0");
         }else{
           if(edi1>100){edi1=100;objB.setText("edit1","100");}
           periods=edi1;
           runFirstAB(500);
         }
     }
   if(sparam=="alarmText")
     {
       if(alarmShow)
         {
          alarmShow=false;
          objB.offColorClick("alarmText");

         }else{
           alarmShow=true;
           objB.setColorClick("alarmText");
         }
     }
   if(sparam=="alarmTextNotification")
     {
       if(alarmShowNoti)
         {
          alarmShowNoti=false;
          objB.offColorClick("alarmTextNotification");

         }else{
           alarmShowNoti=true;
           objB.setColorClick("alarmTextNotification");
         }
     }
     
     if(curLoss!=""){
     Comment("Set key  R  to reset menu "+"\n"+   "Alarm change trend is "+alarmShow+"\n"+"SendNotification  "+alarmShowNoti+"\n"+"loss data : "+curLoss);
   }else{
     Comment("Set key  R  to reset menu "+"\n"+   "Alarm change trend is "+alarmShow+"\n"+"SendNotification  "+alarmShowNoti);
     } 
 setScale();
 };
 
 
 string curLoss="";
 void CountBarsCurraba(){
   //printf("2");
   if(first==false || ArraySize(curEUR)<=1)
     {
         lowBar=Bars;
         ArrayResize(curEUR,1+1);
         ArrayResize(curUSD,1+1);
         baseCurEUR="EUR";
         baseCurUSD="USD";
         int ib=0;
         curUSD[1].name="EURUSD"+endSymbol; curUSD[1].curBase="EUR"; curUSD[1].zarib=17.0;//BASE
         //-----USDCHF
         ib=iBarShift("USDCHF"+endSymbol,0,Time[2]);
         if(ib>0){
           ArrayResize(curUSD,ArraySize(curUSD)+1);
           ib=ArraySize(curUSD)-1;
           curUSD[ib].name="USDCHF"+endSymbol; curUSD[ib].curBase="USD"; curUSD[ib].zarib=5.0; //BASE USD1
         }else{printf("loss cur : USDCHF" );curLoss=curLoss+" USDCHF ";}
         //-----GBPUSD
         ib=iBarShift("GBPUSD"+endSymbol,0,Time[2]);
         if(ib>0){
           ArrayResize(curUSD,ArraySize(curUSD)+1);
           ib=ArraySize(curUSD)-1;
           curUSD[ib].name="GBPUSD"+endSymbol; curUSD[ib].curBase="GBP"; curUSD[ib].zarib=12.0; //BASE USD2
         }else{printf("loss cur : GBPUSD" );curLoss=curLoss+" GBPUSD ";}
         //-----USDJPY
         ib=iBarShift("USDJPY"+endSymbol,0,Time[2]);
         if(ib>0){
           ArrayResize(curUSD,ArraySize(curUSD)+1);
           ib=ArraySize(curUSD)-1;
         curUSD[ib].name="USDJPY"+endSymbol; curUSD[ib].curBase="USD"; curUSD[ib].zarib=13.0; //BASE USD3
         }else{printf("loss cur : USDJPY" );curLoss=curLoss+" USDJPY ";}
         //-----USDCAD
         ib=iBarShift("USDCAD"+endSymbol,0,Time[2]);
         if(ib>0){
           ArrayResize(curUSD,ArraySize(curUSD)+1);
           ib=ArraySize(curUSD)-1;
         curUSD[ib].name="USDCAD"+endSymbol; curUSD[ib].curBase="USD"; curUSD[ib].zarib=5.0; //BASE USD4
         }else{printf("loss cur : USDCAD" );curLoss=curLoss+" USDCAD ";}
         //-----AUDUSD
         ib=iBarShift("AUDUSD"+endSymbol,0,Time[2]);
         if(ib>0){
           ArrayResize(curUSD,ArraySize(curUSD)+1);
           ib=ArraySize(curUSD)-1;
         curUSD[ib].name="AUDUSD"+endSymbol; curUSD[ib].curBase="AUD"; curUSD[ib].zarib=6.0; //BASE USD5
         }else{printf("loss cur : AUDUSD" );curLoss=curLoss+" AUDUSD ";}
         //-----NZDUSD
         ib=iBarShift("NZDUSD"+endSymbol,0,Time[2]);
         if(ib>0){
           ArrayResize(curUSD,ArraySize(curUSD)+1);
           ib=ArraySize(curUSD)-1;
         curUSD[ib].name="NZDUSD"+endSymbol; curUSD[ib].curBase="NZD"; curUSD[ib].zarib=4.0; //BASE USD6
         }else{printf("loss cur : NZDUSD" );curLoss=curLoss+" NZDUSD ";}
         //-----------------------------------
         //-----------------------------------
         curEUR[1].name="EURUSD"+endSymbol; curEUR[1].curBase="EUR"; curEUR[1].zarib=9.0; //BASE
         //-----EURCHF
         ib=iBarShift("EURCHF"+endSymbol,0,Time[2]);
         if(ib>0){
           ArrayResize(curEUR,ArraySize(curEUR)+1);
           ib=ArraySize(curEUR)-1;
         curEUR[ib].name="EURCHF"+endSymbol; curEUR[ib].curBase="EUR"; curEUR[ib].zarib=4.0;  //BASE EUR1
         }else{printf("loss cur : EURCHF" );curLoss=curLoss+" EURCHF ";}
         //-----EURGBP
         ib=iBarShift("EURGBP"+endSymbol,0,Time[2]);
         if(ib>0){
           ArrayResize(curEUR,ArraySize(curEUR)+1);
           ib=ArraySize(curEUR)-1;
         curEUR[ib].name="EURGBP"+endSymbol; curEUR[ib].curBase="EUR"; curEUR[ib].zarib=5.0;  //BASE EUR2
         }else{printf("loss cur : EURGBP" );curLoss=curLoss+" EURGBP ";}
         //-----EURJPY
         ib=iBarShift("EURJPY"+endSymbol,0,Time[2]);
         if(ib>0){
           ArrayResize(curEUR,ArraySize(curEUR)+1);
           ib=ArraySize(curEUR)-1;
         curEUR[ib].name="EURJPY"+endSymbol; curEUR[ib].curBase="EUR"; curEUR[ib].zarib=5.0;  //BASE EUR3
         }else{printf("loss cur : EURJPY" );curLoss=curLoss+" EURJPY ";}
         //-----EURCAD
         ib=iBarShift("EURCAD"+endSymbol,0,Time[2]);
         if(ib>0){
           ArrayResize(curEUR,ArraySize(curEUR)+1);
           ib=ArraySize(curEUR)-1;
         curEUR[ib].name="EURCAD"+endSymbol; curEUR[ib].curBase="EUR"; curEUR[ib].zarib=4.0;  //BASE EUR4
         }else{printf("loss cur : EURCAD" );curLoss=curLoss+" EURCAD ";}
         //-----EURAUD
         ib=iBarShift("EURAUD"+endSymbol,0,Time[2]);
         if(ib>0){
           ArrayResize(curEUR,ArraySize(curEUR)+1);
           ib=ArraySize(curEUR)-1;
         curEUR[ib].name="EURAUD"+endSymbol; curEUR[ib].curBase="EUR"; curEUR[ib].zarib=4.0;  //BASE EUR5
         }else{printf("loss cur : EURAUD" );curLoss=curLoss+" EURAUD ";}
         //-----EURNZD
         ib=iBarShift("EURNZD"+endSymbol,0,Time[2]);
         if(ib>0){
           ArrayResize(curEUR,ArraySize(curEUR)+1);
           ib=ArraySize(curEUR)-1;
         curEUR[ib].name="EURNZD"+endSymbol; curEUR[ib].curBase="EUR"; curEUR[ib].zarib=3.0;  //BASE EUR6
         }else{printf("loss cur : EURNZD" );curLoss=curLoss+" EURNZD ";}

        //------- 
        for(int i=1;i<=ArraySize(curEUR)-1;i++)
          {
           curEUR[i].bars=iBars(curEUR[i].name,0);
           if(curEUR[i].bars<lowBar){lowBar=curEUR[i].bars;}
          }
        for(int i=1;i<=ArraySize(curUSD)-1;i++)
          {
           curUSD[i].bars=iBars(curUSD[i].name,0);
           if(curUSD[i].bars<lowBar){lowBar=curUSD[i].bars;}
          }
        //-------   
        printf(ArraySize(curUSD)+"  "+ArraySize(curEUR));
         first=true;
        }
        //printf(ArraySize(curUSD)+"  "+ArraySize(curEUR));
}
//+----------------
void CheckBarShiftEUR(int ib=1){
  CountBarsCurraba();
  datetime time=iTime(curEUR[1].name,0,ib);

  for(int i=1;i<=ArraySize(curEUR)-1;i++)
    {
      curEUR[i].ibs=iBarShift(curEUR[i].name,0,time); 
      //--
      curEUR[i].typeBaseCandel="none";
      if( iClose(curEUR[i].name,0,curEUR[i].ibs)>iOpen(curEUR[i].name,0,curEUR[i].ibs) && curEUR[i].curBase==baseCurEUR ){curEUR[i].typeBaseCandel="long";}
      if( iClose(curEUR[i].name,0,curEUR[i].ibs)>iOpen(curEUR[i].name,0,curEUR[i].ibs) && curEUR[i].curBase!=baseCurEUR ){curEUR[i].typeBaseCandel="short";}
      if( iClose(curEUR[i].name,0,curEUR[i].ibs)<iOpen(curEUR[i].name,0,curEUR[i].ibs) && curEUR[i].curBase==baseCurEUR ){curEUR[i].typeBaseCandel="short";}
      if( iClose(curEUR[i].name,0,curEUR[i].ibs)<iOpen(curEUR[i].name,0,curEUR[i].ibs) && curEUR[i].curBase!=baseCurEUR ){curEUR[i].typeBaseCandel="long";}
    }
}

void CheckBarShiftUSD(int ib=1){
  CountBarsCurraba();
  datetime time=iTime(curUSD[1].name,0,ib);

  for(int i=1;i<=ArraySize(curUSD)-1;i++)
    {
      curUSD[i].ibs=iBarShift(curUSD[i].name,0,time); 
      //--
      curUSD[i].typeBaseCandel="none";
      if( iClose(curUSD[i].name,0,curUSD[i].ibs)>iOpen(curUSD[i].name,0,curUSD[i].ibs) && curUSD[i].curBase==baseCurUSD ){curUSD[i].typeBaseCandel="long";}
      if( iClose(curUSD[i].name,0,curUSD[i].ibs)>iOpen(curUSD[i].name,0,curUSD[i].ibs) && curUSD[i].curBase!=baseCurUSD ){curUSD[i].typeBaseCandel="short";}
      if( iClose(curUSD[i].name,0,curUSD[i].ibs)<iOpen(curUSD[i].name,0,curUSD[i].ibs) && curUSD[i].curBase==baseCurUSD ){curUSD[i].typeBaseCandel="short";}
      if( iClose(curUSD[i].name,0,curUSD[i].ibs)<iOpen(curUSD[i].name,0,curUSD[i].ibs) && curUSD[i].curBase!=baseCurUSD ){curUSD[i].typeBaseCandel="long";}
    }
}

//+----------------
int cntBaseLongEUR;
int cntBaseShortEUR;
void CNTLongShortEUR(int ib){
  CheckBarShiftEUR(ib);
  
  cntBaseLongEUR=0;
  cntBaseShortEUR=0;
  for(int i=1;i<=ArraySize(curEUR)-1;i++)
    {
     if(curEUR[i].typeBaseCandel=="long"){cntBaseLongEUR++;}
     if(curEUR[i].typeBaseCandel=="short"){cntBaseShortEUR++;}
    }
     
  //Comment(ss1+"\n"+"long: "+string(cntLong)+"   short: "+string(cntShort)+"  ||  baseLong: "+string(cntBaseLong)+"   baseShort: "+string(cntBaseShort)+"\n"+baseCur);  
}

int cntBaseLongUSD;
int cntBaseShortUSD;
void CNTLongShortUSD(int ib){
  CheckBarShiftUSD(ib);
  
  cntBaseLongUSD=0;
  cntBaseShortUSD=0;
  for(int i=1;i<=ArraySize(curUSD)-1;i++)
    {
     if(curUSD[i].typeBaseCandel=="long"){cntBaseLongUSD++;}
     if(curUSD[i].typeBaseCandel=="short"){cntBaseShortUSD++;}
    }
     
  //Comment(ss1+"\n"+"long: "+string(cntLong)+"   short: "+string(cntShort)+"  ||  baseLong: "+string(cntBaseLong)+"   baseShort: "+string(cntBaseShort)+"\n"+baseCur);  
}


//+----------------
void powerBarEUR(int ib=1,int cnt=300){
  CheckBarShiftEUR(ib);
  for(int i=1;i<=ArraySize(curEUR)-1;i++)
    {
      double maxPow=iHigh(curEUR[i].name,0,curEUR[i].ibs)-iLow(curEUR[i].name,0,curEUR[i].ibs);
      for(int ii=curEUR[i].ibs;ii<curEUR[i].ibs+cnt;ii++)
        {
          //if(ii>curEUR[i].bars){printf("!! Bars is Low "+curEUR[i].name+"  "+string(ii)+"   "+string(curEUR[i].bars));}
          double tmpMax=iHigh(curEUR[i].name,0,ii)-iLow(curEUR[i].name,0,ii);
          if(tmpMax>maxPow){maxPow=tmpMax;} 
        }
     if(maxPow==0){
        curEUR[i].power=0;}else{
        curEUR[i].power=(iHigh(curEUR[i].name,0,curEUR[i].ibs)-iLow(curEUR[i].name,0,curEUR[i].ibs))/maxPow;   
     }    
     curEUR[i].power=curEUR[i].power*curEUR[i].zarib;
    }

}


void powerBarUSD(int ib=1,int cnt=300){
  CheckBarShiftUSD(ib);
  for(int i=1;i<=ArraySize(curUSD)-1;i++)
    {
      double maxPow=iHigh(curUSD[i].name,0,curUSD[i].ibs)-iLow(curUSD[i].name,0,curUSD[i].ibs);
      for(int ii=curUSD[i].ibs;ii<curUSD[i].ibs+cnt;ii++)
        {
          //if(ii>curUSD[i].bars){printf("!! Bars is Low "+curUSD[i].name+"  "+string(ii)+"   "+string(curUSD[i].bars));}
          double tmpMax=iHigh(curUSD[i].name,0,ii)-iLow(curUSD[i].name,0,ii);
          if(tmpMax>maxPow){maxPow=tmpMax;} 
        }
     if(maxPow==0)
       {
        curUSD[i].power=0;}else{  
        curUSD[i].power=(iHigh(curUSD[i].name,0,curUSD[i].ibs)-iLow(curUSD[i].name,0,curUSD[i].ibs))/maxPow; 
      }
     curUSD[i].power=curUSD[i].power*curUSD[i].zarib; 
    }

}


//+----------------

double powerBaseLongEUR;
double powerBaseShortEUR;

double PowerLongShortEUR(int ib,int cnt=300){
  powerBarEUR(ib,cnt);
  powerBaseLongEUR=0;
  powerBaseShortEUR=0;
  for(int i=1;i<=ArraySize(curEUR)-1;i++)
    {
       
     if(curEUR[i].typeBaseCandel=="long")
       {
        powerBaseLongEUR=powerBaseLongEUR+curEUR[i].power;
       }
     else if(curEUR[i].typeBaseCandel=="short")
       {
        powerBaseShortEUR=powerBaseShortEUR+curEUR[i].power;
       }
    }

   return powerBaseLongEUR/(powerBaseLongEUR+powerBaseShortEUR);
}


double powerBaseLongUSD;
double powerBaseShortUSD;

double PowerLongShortUSD(int ib,int cnt=300){
  powerBarUSD(ib,cnt);
  powerBaseLongUSD=0;
  powerBaseShortUSD=0;
  for(int i=1;i<=ArraySize(curUSD)-1;i++)
    {
       
     if(curUSD[i].typeBaseCandel=="long")
       {
        powerBaseLongUSD=powerBaseLongUSD+curUSD[i].power;
       }
     else if(curUSD[i].typeBaseCandel=="short")
       {
        powerBaseShortUSD=powerBaseShortUSD+curUSD[i].power;
       }
    }

   return powerBaseLongUSD/(powerBaseLongUSD+powerBaseShortUSD);
}


//+----------------

//+----------------

double powerBaseLongIMAEUR;
double powerBaseShortIMAEUR;

void PowerLongShortIMAEUR(int ib,double periodss=3,int cnt=300){
  powerBaseLongIMAEUR=0;
  powerBaseShortIMAEUR=0;
  
  powerBaseLongEUR=0;
  powerBaseShortEUR=0;
  for(int ip=1;ip<=periodss;ip++)
    {
     powerBarEUR(ib+ip-1,cnt);
     for(int i=1;i<=ArraySize(curEUR)-1;i++)
       {
        if(curEUR[i].typeBaseCandel=="long")
          {
           powerBaseLongIMAEUR=powerBaseLongIMAEUR+curEUR[i].power;
          }
        else if(curEUR[i].typeBaseCandel=="short")
          {
           powerBaseShortIMAEUR=powerBaseShortIMAEUR+curEUR[i].power;
          }
       }
     ///----
     ///----
    }  
  //--
  powerBaseLongIMAEUR=powerBaseLongIMAEUR/periods;
  powerBaseShortIMAEUR=powerBaseShortIMAEUR/periods;
  //--   
}
double powerBaseLongIMAEUR_AB[];
double powerBaseShortIMAEUR_AB[];
void PowerLongShortIMAEUR_AB(int a,int b,int cnt=300){
 
     ArrayResize(powerBaseLongIMAEUR_AB,b-a+2+periods);
     ArrayResize(powerBaseShortIMAEUR_AB,b-a+2+periods);
     int c=0;
     for(int i=a;i<=b+periods;i++)
       {
        c++;
        powerBaseLongIMAEUR_AB[c]=0;
        powerBaseShortIMAEUR_AB[c]=0;
        powerBarEUR(i,cnt);
        for(int i=1;i<=ArraySize(curEUR)-1;i++)
          {
           if(curEUR[i].typeBaseCandel=="long")
             {
              powerBaseLongIMAEUR_AB[c]=powerBaseLongIMAEUR_AB[c]+curEUR[i].power;
             }
           else if(curEUR[i].typeBaseCandel=="short")
             {
              powerBaseShortIMAEUR_AB[c]=powerBaseShortIMAEUR_AB[c]+curEUR[i].power;
             }
          }
       }
     c=0;  
     for(int i=a;i<=b;i++)
       {
        c++;
        for(int ip=1;ip<periods;ip++)
          {
           powerBaseLongIMAEUR_AB[c]=powerBaseLongIMAEUR_AB[c]+powerBaseLongIMAEUR_AB[c+ip];
           powerBaseShortIMAEUR_AB[c]=powerBaseShortIMAEUR_AB[c]+powerBaseShortIMAEUR_AB[c+ip];
          }
          powerBaseLongIMAEUR_AB[c]=powerBaseLongIMAEUR_AB[c]/double(periods); 
          powerBaseShortIMAEUR_AB[c]=powerBaseShortIMAEUR_AB[c]/double(periods); 
       }

}
double powerBaseLongIMAUSD;
double powerBaseShortIMAUSD;

void PowerLongShortIMAUSD(int ib,double periodss=3,int cnt=300){
  powerBaseLongIMAUSD=0;
  powerBaseShortIMAUSD=0;
  
  powerBaseLongUSD=0;
  powerBaseShortUSD=0;
  for(int ip=1;ip<=periodss;ip++)
    {
     powerBarUSD(ib+ip-1,cnt);
     for(int i=1;i<=ArraySize(curUSD)-1;i++)
       {
        if(curUSD[i].typeBaseCandel=="long")
          {
           powerBaseLongIMAUSD=powerBaseLongIMAUSD+curUSD[i].power;
          }
        else if(curUSD[i].typeBaseCandel=="short")
          {
           powerBaseShortIMAUSD=powerBaseShortIMAUSD+curUSD[i].power;
          }
       }
     ///----
     ///----
    }  
  //--
  powerBaseLongIMAUSD=powerBaseLongIMAUSD/periods;
  powerBaseShortIMAUSD=powerBaseShortIMAUSD/periods;
  //--   
}
double powerBaseLongIMAUSD_AB[];
double powerBaseShortIMAUSD_AB[];
void PowerLongShortIMAUSD_AB(int a,int b,int cnt=300){

     ArrayResize(powerBaseLongIMAUSD_AB,b-a+2+periods);
     ArrayResize(powerBaseShortIMAUSD_AB,b-a+2+periods);
     int c=0;
     for(int i=a;i<=b+periods;i++)
       {
        c++;
        powerBaseLongIMAUSD_AB[c]=0;
        powerBaseShortIMAUSD_AB[c]=0;
        powerBarUSD(i,cnt);
        for(int i=1;i<=ArraySize(curUSD)-1;i++)
          {
           if(curUSD[i].typeBaseCandel=="long")
             {
              powerBaseLongIMAUSD_AB[c]=powerBaseLongIMAUSD_AB[c]+curUSD[i].power;
             }
           else if(curUSD[i].typeBaseCandel=="short")
             {
              powerBaseShortIMAUSD_AB[c]=powerBaseShortIMAUSD_AB[c]+curUSD[i].power;
             }
          }
    }


     c=0;  
     for(int i=a;i<=b;i++)
       {
        c++;
        for(int ip=1;ip<periods;ip++)
          {
           powerBaseLongIMAUSD_AB[c]=powerBaseLongIMAUSD_AB[c]+powerBaseLongIMAUSD_AB[c+ip];
           powerBaseShortIMAUSD_AB[c]=powerBaseShortIMAUSD_AB[c]+powerBaseShortIMAUSD_AB[c+ip];
          }
          powerBaseLongIMAUSD_AB[c]=powerBaseLongIMAUSD_AB[c]/double(periods); 
          powerBaseShortIMAUSD_AB[c]=powerBaseShortIMAUSD_AB[c]/double(periods);
       }

}








struct ObjectssChart{
  int chartX;
  int chartY;
  struct Objects{
    string object_name;
    ENUM_OBJECT object_type;
    string text;
    string texttmp;
    string textc;
    int xd;
    int yd;
    int xdtmp;
    int ydtmp;
    int xdc;
    int ydc;
    int xs;
    int ys;
    int xstmp;
    int ystmp;
    int xsc;
    int ysc;
    
    int fontSize;
    int fontSizetmp;
    int fontSizec;
    
    color colorBack;
    color colorBorder;
    color colorText;
    color colorBacktmp;
    color colorBordertmp;
    color colorTexttmp;
    
    
    color MouseOverColorBack;
    color MouseOverColorBorder;
    color MouseOverColorText;
    
    color MouseClickColorBack;
    color MouseClickColorBorder;
    color MouseClickColorText;
    
    long chart_id;
    int ekhMY;
    int ekhMX;
    bool customMoveX;
    bool customMoveY;
    bool enableMouseOver;
    bool enableMouseClick;
    int width;
    string font;
    bool enableDelect;
    bool hide;
  };
  
  
Objects obj[];
 
int add(string name){
   for(int i=1;i<=ArraySize(obj)-1;i++)
     {
      if(name==obj[i].object_name || ObjectFind(ChartID(),name)==0)
        {
         return -1;
        }
     }
   if(ArraySize(obj)<=0)
     {
      ArrayResize(obj,1);
     }
   ArrayResize(obj,ArraySize(obj)+1);
   return ArraySize(obj)-1;
} 

//------------------------------------------------++  
 bool creatObject(long chart_id=0,
                  string object_name="ObLabel",
                  ENUM_OBJECT object_type=OBJ_LABEL,
                  int xd=0, int yd=0,
                  int xs=50, int ys=50,
                  string text="Label",
                  color colorBack=clrBlack,
                  color colorBorder=clrBlack,
                  color colorText=clrRed,
                  int fontSize=10,
                  int width=1,
                  string font="Tahoma Bold",
                  
                  color MouseOvercolorBack=clrYellow,
                  color MouseOvercolorBorder=clrYellow,
                  color MouseOvercolorText=clrYellow,
                  
                  color MouseClickcolorBack=clrRed,
                  color MouseClickcolorBorder=clrRed,
                  color MouseClickcolorText=clrRed,
                  
                  bool enableMouseOver=false,
                  bool enableMouseClick=false,
                  bool enableDelect=false
                  ){
     //-------------------
     nameObjectClick="";
     //-----------------
     int id=add(object_name);
     if(id==-1) {return false;}  
     //--
     getChartXY();
     obj[id].object_name=object_name;
     obj[id].object_type=object_type;
     
     obj[id].text=text;
     obj[id].texttmp=text;
     obj[id].textc=text;
     
     obj[id].xs=xs;
     obj[id].ys=ys;
     
     obj[id].xstmp=xs;
     obj[id].xsc=xs;
     
     obj[id].ystmp=ys;
     obj[id].ysc=ys;
     
     obj[id].xd=xd;
     obj[id].xdtmp=xd;
     obj[id].xdc=xd;
     obj[id].yd=yd;
     obj[id].ydtmp=yd;
     obj[id].ydc=yd;
     
     obj[id].fontSize=fontSize;
     obj[id].fontSizetmp=fontSize;
     obj[id].fontSizec=fontSize;
     
     obj[id].colorBack=colorBack;
     obj[id].colorBorder=colorBorder;
     obj[id].colorText=colorText;
     
     obj[id].colorBacktmp=colorBack;
     obj[id].colorBordertmp=colorBorder;
     obj[id].colorTexttmp=colorText;
     
     obj[id].MouseOverColorBack=MouseOvercolorBack;
     obj[id].MouseOverColorBorder=MouseOvercolorBorder;
     obj[id].MouseOverColorText=MouseOvercolorText;

     obj[id].MouseClickColorBack=MouseClickcolorBack;
     obj[id].MouseClickColorBorder=MouseClickcolorBorder;
     obj[id].MouseClickColorText=MouseClickcolorText;
     
     obj[id].chart_id=chart_id;
     obj[id].width=width;
     obj[id].font=font;
     obj[id].enableMouseOver=enableMouseOver;
     obj[id].enableMouseClick=enableMouseClick;
     obj[id].enableDelect=enableDelect;
     obj[id].hide=false;
     
     //----
     crt(id); 
 return true;
 }
//------------------------------------------------++  
void crt(int id){   
    ObjectCreate(obj[id].chart_id,obj[id].object_name,obj[id].object_type,0,0,0,0);
    ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_XSIZE,obj[id].xs);
    ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_YSIZE,obj[id].ys);
    ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_XDISTANCE,obj[id].xd);
    ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_YDISTANCE,chartY-obj[id].ys-obj[id].yd);
    
    ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_COLOR,obj[id].colorText);
    ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_BGCOLOR,obj[id].colorBack);
    ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_BORDER_COLOR,obj[id].colorBorder);
    
    ObjectSetString(obj[id].chart_id,obj[id].object_name,OBJPROP_TEXT,obj[id].text);
    ObjectSetString(obj[id].chart_id,obj[id].object_name,OBJPROP_FONT,obj[id].font);
    ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_FONTSIZE,obj[id].fontSize);
    
    ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_WIDTH,obj[id].width);
    ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_BORDER_TYPE,BORDER_SUNKEN);
    ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_SELECTABLE,false);
    if(obj[id].object_type==OBJ_RECTANGLE_LABEL)
      {
        ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_BORDER_TYPE,BORDER_FLAT);
      }
}

//------------------------------------------------++  
void crtTmp(int id){  
    obj[id].hide=false;
    obj[id].xs=obj[id].xsc;
    obj[id].ys=obj[id].ysc;
    obj[id].xd=obj[id].xdc;
    obj[id].yd=obj[id].ydc;
    obj[id].text=obj[id].textc;
    obj[id].fontSize=obj[id].fontSizec;
    ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_XSIZE,obj[id].xs);
    ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_YSIZE,obj[id].ys);
    ObjectSetString(obj[id].chart_id,obj[id].object_name,OBJPROP_TEXT,obj[id].text);
    ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_FONTSIZE,obj[id].fontSize);
    ObjectSetString(obj[id].chart_id,obj[id].object_name,OBJPROP_TEXT,obj[id].text);
    if(obj[id].customMoveY)
      {
         ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_YDISTANCE,obj[id].yd);
      } else{
         ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_YDISTANCE,chartY-obj[id].ys-obj[id].yd);
      }
     ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_XDISTANCE,obj[id].xd);
    ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_COLOR,obj[id].colorText);
    ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_BGCOLOR,obj[id].colorBack);
    ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_BORDER_COLOR,obj[id].colorBorder);
     
}
//------------------------------------------------++  
void emptyObject(int id){ 
    obj[id].xsc=obj[id].xs;
    obj[id].xs=0;
    obj[id].ysc=obj[id].ys;
    obj[id].ys=0;
    obj[id].xdc=obj[id].xd;
    obj[id].xd=-1000;
    obj[id].ydc=obj[id].yd;
    obj[id].yd=-1000;
    obj[id].textc=obj[id].text;
    obj[id].text="";
    obj[id].fontSizec=obj[id].fontSize;
    obj[id].fontSize=0;
    obj[id].hide=true;
    ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_XSIZE,obj[id].xs);
    ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_YSIZE,obj[id].ys);
    ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_XDISTANCE,obj[id].xd);
    ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_YDISTANCE,obj[id].yd);
    ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_FONTSIZE,obj[id].fontSize);
    ObjectSetString(obj[id].chart_id,obj[id].object_name,OBJPROP_TEXT,obj[id].text);
    
    ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_COLOR,clrNONE);
    ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_BGCOLOR,clrNONE);
    ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_BORDER_COLOR,clrNONE);
}

//------------------------------------------------++  
int getId(string object_name){
 for(int i=1;i<=ArraySize(obj)-1;i++)
   {
    if(obj[i].object_name==object_name)
      {
       return i;
      }
   }
   return -1;
}
//------------------------------------------------++  
void hiddenAllObject(string without=""){
   for(int id=1;id<=ArraySize(obj)-1;id++){
      if(obj[id].object_name!=without)
        {
          emptyObject(id);
        }
    }
}
//------------------------------------------------++  
void hiddenObject(string objs=""){
   int id=getId(objs);
   emptyObject(id);
}
//------------------------------------------------++  
void showObject(string objs=""){ 
   getChartXY();
   int id=getId(objs);
   crtTmp(id);
}
//------------------------------------------------++  
void showAllObject(string without=""){
  getChartXY();
   for(int id=1;id<=ArraySize(obj)-1;id++){
      if(obj[id].object_name!=without)
        {
          crtTmp(id);
        }
    } 
}
//------------------------------------------------++  
void moveModel(){
   getChartXY();
   for(int id=1;id<=ArraySize(obj)-1;id++)
     {
       if(obj[id].hide==false)
         {
          ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_XDISTANCE,obj[id].xd);
          if(obj[id].customMoveY)
            {
              ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_YDISTANCE,obj[id].yd);
            }else{
              ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_YDISTANCE,chartY-obj[id].ystmp-obj[id].ydtmp);
            }
          if(obj[id].customMoveX)
            {
              ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_XDISTANCE,obj[id].xd);
            }else{
              ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_XDISTANCE,obj[id].xdtmp);
            }
         }  
     }
}
//------------------------------------------------++  
bool checkMouseOver(string object_name="button",int lparam=0,int dparam=0){
  int id=getId(object_name);
  
  int left=getLeft(id);
  int righ=getRight(id);
  int top=getTop(id);
  int bottom=getBottom(id);
  
  if(lparam>left && lparam<righ && dparam>top && dparam<bottom && obj[id].enableMouseOver)
    {
      ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_COLOR,obj[id].MouseOverColorText);
      ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_BGCOLOR,obj[id].MouseOverColorBack);
      ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_BORDER_COLOR,obj[id].MouseOverColorBorder);
      ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_STATE,false);
      return true;
    }else{
      ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_COLOR,obj[id].colorText);
      ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_BGCOLOR,obj[id].colorBack);
      ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_BORDER_COLOR,obj[id].colorBorder);
      ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_STATE,false);
    }
return false;
}
string nameObjectClick;
string checkMouseClick(string sparam="1",int lparam=0,int dparam=0){
     string objs=checkAllObjectMouseOver(lparam,dparam);
     int id=0;
     if(nameObjectClick!="") {id=getId(nameObjectClick);}
     if(sparam=="1" && objs!="" && nameObjectClick=="" && obj[id].enableMouseClick)
       {
           nameObjectClick=objs; 
           getEkhteleafMouseY(objs,lparam,dparam);
           getEkhteleafMouseX(objs,lparam,dparam);
           ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_COLOR,obj[id].MouseClickColorText);
           ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_BGCOLOR,obj[id].MouseClickColorBack);
           ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_BORDER_COLOR,obj[id].MouseClickColorBorder);
       }
     else if (sparam=="1" && nameObjectClick!="")
       {
          nameObjectClick=""; 
       }
   //-----move this object 
   if(nameObjectClick!="")
     {
       moveByMouseY(nameObjectClick,lparam,dparam );
       moveByMouseX(nameObjectClick,lparam,dparam );
     } 
    return  nameObjectClick;
}

string checkMouseClickMoveTotal(string sparam="1",int lparam=0,int dparam=0,string specialObject=""){

     string objs=checkAllObjectMouseOver(lparam,dparam);
     if(sparam=="1" && objs!="" && nameObjectClick=="")
       {
           nameObjectClick=objs; 
           int id=getId(nameObjectClick);
           for(int i=1;i<=ArraySize(obj)-1;i++)
             {
               getEkhteleafMouseY(obj[i].object_name,lparam,dparam);
               getEkhteleafMouseX(obj[i].object_name,lparam,dparam);
             }
           ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_COLOR,obj[id].MouseClickColorText);
           ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_BGCOLOR,obj[id].MouseClickColorBack);
           ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_BORDER_COLOR,obj[id].MouseClickColorBorder);
       }
     else if (sparam=="1" && nameObjectClick!="")
       {
          nameObjectClick=""; 
       }
   //-----move this object 
   if(nameObjectClick!="" && (specialObject=="" || nameObjectClick==specialObject) )
     {
      for(int i=1;i<=ArraySize(obj)-1;i++)
        {
         if(checkAllObjectCanMoveXY(lparam,dparam))
           {
              moveByMouseY(obj[i].object_name,lparam,dparam );
              moveByMouseX(obj[i].object_name,lparam,dparam );
           }
        }
     } 
    return  nameObjectClick;
}


string nameObjectMouseOver;
string checkAllObjectMouseOver(int lparam=0,int dparam=0){
for(int i=1;i<=ArraySize(obj)-1;i++)
  {
   if(checkMouseOver(obj[i].object_name,lparam,dparam))
     {
       nameObjectMouseOver=obj[i].object_name;
       return obj[i].object_name;
     }
  }
nameObjectMouseOver="";
return "";
}
//------------------------------------------------++  
void reset(){
   getChartXY();
   for(int id=1;id<=ArraySize(obj)-1;id++)
     {
       obj[id].xs=obj[id].xstmp;
       obj[id].ys=obj[id].ystmp;
       obj[id].xd=obj[id].xdtmp;
       obj[id].yd=obj[id].ydtmp;
       obj[id].text=obj[id].texttmp;
       obj[id].fontSize=obj[id].fontSizetmp;
       obj[id].customMoveX=false;
       obj[id].customMoveY=false;
       ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_XSIZE,obj[id].xs);
       ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_YSIZE,obj[id].ys);
       ObjectSetString(obj[id].chart_id,obj[id].object_name,OBJPROP_TEXT,obj[id].text);
       ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_FONTSIZE,obj[id].fontSize);
       ObjectSetString(obj[id].chart_id,obj[id].object_name,OBJPROP_TEXT,obj[id].text);
       ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_YDISTANCE,chartY-obj[id].ys-obj[id].yd);
       ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_XDISTANCE,obj[id].xd);
     }

}
//------------------------------------------------++  
void moveByMouseY(string object_name="obj",int lparam=0,int dparam=0){
  int id=getId(object_name);
  if(checkCanMoveY(id,lparam,dparam))
    {
      ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_YDISTANCE,dparam-obj[id].ekhMY);
      obj[id].yd=dparam-obj[id].ekhMY;
      obj[id].customMoveY=true;
    }
}
bool checkCanMoveY(int id,int lparam=0,int dparam=0){
  if(dparam-obj[id].ekhMY>0 && (dparam-obj[id].ekhMY)+obj[id].ys<chartY){return true;}
  return false;
}
void moveByMouseX(string object_name="obj",int lparam=0,int dparam=0){
  int id=getId(object_name);
  if(checkCanMoveX(id,lparam,dparam))
    {
       ObjectSetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_XDISTANCE,lparam-obj[id].ekhMX);
       obj[id].xd=lparam-obj[id].ekhMX;
       obj[id].customMoveX=true;
    }
}
bool checkCanMoveX(int id,int lparam=0,int dparam=0){
  if(lparam-obj[id].ekhMX>0 && (lparam-obj[id].ekhMX)+obj[id].xs<chartX){return true;}
  return false;
}

//---
bool checkAllObjectCanMoveXY(int lparam=0,int dparam=0){
  for(int i=1;i<=ArraySize(obj)-1;i++)
    {
     int id=getId(obj[i].object_name);
     if(checkCanMoveY(id,lparam,dparam)==false || checkCanMoveX(id,lparam,dparam)==false)
       {
        return false;
       }
    }
return true;
}
//------------------------------------------------++  


//------------------------------------------------++  
int getTop(int id){
  return ObjectGetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_YDISTANCE);
}
int getBottom(int id){
  return  getTop(id)+ObjectGetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_YSIZE);
}
int getLeft(int id){
  return ObjectGetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_XDISTANCE);
}
int getRight(int id){
  return  getLeft(id)+ObjectGetInteger(obj[id].chart_id,obj[id].object_name,OBJPROP_XSIZE);
}
void getEkhteleafMouseY(string object_name="obj",int lparam=0,int dparam=0){
    int id=getId(object_name);
    obj[id].ekhMY=(dparam-getTop(id));
}
void getEkhteleafMouseX(string object_name="obj",int lparam=0,int dparam=0){
    int id=getId(object_name);
    obj[id].ekhMX=(lparam-getLeft(id));
}
//------------------------------------------------++  
void getChartXY(){
  long x_distance;
  long y_distance;
  //--- set window size
  ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0,y_distance);
  ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0,x_distance);     
  chartX=x_distance;
  chartY=y_distance;
}
//------------------------------------------------++  
void changeAllWigth(int wigth=10){
for(int i=1;i<=ArraySize(obj)-1;i++)
  {
   if(obj[i].object_type==OBJ_TREND)
     {
       obj[i].width=wigth;
       ObjectSetInteger(obj[i].chart_id,obj[i].object_name,OBJPROP_WIDTH,obj[i].width);
     }
  }
}
//------------------------------------------------++  
void setText(string object_name="obj",string text="test"){
    int id=getId(object_name);
    obj[id].text=text;
    //obj[id].texttmp=text;
    ObjectSetString(obj[id].chart_id,obj[id].object_name,OBJPROP_TEXT,obj[id].text);
}
//------------------------------------------------++  
int getTextInt(string object_name="editor"){
    int id=getId(object_name);
    return int(ObjectGetString(obj[id].chart_id,obj[id].object_name,OBJPROP_TEXT));
}
//------------------------------------------------++  
string getTextStr(string object_name="editor"){
    int id=getId(object_name);
    return ObjectGetString(obj[id].chart_id,obj[id].object_name,OBJPROP_TEXT);
}
//------------------------------------------------++   
void setColorClick(string object_name="editor"){
   int id=getId(object_name);
   obj[id].colorText=obj[id].MouseClickColorText;
   obj[id].colorBack=obj[id].MouseClickColorBack;
   obj[id].colorBorder=obj[id].MouseClickColorBorder;
}
//------------------------------------------------++  
void offColorClick(string object_name="editor"){
   int id=getId(object_name);
   obj[id].colorText=obj[id].colorTexttmp;
   obj[id].colorBack=obj[id].colorBacktmp;
   obj[id].colorBorder=obj[id].colorBordertmp;
}
//------------------------------------------------++  
};

ObjectssChart objB;
ObjectssChart objC;


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