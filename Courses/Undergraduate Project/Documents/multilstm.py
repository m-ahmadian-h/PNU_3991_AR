# -*- coding: utf-8 -*-
"""multiLstmn.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/10RVyYjf_G_apkehoMTCymGCNn3GAauwf
"""

# Commented out IPython magic to ensure Python compatibility.
# %tensorflow_version 2.x
import tensorflow as tf
from google.colab import drive
import numpy as np
import tensorflow.keras as ks
import timeit
import pandas as pd
#!pip install tpucolab
#import os
#import google as gg
from tensorflow.keras.models import Sequential, Model
from tensorflow.keras.layers import Dense, Dropout, Flatten, Conv2D, MaxPooling2D
import matplotlib.pyplot as plt
#from multiprocessing import Pool
#import time
from tensorflow.keras.models import load_model
#import zipfile
#import pprint
#from tpucolab import *
from tensorflow.python.client import device_lib
#!cat /proc/meminfo
#!cat /proc/cpuinfo
#!pip install --upgrade tensorflow
#print('>>> tensorflow version: ***',tf.__version__,'***')
#print(device_lib.list_local_devices())

drive.mount('/content/gdrive')
!unzip "/content/gdrive/My Drive/data52.zip"
data=pd.read_csv('data52.csv',names=["v1","v2","v3","v4","v5","v6","v7","v8"])  
#datainput=np.loadtxt('data9.csv',delimiter=',',dtype='float32')

zig0=np.zeros((datainput.shape[0],3))
zig1=np.zeros((datainput.shape[0],3))
zig2=np.zeros((datainput.shape[0],3))
zig3=np.zeros((datainput.shape[0],3))
for i in range(datainput.shape[0]-1,10000,-1):
  c0,c1,c2,c3=0,0,0,0
  for j in range(0,100000,1):
    if c0<3:
      if datainput[i-j,0]>0:
        zig0[i,c0]=datainput[i-j,0]
        c0=c0+1
    else:
      break
  for j in range(0,100000,1):
    if c1<3:
      if datainput[i-j,1]>0:
        zig1[i,c1]=datainput[i-j,1]
        c1=c1+1
    else:
      break
  for j in range(0,100000,1):
    if c2<3:
      if datainput[i-j,2]>0:
        zig2[i,c2]=datainput[i-j,2]
        c2=c2+1
    else:
      break
  for j in range(0,100000,1):
    if c3<3:
      if datainput[i-j,3]>0:
        zig3[i,c3]=datainput[i-j,3]
        c3=c3+1
    else:
      break

close  =data.get(["v1"]).values[0:]
close  =np.array(close,'float32')
#-------------------------------------------------------------------------------------------------------------
datainput2  =data.get(["v1","v2","v3","v4","v5","v6","v7","v8","v13","v14","v15","v16","v17","v18"]).values[:]
datainput2  =np.array(datainput2,'float32')
#-------------------------------------------
zig=np.zeros((datainput.shape[0],8))
for i in range(zig.shape[0]):
  zig[i,0]=zig0[i,1]
  zig[i,1]=zig0[i,2]
  zig[i,2]=zig1[i,1]
  zig[i,3]=zig1[i,2]
  zig[i,4]=zig2[i,1]
  zig[i,5]=zig2[i,2]
  zig[i,6]=zig3[i,1]
  zig[i,7]=zig3[i,2]

data1=np.zeros((zig.shape[0],22))
for i in range(data1.shape[0]):
  data1[i,0:14]=datainput2[i,:14]
  data1[i,14:]=(close[i]-zig[i,:])*100000
#-----------------------------------------
datasave=data1[15000:736000]
np.savetxt('/content/gdrive/My Drive/zig.csv',datasave,delimiter=',')
#---------------------------------------------------------------------
from google.colab import drive
drive.mount('/content/drive')

plt.plot(data1[15000:,23])

plt.plot(datax[0,:])

c=0
for i in range(datax.shape[0]):
  if datay[i]<-30:
    c=c+1
c

testpredict(prte)
testpredict(testpredict(model.predict(datax_test)))



with open('/content/gdrive/My Drive/Save_models/lstm6.txt', 'w') as f:
      f.write(str(20000))

prte=(model.predict(datax_test[:,:,:]))
testpredict(prte)

