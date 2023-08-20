# code that turns minutes into hours and minutes
while True:
    minutes = int(input('Enter the number of minutes: '))
    if minutes < 0:
        print('Invalid input')
    else:
        print(str(minutes//60) + ':' + str(minutes%60) )