# News Application

## Project description
Create a news application with next features:
* All news
* Top headers
* Saved news

I've used libraries like: 
* Snapkit 
* Alamofire

Snapkit for autolayout and Alamofire for parsing JSON data from API


The all news tab was implemented, where you can see the latest news in detail and in detail. Then the next tab is the top headlines where the most popular news will be displayed. Of course, in two tabs you can go and see the news in detail.

The original saved data was saved to the local memory when there is no internet connection. Only uploaded data will be displayed. And when there is an Internet connection, we will continue to download the data. In this case, I saved in User Defaults.

Implemented the favorites tab, where it can store the data we need. Of course, there is also a function where you can delete data from the favorites tab.