model=load_model('/content/gdrive/My Drive/Save_models/multiLstm2.h5')
prte=(model.predict(datax_test))
#testpredict(prte)

def testpredict(prte):
  f,t,x=0,0,0
  for i in range(datax_test.shape[0]):
    if datay_test[i,x]>0.5 and prte[i,x]>0.55:
      t=t+1
    if datay_test[i,x]<0.5 and prte[i,x]<0.45:
      t=t+1
    if datay_test[i,x]>0.5 and prte[i,x]<0.45:
      f=f+1
    if datay_test[i,x]<0.5 and prte[i,x]>0.55:
      f=f+1
  print("true predict:",(t+f))    
  print("true predict:",t/(t+f)*100)
  
testpredict(model.predict(datax_test))

x=1200
for i in range(datax_test.shape[2]):
  if datax_test[x,-1,i]>0:
    print(i)
    print(datay_test[x])
    print(prte[x])
    break

np.savetxt('targetbuy.txt',datay_test[:],delimiter=',')
np.savetxt('buy.txt',prte,delimiter=',')

in2_len  = 1
target   = 0
data_len = 15000
def Mmodel():
  Dropout   = 0.6
  neuron    = 2

  inputlayer= tf.keras.layers.Input  (shape=(input_len,in2_len                                    )           )
  layer     = tf.keras.layers.LSTM   (neuron ,return_sequences=True,recurrent_activation='sigmoid')(inputlayer)
  #layer     = tf.keras.layers.Dropout(Dropout                                                     )(     layer)
  layer     = tf.keras.layers.LSTM   (neuron ,return_sequences=True,recurrent_activation='sigmoid')(     layer)
  layer     = tf.keras.layers.LSTM   (neuron                       ,recurrent_activation='sigmoid')(     layer)
  #layer     = tf.keras.layers.Dropout(Dropout                                                     )(     layer)
  layer     = tf.keras.layers.Dense  (1      ,activation="sigmoid"                                   )(     layer)
  model     = tf.keras.Model         (inputlayer,layer                                            )

  model.summary()
  #ks.utils.plot_model(model, show_shapes=True, show_layer_names=False, dpi=75)
  #--------------------------------------------------------------------------------------------------
  model.compile(optimizer=tf.keras.optimizers.Adam(),loss=tf.keras.losses.mse)#,metrics=['acc']
  return model
TEST=[]
model=Mmodel()

model.save('/content/gdrive/My Drive/Save_models/multiLstm1.h5')

in2_len  = 1
target   = 0
data_len = 15000
def Mmodel():
  Dropout   = 0.25
  neuron    = 5

  inputlayer= tf.keras.layers.Input  (shape=(input_len,in2_len,1                                    )           )
  layer     = tf.keras.layers.Conv2D   (32, kernel_size=(5, 2),activation='relu')(inputlayer)
  layer     = tf.keras.layers.MaxPooling2D   (pool_size=(2, 2), strides=(2, 2))(     layer)
  #layer     = tf.keras.layers.Dropout(Dropout                                                     )(     layer)
  layer     = tf.keras.layers.Conv2D   (64, (5, 2), activation='relu')(     layer)
  layer     = tf.keras.layers.MaxPooling2D   (pool_size=(2, 2))(     layer)
  layer     = tf.keras.layers.Flatten   ()(     layer)
  layer     = tf.keras.layers.Dense   (100)(     layer)
  #layer     = tf.keras.layers.Dropout(Dropout                                                     )(     layer)
  layer     = tf.keras.layers.Dense  (1 ,activation="sigmoid"                                            )(     layer)
  model     = tf.keras.Model         (inputlayer,layer                                            )

  #model.summary()
  #ks.utils.plot_model(model, show_shapes=True, show_layer_names=False, dpi=75)
  #---------------------------------------------------------------------------------------------------
  model.compile(optimizer=tf.keras.optimizers.Adam(),loss=tf.keras.losses.mse)#,metrics=['acc']
  return model
TEST=[]
model=Mmodel()
history=model.fit(datax_train[:,:,:],datay_train[:],batch_size=128,validation_data=(datax_test[:,:,:],datay_test[:]),epochs=1000)

