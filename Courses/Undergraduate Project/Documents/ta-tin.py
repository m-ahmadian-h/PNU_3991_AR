# -*- coding: utf-8 -*-
"""taghviatin.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1e1IQEEhyWXzUSwlY68J3W2_6Kkt8S-Xa
"""

# Commented out IPython magic to ensure Python compatibility.
# %tensorflow_version 1.x
import tensorflow as tf
from google.colab import drive
import numpy as np
import tensorflow.keras.backend as K
import tensorflow.keras as ks
import random
import timeit
#!pip install tpucolab
#import os
#import google as gg
from tensorflow.keras.models import  Sequential , Model , load_model
from tensorflow.keras.layers import  Dense , Dropout , Flatten , Conv2D , MaxPooling2D , InputLayer , Input
import matplotlib.pyplot as plt
#from multiprocessing import Pool
#import time
#from tensorflow.keras.models import load_model
#import zipfile
#import pprint
#from tpucolab import *
from tensorflow.python.client import device_lib
#!cat /proc/meminfo
#!cat /proc/cpuinfo
#!pip install --upgrade tensorflow
print('>>> tensorflow version: ***',tf.__version__,'***')
#print(device_lib.list_local_devices())

drive.mount('/content/gdrive')
!unzip "/content/gdrive/My Drive/eurusd.zip"
datainput=np.loadtxt('eurusd.csv',delimiter=',',dtype='float16')

class Agent(object):

  def __init__(self,ALPHA=0.0005,GAMMA=0.99,n_actions=2,fname='taghviati.h5'):
    self.gamma=GAMMA
    self.lr=ALPHA
    self.n_actions=n_actions
    self.state_memory=[]
    self.action_memory=[]
    self.reward_memory=[]
    self.action_space=[0,1]
    self.model_file=fname
    self.G=[]
    self.policy,self.predict=self.build_policy_network()
    self.ehtemal=0
#-----------------------------------------------------------
  def build_policy_network(self):#sakhte model
    advantages=Input(shape=[1])#sakhte ye shabake mojazza baraye mohasebe tabe loss#??????????????????????????????????
    inputlayer=Input( shape=(91,) )
    layer=tf.keras.layers.Dense(40, activation='sigmoid')(inputlayer)
    layer=tf.keras.layers.Dense(30, activation='relu')(layer)
    #layer=tf.keras.layers.Dense(32, activation='relu')(layer)
    outlayer=tf.keras.layers.Dense(self.n_actions, activation='softmax')(layer)
    def custom_loss(y_true,y_pred):#mohasebe tabe loss
      out=K.clip(y_pred,1e-7,1-1e-7)
      log_lik=y_true*K.log(out)
      return K.sum(-log_lik*advantages)
    policy=tf.keras.Model(inputs=[inputlayer,advantages],outputs=[outlayer])
    policy.compile(optimizer=tf.keras.optimizers.Adam(lr=self.lr),loss=custom_loss)
    predict=Model(inputs=[inputlayer],outputs=[outlayer])
    return policy,predict
#-----------------------------------------------------------------------
  def choose_action(self,observation):#entekhabe action bar asase model
    probabilities=self.predict.predict(observation.reshape(1,len(observation)))[0]####input of predict
    action=np.random.choice(self.action_space,p=probabilities)
    
    self.ehtemal=probabilities
    return action
#-----------------------------------------------------------------------------------------------
  def store_transition(self,observation,action,reward):#bad az har frame data ra zakhire mikonad
    self.state_memory.append(observation)
    self.action_memory.append(action)
    self.reward_memory.append(reward)
#----------------------------------------
  def gg(self):
    g=np.zeros(len(self.reward_memory))
    last=0
    for i in range(len(g)-1,-1,-1):
      if self.action_memory[i]==1:
        last=self.reward_memory[i]
      else:
        last=last*self.gamma  
      g[i]=last
    return g  

