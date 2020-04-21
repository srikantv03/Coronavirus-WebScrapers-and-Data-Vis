import requests
from bs4 import BeautifulSoup

#covid tracking projects, johns hopkins
URL = "https://covidtracking.com/data/"
htmlout = requests.get(URL)
soup = BeautifulSoup(htmlout.content, 'html.parser')

#create array of alphabetical state abbrev. (if needed)

listItems = soup.find_all('li', class_='state-item')

#looks through list items for the data
for i in range (0, 49):
	data = listItems[i]
	stateName = data.find('h2', class_='state-name')
	numericData = data.find_all('div', class_='state-flex-data')
	positives = numericData[0]
	negatives = numericData[1]
	pending = numericData[2]
	hospitalized = numericData[3]
	deaths = numericData[4]
	totalTestResults = numericData[5]
	print(stateName.text, end = '\n')
	print('Positive Results: ' + positives.text, end = '\n')
	print('Negative Results: ' + negatives.text, end = '\n')
	print('Total Test Results: ' + totalTestResults.text, end = '\n')
	print('Deaths Results: ' + deaths.text, end = '\n')
	#print('Hospitalized Results: ' + hospitalized.text, end = '\n')


