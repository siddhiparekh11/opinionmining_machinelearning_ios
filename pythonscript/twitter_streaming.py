
# coding: utf-8

# In[7]:


try:
    import json
except ImportError:
    import simplejson as json

# Import the necessary methods from "twitter" library
from twitter import Twitter, OAuth, TwitterHTTPError, TwitterStream

# Variables that contains the user credentials to access Twitter API 
ACCESS_TOKEN = ''
ACCESS_SECRET = ''
CONSUMER_KEY = ''
CONSUMER_SECRET = ''

#oauth = OAuth(ACCESS_TOKEN, ACCESS_SECRET, CONSUMER_KEY, CONSUMER_SECRET)
t=Twitter(auth=OAuth(ACCESS_TOKEN, ACCESS_SECRET, CONSUMER_KEY, CONSUMER_SECRET))

# Initiate the connection to Twitter Streaming API
import os


env_var=os.environ.get('flightname')
twitter_data = t.search.tweets(q=env_var)

##with open('/Users/siddhiparekh11/Desktop/file.txt', 'w') as f:
str=json.dumps(twitter_data)
  ##  f.write(str)
    ##print(str)
parsed_data=json.loads(str)
print parsed_data
#print json.dumps(twitter_data)  

    
    # The command below will do pretty printing for JSON data, try it out
    # print json.dumps(tweet, indent=4)
       
  


# In[81]:


#import csv


# In[8]:


parsed=parsed_data['statuses']
parsed


# In[16]:



import csv
import re
myfile=open('csv65_file.csv', 'w')
csvwriter = csv.writer(myfile)
count = 0
strarr=[]
for strr in parsed:
     
    if count == 0:

        header = strr.keys()

        csvwriter.writerow(header)

        count += 1
            
    
    else:
        for st in strr.values():
               if isinstance(st,basestring):
                      strarr.append(re.sub(r'[^\x00-\x7F]+',' ', st))
           
               else:
                strarr.append("")
            
        csvwriter.writerow(strarr)
        del strarr[:]
myfile.close()


# In[20]:


import pandas
import csv


# In[50]:


Outtweets=pandas.read_csv("csv65_file.csv",error_bad_lines=False,index_col=False)


# In[51]:


Outtweets.head()


# In[53]:


'''del Outtweets['contributors']
del Outtweets['truncated']
del Outtweets['is_quote_status']
del Outtweets['in_reply_to_status_id']
del Outtweets['id']
del Outtweets['favorite_count']
del Outtweets['source']
del Outtweets['retweeted']
del Outtweets['coordinates']
del Outtweets['favorited']
del Outtweets['user']
del Outtweets['geo']
del Outtweets['in_reply_to_user_id']
del Outtweets['possibly_sensitive']
del Outtweets['lang']
del Outtweets['created_at']
del Outtweets['in_reply_to_status_id_str']
del Outtweets['place']
del Outtweets['metadata']'''


# In[65]:


Outtweets.head()


# In[66]:


'''del Outtweets['entities']
del Outtweets['in_reply_to_screen_name']
del Outtweets['id_str']
del Outtweets['retweet_count']
del Outtweets['in_reply_to_user_id_str']'''


# In[67]:


Outtweets.head()


# In[68]:


Outtweets


# In[54]:


import nltk
from nltk.corpus import stopwords


# In[55]:


def tweet_to_words(raw_tweet):
    letters_only = re.sub("[^a-zA-Z]", " ",raw_tweet) 
    words = letters_only.lower().split()                             
    stops = set(stopwords.words("english"))                  
    meaningful_words = [w for w in words if not w in stops] 
    return( " ".join( meaningful_words )) 


# In[56]:


#Outtweets['text']
Outtweets['clean_tweet']=Outtweets['text'].apply(lambda x: tweet_to_words(x))


# In[57]:


Outtweets


# In[58]:


Traintweets=pandas.read_csv("/Users/siddhiparekh11/Desktop/Trainfeatures4_file.csv")


# In[59]:


Traintweets


# In[60]:


train_clean_arr=[]
for t in Traintweets['clean_tweets']:
    train_clean_arr.append(t)
    


# In[61]:


test_clean_arr=[]
for t in Outtweets['clean_tweet']:
    test_clean_arr.append(t)


# In[62]:


from sklearn.feature_extraction.text import CountVectorizer
v = CountVectorizer(analyzer = "word")
train_feature= v.fit_transform(train_clean_arr)
test_feature=v.transform(test_clean_arr)


# In[63]:


test_feature


# In[64]:


test_feature.toarray()


# In[65]:


import numpy
numpy.savetxt("feature55_test.csv", test_feature.todense(), delimiter=',')