#--------------------------------------
  def g1(self):
    g=np.zeros(len(self.reward_memory))
    tt=sum(self.reward_memory)
    last=0
    for i in range(len(g)-1,-1,-1):
      if self.action_memory[i]==1:
        last=tt/10
      else:
        last=last*self.gamma  
      g[i]=last
    return g   
#-----------------------------------------
  def g2(self):
    g=np.zeros(len(self.reward_memory))
    last=sum(self.reward_memory)
    for i in range(len(g)-1,-1,-1):
      last=last*self.gamma  
      g[i]=last
    g[len(g)-1]=sum(self.reward_memory)
    return g   
#---------------------------------------
  def g3(self):
    g=np.zeros(len(self.reward_memory))
    last=sum(self.reward_memory)
    alpha=last/g.shape
    for i in range(1,len(g)):
      er=last-alpha*i
      g[len(g)-1-i]=er
    g[len(g)-1]=sum(self.reward_memory)
    return g   
#------------------------------------------------
  def learn(self):#tabdile list be arraye
    state_memory=np.array(self.state_memory)
    action_memory=np.array(self.action_memory)
    reward_memory=np.array(self.reward_memory)
    actions=np.zeros([len(action_memory),self.n_actions])

    for i in range(len(actions)):#tabdile action be do halat baraye shabake
      if action_memory[i]==0:
        actions[i,0]=1
      elif action_memory[i]==1:
        actions[i,1]=1

    self.G=self.gg()

    cost=self.policy.train_on_batch([state_memory,self.G],actions)#train,Runs a single gradient update on a single batch of data.
    self.state_memory=[]
    self.action_memory=[]
    self.reward_memory=[]

    return cost

class Trade(object):

  def __init__(self,datainput,num_trade=10):
    self.data=datainput
    #self.rew=rew
    self.startCandelTrade=0
    self.reward=0
    self.countTrade=0
    self.doneRew=0
    self.tedTr=0
    self.stepp=1
    self.save_reward=[]
    self.save_real_reward=0
    self.save_trade_number=[]
    self.tp=0
    self.num_trade=num_trade
#--------------------------------
  def reset(self):
    done=False
    self.save_reward=[]
    self.save_real_reward=0
    self.save_trade_number=[]
    self.startCandelTrade=0
    self.reward=0
    self.doneRew=0
    self.countTrade=0
    self.tedTr=1
    self.stepp=1
    self.save_real_reward=0
    return self.getData()
#----------------------------------------------------
  def nexttrade(self):
    if self.startCandelTrade % 120 ==0:
      self.startCandelTrade=self.startCandelTrade+36
    else:
      self.startCandelTrade=self.startCandelTrade+12
    self.tedTr=self.tedTr+1
    self.stepp=1
    self.tp=self.doneRew
    done=False
    return self.getData(),self.tp,done
#--------------------------------------
  def step(self,action):
     self.countTrade=self.countTrade+1

     self.tp=0
     if action==1 and self.stepp>0: #close trade
       if self.data[self.startCandelTrade,90+self.stepp]>=5:
            self.tp=1
       else:
            self.tp=-1
       self.save_real_reward=self.save_real_reward+self.tp
       
       if self.stepp==42:
         self.tp=self.tp-25
       elif self.stepp==43:
         self.tp=self.tp-30
       elif self.stepp==44:
         self.tp=self.tp-35
       elif self.stepp==45:
         self.tp=self.tp-40   
       
       if self.stepp==46:
         self.tp=self.tp-45
       if self.stepp>=47:
         self.tp=self.tp-50
       

       
       self.reward=self.reward+self.tp
       if self.startCandelTrade % 120 ==0:
         self.startCandelTrade=self.startCandelTrade+36
       else:
         self.startCandelTrade=self.startCandelTrade+12
       self.tedTr=self.tedTr+1
       self.stepp=1
     if action==0 or self.stepp==0:
       self.stepp = self.stepp+1
     if self.stepp>46:
       return self.chekdone()
     else:
       done=self.chekdone()
       self.tp=self.tp+self.doneRew
       self.reward=self.reward+self.doneRew
       if done==True:
         self.save_reward.append(self.reward)
         self.save_trade_number.append(self.tedTr)
       return self.getData(),self.tp,done