for i in range(10):
  print(i)
  history=model.fit(datax_train[:data_len,:,:in2_len],datay_train[:data_len],batch_size=128,validation_data=(datax_test[:,:,:in2_len],datay_test[:]),epochs=1)
  q=!cat /content/gdrive/My\ Drive/Save_models/lstm3.txt
  if (float(q[0]))>(history.history['val_loss'][0]):
    qq=str(history.history['val_loss'])
    with open('/content/gdrive/My Drive/Save_models/lstm3.txt', 'w') as f:
      f.write(str(history.history['val_loss'][0]))
    model.save('/content/gdrive/My Drive/Save_models/multiLstm3.h5')

def outo():
  neuron    = 2
  Dropout   = 0.25
  inputlayer= tf.keras.layers.Input  (shape=(input_len,3))
  layer     = tf.keras.layers.Dense  (neuron,activation="sigmoid"   )(inputlayer)
  
  #layer     = tf.keras.layers.Dropout(Dropout                                                     )(     layer)
  layer     = tf.keras.layers.Dense  (neuron  ,activation="sigmoid"  )(     layer)
  layer     = tf.keras.layers.Dense  (neuron  ,activation="sigmoid"  )(     layer)
  #layer     = tf.keras.layers.Dense  (neuron   )(     layer)
  #layer     = tf.keras.layers.Dropout(Dropout                                                     )(     layer)
  layer     = tf.keras.layers.Flatten  (  )(     layer)
  layer     = tf.keras.layers.Dense  (neuron ,activation="sigmoid"   )(     layer)
  layer     = tf.keras.layers.Dense  (1  ,activation="sigmoid"    )(     layer)
  model     = tf.keras.Model         (inputlayer ,layer)

  #model.summary()
  #ks.utils.plot_model(model, show_shapes=True, show_layer_names=False, dpi=75)
  #--------------------------------------------------------------------------------------------------
  model.compile(optimizer=tf.keras.optimizers.Adam(),loss=tf.keras.losses.mse)#,metrics=['acc']
  return model
TEST=[]
model=outo()

model.summary()

history=model.fit(datax,datay,batch_size=128,epochs=1000)

prte=model.predict(datax[:])
x=0
plt.plot(prte[x:x+200,0],'r')
plt.plot(datay[x:x+200],'b')

def testpredict(prte):
  t,f,su=0,0,0
  for i in range(datay.shape[0]):
    if (prte[i])>=0.5 and (datay[i])>=0.5:
      t=t+1
    elif (prte[i])<0.5 and (datay[i])<0.5:
      t=t+1
    else:
      f=f+1    
  if t+f>0:
    print(t/(t+f))
testpredict(prte)

datax_test=(model.predict(datax_test)).reshape(datax_test.shape[0],200,2)
datax_train=(model.predict(datax_train)).reshape(datax_train.shape[0],200,2)

plt.plot(datax_test[0,:100],'b')
plt.plot(pr[0,:100],'r')

'''
model=load_model('/content/gdrive/My Drive/Save_models/multiLstm4.h5')
prte=(model.predict(datax_test[:,:,:in2_len]))
testpredict(prte)
#np.savetxt('targetbuy.txt',datay_test[:,6],delimiter=',')
#np.savetxt('buy.txt',prte,delimiter=',')
'''

w,u,b=mo.layers[1].get_weights()
print(w.shape,u.shape,b.shape)
np.savetxt('w.txt',w,delimiter=',')
np.savetxt('u.txt',u,delimiter=',')
np.savetxt('b.txt',b,delimiter=',')

w1,u1,b1=mo.layers[3].get_weights()
print(w1.shape,u1.shape,b1.shape)
np.savetxt('w1.txt',w1,delimiter=',')
np.savetxt('u1.txt',u1,delimiter=',')
np.savetxt('b1.txt',b1,delimiter=',')

w2,u2,b2=mo.layers[4].get_weights()
print(w2.shape,u2.shape,b2.shape)
np.savetxt('w2.txt',w2,delimiter=',')
np.savetxt('u2.txt',u2,delimiter=',')
np.savetxt('b2.txt',b2,delimiter=',')

w3,b3=mo.layers[6].get_weights()
print(w3.shape,b3.shape)
np.savetxt('w3.txt',w3,delimiter=',')
np.savetxt('b3.txt',b3,delimiter=',')

mo=load_model('/content/gdrive/My Drive/Save_models/multiLstm4.h5')

mo.summary()

