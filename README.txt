### Making Young Voters

To Learn More: Visit https://www.jamescwang.com/posts/vote

For 2018-2019 Data team

We have put all our codescripts in the rmd file and all data sets in the all_data_set file. 
Latex file is just for the pdf and latex. 

You may want to change the working directory for rmd and other codescripts since we reogranized all the files. 
The titles for RMD are self-explanatory. 

Thank you 


schoolMapMerge.R:

We merged the survey data with school size data, school address data, and 2016 election result data. We further calculated the number of civic courses offered by school.
The final data is saved in OutputDataset/df_v_size_course.csv 

BassWordCloud.ipynb (jupyter notebook) inside the wordcloud folder:

This is a way to create fancy wordcloud masked on a “checkbox” image.

map.twbx:  (Tableau): 
df_v_size_course.csv  was the dataset we used
This is mostly for maps. Because I couldn’t figure out how to plot the 2016 election by county map layer onto the school map, I ended up “screenshot” and used the former as the background image, and map the school map layer onto it based on their latitude and longitude for the four corners of NC. Other details in Tableau should be easy to understand. There weren’t many calculated field either, since the data was already preprocessed in R

 Contact:
James Wang: cw261@duke.edu / dantewang1997@gmail.com

Rmd files in the r_scriptsForMergingAndProcessing are divded into three parts. Graphs_for_presentation is for all the visuals we used in the final poster. Crosstab was used to see correlation between some variables we found interesting. Dimtable and barplots are just one dimensional analysis. Overall file is how we cleaned up the data. Thank you  
Donghun Lee: pandawithcat@gmail.com / dl199@duke.edu