#--------------------------------------------------
  def getData(self):
    return (self.data[self.startCandelTrade+self.stepp,:91])
#--------------------------------------------------------------
  def chekdone(self):
     if self.tedTr>self.num_trade:
       return True
     #if self.countTrade>100:
       #self.doneRew=-100
     #  return True
     #if (self.reward-self.tp)<=-10:
     #  self.doneRew=-100
       #return True
     if self.stepp>46:
       #self.stepp=0
       #self.startCandelTrade=self.startCandelTrade+1
       self.doneRew=-100
       #self.stepp=0
       a,b,c=self.nexttrade()
       return a,b,c
     self.doneRew=0  
     return False

def test():  
  #agent.policy.load_weights('/content/gdrive/My Drive/taghviati0.h5')
  true,false,summ,num=0,0,0,0
  for i in range(47000,52000,12):
    j=1
    while j<=47:
      if agent.predict.predict(datainput[i+j,:91].reshape(1,91))[0,1]>=agent.predict.predict(datainput[i+j,:91].reshape(1,91))[0,0]:
        '''
        if j==0:
          num=num+j
          break
        '''
        summ=summ+datainput[i,90+j]
        if datainput[i,90+j]>=0:
          true=true+1
        if datainput[i,90+j]<0:
          false=false+1
        num=num+j
        #print(j)
        break
      j=j+1
    if j==48:
      summ=summ+datainput[i,90+48]
  kol=false+true
  if kol==0:
    print(int(summ))
  else:
    print("sum:",int(summ),"   true:",int(true/kol*1000)/10,"%   false:",int(false/kol*1000)/10,"%   trade:",kol,"   close:",int(num/kol*10)/10)
  return (true/417*100)

agent=Agent(ALPHA=0.0005,n_actions=2,GAMMA=0.99)

trade=Trade(datainput=datainput,num_trade=3000)

sabeghe=[]
def start():
  drive.mount('/content/gdrive')
  agent.policy.load_weights('/content/gdrive/My Drive/taghviati6.h5')
  #x=!cat /content/gdrive/My\ Drive/number.1.txt
  best=-586#int(x[0])
  print("best:",best)
  num_episodes=10000
  for i in range(num_episodes):
    done=False
    observation=trade.reset()
    while not done:
      action=agent.choose_action(observation)
      observation_,reward,done=trade.step(action)
      agent.store_transition(observation,action,reward)
      observation=observation_
      #print(trade.stepp,'    ',trade.tp)
    _=agent.learn()
    #if i % 100==0:
    print('epi:',i,'   trade:',trade.tedTr-1,'   count:',trade.countTrade/(trade.tedTr),
          '   p:',agent.ehtemal,'   reward:',trade.reward,'   real reward:',trade.save_real_reward,'   best:',best)
    if trade.reward>=best:
      sa=str(trade.reward)
      best=trade.reward
      #with open('/content/gdrive/My Drive/number.1.txt', 'w') as f:
      #  f.write(sa)
      agent.policy.save_weights('/content/gdrive/My Drive/taghviatin.h5')
      print('\n',"     ***** best:",best,"   with count:",trade.countTrade/(trade.tedTr),"   *****",'\n')
      f=int(test()*10)
      sabeghe.append((f)/10)
      print('\n',sabeghe,'\n')

start()

1plt.plot(agent.reward_memory,'b')
plt.plot(agent.G,'r')

#agent.policy.save_weights('/content/gdrive/My Drive/taghviati3.h5')

sa=0
sa=str(sa)
with open('/content/gdrive/My Drive/number.1.txt', 'w') as f:
        f.write(sa)