'''
def Testpredict(prte):
  for j in range(51,99):
    shakhes=j/100
    t,f,s=0,0,0
    for i in range(datax_test.shape[0]):
      if   (datay_test[i]>=0.5)and(prte[i]>  shakhes):
        t=t+1
      elif (datay_test[i]<=0.5)and(prte[i]<1-shakhes):
        t=t+1
      elif (datay_test[i]> 0.5)and(prte[i]<1-shakhes):
        f=f+1
      elif (datay_test[i]< 0.5)and(prte[i]>  shakhes):
        f=f+1  
    if t+f>3000:    
      print('\n'+"True    TEST Signals for shakhes",j,"is:",t+f,"   (",int(t/(t+f)*10000)/100,"%)")
    else:
      break
'''

'''
def Testpredict(prte):
  for j in range(50,100):
    shakhes=j/100
    t,f=0,0
    for i in range(10):
      if   (datay_test[i]>=0.5)and(prte[i]>=  shakhes)and(prte[i]<  shakhes+0.01):
        t=t+1
        print(datay_test[i],prte[i],1)
      elif (datay_test[i]<=0.5)and(prte[i]<=1-shakhes)and(prte[i]>  shakhes-0.01):
        t=t+1
        print(datay_test[i],prte[i],2)
      elif (datay_test[i]> 0.5)and(prte[i]<=1-shakhes)and(prte[i]>  shakhes-0.01):
        f=f+1
        print(datay_test[i],prte[i],3)
      elif (datay_test[i]< 0.5)and(prte[i]>=  shakhes)and(prte[i]<  shakhes+0.01):
        f=f+1  
        print(datay_test[i],prte[i],4)
    if t+f>1:    
      print('\n'+"True    TEST Signals for shakhes",j,"is:",t+f,"   (",int(t/(t+f)*10000)/100,"%)")
'''

'''
drive.mount('/content/gdrive')
mo=load_model('/content/gdrive/My Drive/Save_models/multiLstm1.h5')
#------------------------------------------------------------------------
mo.summary()
#------------------------------------
test=[]
prte=mo.predict(datax_test[:,:,:in2_len])
Testpredict(prte)
#------------------------------------------
h,l,c=0,0,0
for i in range(prte.shape[0]):
  if prte[i]>  0.79:
    h=h+1
  if prte[i]<1-0.79:
    l=l+1
print(h,l)
'''

'''
drive.mount('/content/gdrive')
mo=load_model('/content/gdrive/My Drive/Save_models/multiLstm7.h5')
#--------------------------------------------------------------------
mo.summary()
#------------------------------------------
test=[]
prte=mo.predict(datax_test[:,:,:in2_len])
Testpredict(prte)
'''

drive.mount('/content/gdrive')
!unzip "/content/gdrive/My Drive/data10.zip"
data=pd.read_csv('data10.csv',names=["v1","v2","v3","v4","v5","v6","v7","v8","v9","v10","v11","v12","v13","v14","v15","v16","v17","v18","v19","v20","v21","v22","v23"])  
#datainput=np.loadtxt('data9.csv',delimiter=',',dtype='float32')

datainput=data.get(["v7","v20","v21"]).values[:]
datainput=np.array(datainput,'float32')
for i in range(datainput.shape[0]):
  datainput[i,1]=datainput[i,1]/130
  datainput[i,2]=datainput[i,2]/130
input_len  =200
train_len  =550000
test_len   =len(datainput)-train_len-input_len
datax      =[]
datay      =[]
datax_train=[]
datay_train=[]
datax_test =[]
datay_test =[]
#-----------------------------------------------------
for i in range(input_len-1,len(datainput)):
   datax.append( datainput[i-input_len+1:i+1,1:] )
   datay.append( datainput[i,0] )
datax=np.array(datax)
datay=np.array(datay)
#--------------------------------------------------
#for i in range(datax.shape[0]):
  #for h in range(input_len-1,-1,-1):
  #  datax[i,h,0]=(datax[i,h,0]/datax[i,0,0])-1
  #for j in range(0,2):
 #   ma=max(datax[i,:,j])
  #  mi=min(datax[i,:,j])
   # datax[i,:,j]=(datax[i,:,j]-mi)/(ma-mi)
#------------------------------------------------
datax_train=datax[:train_len,:,:]
datay_train=datay[:train_len]
datax_test =datax[train_len:,:,:]
datay_test =datay[train_len:]