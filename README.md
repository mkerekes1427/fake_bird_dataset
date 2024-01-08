I wanted to do a MySQL project, and since I'm interested in birds I decided to generate some various data regarding bird obersvations in an
Excel file. All of the data in this repository is not real. These are fake observations, dates, numerical values, etc. although the species' names are real. So, some rows may not have data that would make sense in the real world, like for example, the area name of a desert corresponding to the
state of New Jersey or an unrealistic bird count being observed. The data was shuffled around in Excel along with using Excel's autofill so that I didn't have to input lots of data by hand. I also used python to copy dates for a specific observation id occurring on the same day, although I deleted the python script because it was no longer needed once I imported the data back into Excel. 

The website ebird.org is a place where bird enthusiasts can go and report observations of birds. They can report things like species seen, counts for each species, location name, date, etc. Since I don't have access to their real data, I decided to make a mini relational database schema of my own--although it's fake--to display my MySQL skills. I tried to imagine what ebird's actual database structure would look like, what kinds of information it would contain, and then tried to create something similar.

There are three tables: observations, bird_species, and areas. The observations table is the main table and has an observation id, bird_id, and area_id, which link to the ids in the bird_species and areas tables. I decided to upload my MySQL script file which contains all the queries I ran, and I uploaded a link to a video that shows the outputs of each query too.

The observations table had close to 8400 records, with 301 unique observation ids.

I'd like to shoutout Alex the Analyst and his YouTube channel for inspiring me to have the idea of writing my own MySQL scripts for the sake of portfolio experience.

Here is the link to my YouTube video showing the output of all the queries:
https://www.youtube.com/watch?v=a2iXTNDU5p8
