from openpyxl import *

wb = Workbook()
ws = wb.active
ws.title = 'Table 1'
timechoice = input('How many minutes ago? ')
locationchoice = input('Where did this happen? ')
eventchoice = input('What happened? ')
message = input('Additional comments: ')
input = [timechoice, locationchoice, eventchoice, message]
for row in wb.rows:
    if len(row.value) == 0:
        row[0] = input[0]
        row[1] = input[1]
        row[2] = input[2]
wb.save()
